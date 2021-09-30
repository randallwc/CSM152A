`timescale 1ns/1ns
module clock_gen_tb;
    reg clk, reset;
    wire clk2, clk4, clk8, clk16, clk28, clk5;
    wire [7:0] clk00;
	 //wire [3:0] testee;
	 //wire [1:0] oldy;
	 //wire oddval;
	 
    initial begin
		clk = 1;
        reset = 0;
    end
    always #5 clk = ~clk;
    initial begin 
        reset = 0;
        #20;
        reset = 1;
        #20;
        reset = 0;
    end
    clock_gen MUT(clk, reset, clk2, clk4, clk8, clk16, clk28, clk5, clk00);
	 //tester test(clk, reset, testee);

	 //oddy odd(clk, reset, oldy, oddval);
endmodule