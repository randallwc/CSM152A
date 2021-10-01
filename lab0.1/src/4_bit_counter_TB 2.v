`timescale 1ns / 1ps

module 4_bit_counter_tb;

reg a0_tb, a1_tb, a2_tb, a3_tb;

4_bit_counter UUT (.clk(clk_tb), .rst(rst_tb), .a0(a0_tb), .a1(a1_tb), .a2(a2_tb), .a3(a3_tb));

initial
begin
	clk_tb = '1b0;
	rst_tb = '1b0;
	a0_tb = '1b0;
	a1_tb = '1b0;
	a2_tb = '1b0;
	a3_tb = '1b0;
end

// Use an always block to generate all the test cases
always
	#5 clk_tb = ~clk_tb;

initial
	#160 $finish; // After 160 timeunits, terminate simulation.

endmodule
