`timescale 1ns / 1ps

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


	initial begin
		// Initialize Inputs
		clk_tb = 0;
		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
	end
	
	always
        #5 clk_tb = ~clk_tb;
	
	initial
		#1000000 $finish;
      
endmodule

