/*
 * Module: Testbench for multiplexed combinational gates
 * 
 * Filename: combinational_gates_muxed_TB.v
 * Version: 1.0
 *
 * Author: Cejo Konuparamban Lonappan
 *
 * Description: The testbench code for verifying the multiplexed outputs of
 * eight comnibational gates. 
 */

`timescale 1ns / 1ps

module 4_bit_counter_tb; // No inputs for a testbench!

// Inputs in the module to be tested will be port mapped to register variables
reg a0_tb, a1_tb, a2_tb, a3_tb;

// Instantiation of the design module to be verified by the testbench
// Use named portmapping to map inputs to regsiter variables and outputs to
// wires
4_bit_counter UUT (.clk(clk_tb), .rst(rst_tb), .a0((a0_tb), .a1(a1_tb), .a2(a2_tb), .a3(a3_tb));

// IMPORTANT: Initialize all inputs. Otherwise the default value of register
// will be don't care (x).
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

// Code to terminate simulation after all the test cases have been covered.
initial
	#160 $finish; // After 160 timeunits, terminate simulation.

endmodule
