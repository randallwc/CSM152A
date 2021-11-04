`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:05:57 11/02/2021
// Design Name:   debouncer
// Module Name:   C:/Users/wrand/Desktop/CSM152A/tmp/lab3/debouncer_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debouncer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module debouncer_tb;

    // Inputs
    reg in_button;
    reg in_clock;

    // Outputs
    wire out_button_debounced;

    // Instantiate the Unit Under Test (UUT)
    debouncer uut (
        .in_button(in_button), 
        .in_clock(in_clock), 
        .out_button_debounced(out_button_debounced)
    );

    always #5 in_clock = ~in_clock;

    initial begin
        // Initialize Inputs
        in_button = 0;
        in_clock = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        in_button = 1;
        #5
        in_button = 0;
        #5
        in_button = 1;
        #25000
        in_button = 0;
        #25000
        $finish;
    end

endmodule

