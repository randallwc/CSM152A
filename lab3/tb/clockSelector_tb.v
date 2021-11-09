`timescale 1ns / 1ps

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

