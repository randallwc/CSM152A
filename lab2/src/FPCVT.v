module nexys3 (/*AUTOARG*/
   // Outputs
   sign, exponent, significand,
   // Inputs
   analog, clk
   );
      
   // Misc.
   input  [11:0] analog;
   output        sign;
	output [2:0]  exponent;
   output [3:0]  significand;
   
   // Logic
   input         clk;                  // 100MHz
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire        convert_sign;        // From converter module
   wire [11:0] convert_magnitude;   // From converter module
	wire [2:0]  count_exponent;      // From zero-counter
	wire [3:0]  extract_significand; // From extracter
	wire        extract_fifth;       // From extracter
	wire [2:0]  round_exponent;    // From rounder
	wire [3:0]  round_significand; // From rounder
   // End of automatics
   
	// Add more registers as needed
	// May need to add validation logic
	
	assign sign = convert_sign;
	assign exponent = round_exponent;
	assign significand = round_significand;
	
   // ===========================================================================
   // Converter
   // ===========================================================================

   converter converter_instance (// Outputs
             .sign                 (convert_sign),
             .magnitude            (convert_magnitude),
             // Inputs
             .analog               (analog),
             /*AUTOINST*/
             // Inputs
             .clk                  (clk));
   
   // ===========================================================================
   // Counter
   // ===========================================================================

   counter counter_instance (// Outputs
             .exponent                 (count_exponent),
             // Inputs
             .magnitude                (convert_magnitude),
             /*AUTOINST*/
             // Inputs
             .clk                      (clk));
   
   // ===========================================================================
   // Extracter
   // ===========================================================================

   extracter extracter_instance (// Outputs
             .significand          (extract_significand),
             .fifth                (extract_fifth),
             // Inputs
             .magnitude            (convert_magnitude),
             /*AUTOINST*/
             // Inputs
             .clk                  (clk));
				 
   // ===========================================================================
   // Rounder
   // ===========================================================================

   rounder rounder_instance (// Outputs
             .o_exponent           (round_exponent),
             .o_significand        (round_significand),
             // Inputs
             .i_exponent           (count_exponent),
             .i_significand        (extract_significand),
             .i_fifth              (extract_fifth),
             /*AUTOINST*/
             // Inputs
             .clk                       (clk));
   
endmodule // nexys3
// Local Variables:
// verilog-library-flags:("-f ../input.vc")
// End:

module converter (/*AUTOARG*/
   // Outputs
   sign, magnitude,
   // Inputs
   analog, clk
   );
	
	// Misc.
   input  [11:0] analog;
   output        sign;
	output [11:0] magnitude;
	
	reg [3:0] i;
	reg [11:0] flipped_analog;
   
   // Logic
   input         clk;                  // 100MHz
	
	// Assignment
	always @(posedge clk)
	begin
		for (i=0; i<12; i = i+1)
		begin
			flipped_analog[i] = !analog[i];
		end
	end

	assign magnitude = flipped_analog + 1;
	
	assign sign = analog[11];
	
endmodule // converter

module counter (/*AUTOARG*/
   // Outputs
   exponent,
   // Inputs
   magnitude, clk
   );
	
	// Misc.
   input  [11:0] magnitude;
	output [2:0]  exponent;
	
	reg [2:0] exponent_reg;
	reg [3:0] zero_count;
	reg [3:0] i;
   
   // Logic
   input         clk;                  // 100MHz
	
	// Assignment
	initial
	begin
		zero_count = 0;
		exponent_reg = 0;
	end
	
	always @(posedge clk)
	begin
		zero_count = 0;
		for (i=11; i>=0; i = i-1)
		begin
			if (!magnitude[i])
			begin
				zero_count = zero_count + 1;
			end
			else
			begin
				i = -1;
			end
		end
		
		if (zero_count >= 8)
		begin
			exponent_reg = 0;
		end
		else
		begin
			exponent_reg = (zero_count == 7 ? 1 : (zero_count == 6 ? 2 : (zero_count == 5 ? 3 : (zero_count == 4 ? 4 : (zero_count == 3 ? 5 : (zero_count == 2 ? 6 : 7))))));
		end
	end
	
	assign exponent = exponent_reg;
	
endmodule // counter

module extracter (/*AUTOARG*/
   // Outputs
   significand, fifth,
   // Inputs
   magnitude, clk
   );
	
	// Misc.
   input  [11:0] magnitude;
   output [3:0]  significand;
	output        fifth;
	
	reg [11:0] magnitude_reg;
	reg [3:0] i;
	reg [3:0] push_reg;
	reg fifth_reg;
   
   // Logic
   input         clk;                  // 100MHz
	
	// Assignment
	initial
	begin
		push_reg = 0;
	end
	
	always @(posedge clk)
	begin
		magnitude_reg = magnitude;
		for (i=11; i>=0; i = i-1)
		begin
			if (i <= 3)
			begin
				push_reg = magnitude_reg[11:8];
				fifth_reg = 0;
			end
			else
			begin
				if (magnitude[11])
				begin
					push_reg = magnitude_reg[11:8];
					fifth_reg = magnitude_reg[7];
					i = -1;
				end
				else
				begin
					magnitude_reg = {magnitude_reg[10:0],1'b0};
				end
			end
		end
	end
	
	assign magnitude = magnitude_reg;
	assign fifth = fifth_reg;
	
endmodule // extracter

module rounder (/*AUTOARG*/
   // Outputs
   o_exponent, o_significand,
   // Inputs
   i_exponent, i_significand, i_fifth, clk
   );
	
	// Misc.
   input  [2:0]  i_exponent;
	input  [3:0]  i_significand;
	input         i_fifth;
   output [2:0]  o_exponent;
	output [3:0]  o_significand;
	
	reg [2:0]  exponent_reg;
	reg [3:0]  significand_reg;
   
   // Logic
   input         clk;                  // 100MHz
	
	// Assignment
	initial
	begin

	end
	
	always @(posedge clk)
	begin
		if (i_fifth)
		begin
			if (i_significand == 15)
			begin
				if (i_exponent == 7)
				begin
					exponent_reg = i_exponent;
					significand_reg = i_significand;
				end
				else
				begin
					significand_reg = 8;
					exponent_reg = i_exponent + 1;
				end
			end
			else
			begin
				exponent_reg = i_exponent;
				significand_reg = i_significand + 1;
			end
		end
		else
		begin
			exponent_reg = i_exponent;
			significand_reg = i_significand;
		end
	end
	
	assign o_exponent = exponent_reg;
	assign o_significand = significand_reg;
	
endmodule // rounder