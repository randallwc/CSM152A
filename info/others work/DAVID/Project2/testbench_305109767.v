`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Testbench
////////////////////////////////////////////////////////////////////////////////

module testbench_305109767;

	// Inputs
	reg clk_in;
	reg rst;

	// Outputs
	wire clk_div_2;
	wire clk_div_4;
	wire clk_div_8;
	wire clk_div_16;
	wire clk_div_28;
	wire clk_div_5;
	wire [7:0] toggle_counter;

	// Instantiate the Unit Under Test (UUT)
	clock_gen uut (
		.clk_in(clk_in), 
		.rst(rst), 
		.clk_div_2(clk_div_2), 
		.clk_div_4(clk_div_4), 
		.clk_div_8(clk_div_8), 
		.clk_div_16(clk_div_16), 
		.clk_div_28(clk_div_28), 
		.clk_div_5(clk_div_5), 
		.toggle_counter(toggle_counter)
	);
	initial begin
		// Initialize Inputs
		clk_in = 0;
		rst = 1;
		#100 rst = 0;
		
		//Run for 2000 ns 
		#2000;
		$stop;

	end
	// Stimulated 100MHz clock with 10 ns period
	always #5 clk_in = ~clk_in;
      
endmodule

