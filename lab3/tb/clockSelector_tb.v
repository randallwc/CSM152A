`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:22:48 11/02/2021
// Design Name:   clockSelector
// Module Name:   C:/Users/wrand/Desktop/CSM152A/tmp/lab3/clockSelector_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clockSelector
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clockSelector_tb;

    // Inputs
    reg in_clock;
    reg in_clock_adj;
    reg in_adjust;

    // Outputs
    wire out_clock;

    // Instantiate the Unit Under Test (UUT)
    clockSelector uut (
        .in_clock(in_clock), 
        .in_clock_adj(in_clock_adj), 
        .in_adjust(in_adjust), 
        .out_clock(out_clock)
    );
    
    always #5 in_clock = ~ in_clock;
    always #100 in_clock_adj = ~ in_clock_adj;

    initial begin
        // Initialize Inputs
        in_clock = 0;
        in_clock_adj = 0;
        in_adjust = 0;

        // Wait 100 ns for global reset to finish
        #1234;
        
        // Add stimulus here
        in_adjust = 1;
        #1001
        $finish;
    end
      
endmodule

