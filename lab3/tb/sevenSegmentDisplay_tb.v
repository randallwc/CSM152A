`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:26:03 11/02/2021
// Design Name:   sevenSegmentDisplay
// Module Name:   C:/Users/wrand/Desktop/CSM152A/tmp/lab3/sevenSegmentDisplay_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sevenSegmentDisplay
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sevenSegmentDisplay_tb;

    // Inputs
    reg [3:0] in_value;

    // Outputs
    wire [7:0] out_seven_segment;

    // Instantiate the Unit Under Test (UUT)
    sevenSegmentDisplay uut (
        .in_value(in_value), 
        .out_seven_segment(out_seven_segment)
    );

    initial begin
        // Initialize Inputs
        in_value = 0;

        // Wait 100 ns for global reset to finish
        #5;

        #5 in_value = 0;
        #5 in_value = 1;
        #5 in_value = 2;
        #5 in_value = 3;
        #5 in_value = 4;
        #5 in_value = 5;
        #5 in_value = 6;
        #5 in_value = 7;
        #5 in_value = 8;
        #5 in_value = 9;
        #5 in_value = 0;
        #5 in_value = 0;
        #5 in_value = 0;
        #5 in_value = 3;
        #5 in_value = 0;
        #5 in_value = 0;
        #5 in_value = 0;

        // Add stimulus here
        $finish;
    end

endmodule

