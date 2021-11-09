`timescale 1ns / 1ps

module clockDivider_tb;

    // Inputs
    reg in_clock;
    reg in_reset;

    // Outputs
    wire out_one_hz_clock;
    wire out_two_hz_clock;
    wire out_segment_clock;
    wire out_blink_clock;

    // Instantiate the Unit Under Test (UUT)
    clockDivider uut (
        .in_clock(in_clock), 
        .in_reset(in_reset), 
        .out_one_hz_clock(out_one_hz_clock), 
        .out_two_hz_clock(out_two_hz_clock), 
        .out_segment_clock(out_segment_clock), 
        .out_blink_clock(out_blink_clock)
    );

    always #5 in_clock = ~in_clock;

    initial begin
        // Initialize Inputs
        in_clock = 0;
        in_reset = 1;

        // Wait 100 ns for global reset to finish
        #100;

        in_reset = 0;

        #100;

        // Add stimulus here
        //#1000000
        //in_reset = 1;
        //$finish;

    end

endmodule

