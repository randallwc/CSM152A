`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:15:39 12/08/2021
// Design Name:   synthesizer
// Module Name:   C:/Users/wrand/Desktop/CSM152A/snake/tb/tb_synthesizer.v
// Project Name:  snake_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: synthesizer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_synthesizer;

	// Inputs
	reg clk;
	reg [11:0] in_freq;
	reg signal;

	// Bidirs
	wire [3:0] JA;

	// Instantiate the Unit Under Test (UUT)
	synthesizer uut (
		.clk(clk), 
		.in_freq(in_freq), 
		.signal(signal), 
		.JA(JA)
	);
    
    always #1 clk = ~ clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		in_freq = 440;
		signal = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        signal = 1;
        #10000;
		// Add stimulus here
        $finish;

	end
      
endmodule

