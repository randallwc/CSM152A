`timescale 1ns / 1ps

module four_bit_counter_tb;

reg clk_tb, rst_tb;

four_bit_counter uut (.clk(clk_tb), .rst(rst_tb), .a0(a0_tb), .a1(a1_tb), .a2(a2_tb), .a3(a3_tb));

initial begin
	clk_tb = 0;
	rst_tb = 1;
	
	#50;
	
	rst_tb = 0;
end

// Use an always block to generate all the test cases
always
	#5 clk_tb = ~clk_tb;

initial
	#500 $finish;

endmodule
