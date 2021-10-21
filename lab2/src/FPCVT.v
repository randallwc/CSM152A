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
	
	reg [11:0] flipped_analog;
   
   // Logic
   input         clk;                  // 100MHz
	
	// Assignment
	assign flipped_analog = !analog;
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
	
	reg [3:0] zero_count;
   
   // Logic
   input         clk;                  // 100MHz
	
	// Assignment
	initial
	begin
		zero_count = 0;
	end
	
	always @(posedge clk)
	begin
		zero_count = 0;
		for (i=11; i>=0; i = i-1)
		begin
			if (!magnitude[i])
			begin
				zero_count <= zero_count + 1;
			end
			else
			begin
				i <= -1;
			end
		end
		
		if (zero_count >= 8)
		begin
			exponent <= 0;
		end
		else
		begin
			exponent <= (zero_count == 7 ? 1 : (zero_count == 6 ? 2 : (zero_count == 5 ? 3 : (zero_count == 4 ? 4 : (zero_count == 3 ? 5 : (zero_count == 2 ? 6 : (zero_count == 1 ? 7 : 8)))))));
		end
	end
	
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
	
	reg [3:0] push_reg;
   
   // Logic
   input         clk;                  // 100MHz
	
	// Assignment
	initial
	begin
		push_reg = 0;
	end
	
	always @(posedge clk)
	begin
		for (i=11; i>=0; i = i-1)
		begin
			if (i <= 3)
			begin
				push_reg = magnitude[3:0];
				fifth = 0;
			end
			else
			begin
				push_reg = magnitude[i:i-3];
				if (push_reg[3])
				begin
					fifth = magnitude[i-4];
					i = -1;
				end
			end
		end
	end
	
endmodule // converter