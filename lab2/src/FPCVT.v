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
	
   // ===========================================================================
   // Converter
   // ===========================================================================

   converter converter_instance (// Outputs
             .sign                 (converter_sign),
             .magnitude            (converter_magnitude),
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
             .magnitude                 (convert_magnitude),
             /*AUTOINST*/
             // Inputs
             .clk                       (clk));
   
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