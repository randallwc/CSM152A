`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Testbench for floating-point converter.
////////////////////////////////////////////////////////////////////////////////

module testbench_305109767;

	// Inputs
	reg [12:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [4:0] F;
	
	// Expected values
	reg expected_S;
	reg [2:0] expected_E;
	reg [4:0] expected_F;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(D), 
		.S(S), 
		.E(E), 
		.F(F)
	);

	initial begin
		/* Basic Cases */
		
		// Positive sign no rounding 
		#0  D = 13'b0_1101_0010_0000; expected_S = 0; expected_E = 7; expected_F = 5'b11010;
		#10 D = 13'b0_0101_0100_0000; expected_S = 0; expected_E = 6; expected_F = 5'b10101;
		#10 D = 13'b0_0000_1010_0000; expected_S = 0; expected_E = 3; expected_F = 5'b10100;
		#10 D = 13'b0_0000_0000_0010; expected_S = 0; expected_E = 0; expected_F = 5'b00010;
		#10 D = 13'b0_0000_0000_0001; expected_S = 0; expected_E = 0; expected_F = 5'b00001;

		// Negative sign no rounding
		#10 D = 13'b1_0010_1110_0000; expected_S = 1; expected_E = 7; expected_F = 5'b11010;		
		#10 D = 13'b1_1010_1100_0000; expected_S = 1; expected_E = 6; expected_F = 5'b10101;
		#10 D = 13'b1_1111_0110_0000; expected_S = 1; expected_E = 3; expected_F = 5'b10100;
		#10 D = 13'b1_1111_1111_1110; expected_S = 1; expected_E = 0; expected_F = 5'b00010;
		#10 D = 13'b1_1111_1111_1111; expected_S = 1; expected_E = 0; expected_F = 5'b00001;
		
		// Positive sign with rounding 
		#10 D = 13'b0_1101_0110_0000; expected_S = 0; expected_E = 7; expected_F = 5'b11011;
		#10 D = 13'b0_0101_0110_0000; expected_S = 0; expected_E = 6; expected_F = 5'b10110;
		#10 D = 13'b0_0000_1010_0100; expected_S = 0; expected_E = 3; expected_F = 5'b10101;

		//	Negative sign with rounding
		#10 D = 13'b1_0010_1010_0000; expected_S = 1; expected_E = 7;  expected_F = 5'b11011;		
		#10 D = 13'b1_1010_1010_0000; expected_S = 1; expected_E = 6; expected_F = 5'b10110;
		#10 D = 13'b1_1111_0101_1100; expected_S = 1; expected_E = 3; expected_F = 5'b10101;
        
		/* Edge cases */
		
		// Positive overflow rounding, increase exponent
		#10 D = 13'b0_0111_1110_0000; expected_S = 0; expected_E = 7; expected_F = 5'b10000;
		#10 D = 13'b0_0000_1111_1100; expected_S = 0; expected_E = 4; expected_F = 5'b10000;
		#10 D = 13'b0_0011_1111_0100; expected_S = 0; expected_E = 6; expected_F = 5'b10000;
		
		//	Negative sign with rounding, increase exponent
		#10 D = 13'b1_1000_0010_0000; expected_S = 1; expected_E = 7; expected_F = 5'b10000;		
		#10 D = 13'b1_1111_0000_0100; expected_S = 1; expected_E = 4; expected_F = 5'b10000;
		#10 D = 13'b1_1100_0000_1100; expected_S = 1; expected_E = 6; expected_F = 5'b10000;
		
		// Largest possible Floating-Point Representation
		#10 D = 13'b0_1111_1111_1111; expected_S = 0; expected_E = 7; expected_F = 5'b11111;
		#10 D = 13'b1_0000_0000_0000; expected_S = 1; expected_E = 7; expected_F = 5'b11111;
		#10 $stop;
	end
		
	//Test Results
	initial
		$monitor("time=%d, D=%b, S=%b, E=%b, F=%b, expected_S=%b, expected_E=%b, expected__F=%b",
				$time, D, S, E, F, expected_S, expected_E, expected_F);
      
endmodule

