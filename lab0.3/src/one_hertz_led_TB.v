`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:04:51 09/29/2021
// Design Name:   one_hertz_led
// Module Name:   /home/ise/CSM152A/lab0.3/src/one_hertz_led_TB.v
// Project Name:  lab0.3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: one_hertz_led
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module one_hertz_led_TB;

	// Inputs
	reg clk_tb;

	// Outputs
	wire led_tb;

	// Instantiate the Unit Under Test (UUT)
	one_hertz_led uut (
		.clk(clk_tb), 
		.led(led_tb)
	);
	
	always
        #5 clk_tb = ~clk_tb;

	initial begin
		// Initialize Inputs
		clk_tb = 0;
		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
	end
	
	initial
		#1000000 $finish;
      
endmodule

