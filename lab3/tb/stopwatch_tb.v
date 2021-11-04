`timescale 1ns / 1ps

module stopwatch_tb;

    // Inputs
    reg b_clock;
    reg b_reset;
    reg b_pause;
    reg b_select;
    reg b_adjust;

    // Outputs
    wire [7:0] b_seg;
    wire [3:0] b_an;

    // Instantiate the Unit Under Test (UUT)
    stopwatch uut (
        .b_clock(b_clock), 
        .b_reset(b_reset), 
        .b_pause(b_pause), 
        .b_select(b_select), 
        .b_adjust(b_adjust), 
        .b_seg(b_seg), 
        .b_an(b_an)
    );

    always #5 b_clock = ~b_clock;

    initial begin
        // Initialize Inputs
        b_clock = 0;
        b_reset = 1;
        b_pause = 0;
        b_select = 0;
        b_adjust = 0;

        // Wait 100 ns for global reset to finish
        #100;

        b_reset = 0;

        // Add stimulus here
        b_adjust = 0;
        #200
        b_adjust = 1;
        b_select = 0;
        #200
        b_select = 1;
        #200
        b_pause = 1;
        #200
        b_pause = 0;
        b_reset = 1;
        #20
        b_reset = 0;
        b_adjust = 0;
        b_select = 0;
        #500
        $finish;
    end

endmodule

