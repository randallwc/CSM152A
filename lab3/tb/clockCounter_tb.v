`timescale 1ns / 1ps

module clockCounter_tb;

    // Inputs
    reg in_reset;
    reg in_pause;
    reg in_adjust;
    reg in_select;
    reg in_clock;
    reg in_clock_adj;

    // Outputs
    wire [3:0] out_minute0;
    wire [3:0] out_minute1;
    wire [3:0] out_second0;
    wire [3:0] out_second1;
    wire m_clock;

    clockSelector cs_uut (
        .in_clock(in_clock), 
        .in_clock_adj(in_clock_adj), 
        .in_adjust(in_adjust), 
        .out_clock(m_clock)
    );

    // Instantiate the Unit Under Test (UUT)
    clockCounter uut (
        .in_reset(in_reset), 
        .in_pause(in_pause), 
        .in_adjust(in_adjust), 
        .in_select(in_select), 
        .in_clock(in_clock), 
        .in_clock_adj(in_clock_adj), 
        .out_minute0(out_minute0), 
        .out_minute1(out_minute1), 
        .out_second0(out_second0), 
        .out_second1(out_second1)
    );

    always #5 in_clock = ~ in_clock;

    always #100 in_clock_adj = ~ in_clock_adj;

    initial begin
        // Initialize Inputs
        in_reset = 0;
        in_pause = 0;
        in_adjust = 0;
        in_select = 0;
        in_clock = 0;
        in_clock_adj = 0;

        // Wait 100 ns for global reset to finish
        #10000;

        in_pause=1;

        #100

        in_pause = 0;

        #1000

        in_pause=1;

        #100

        in_pause = 0;

        #100

        in_reset = 1;

        #100

        in_reset = 0;

        #1000

        // Add stimulus here

        in_adjust = 1;

        #1000

        in_select = 1;

        #1000

        in_adjust = 0;

        #1000

        in_pause = 1;

        #100

        in_pause = 0;

        #1000

        in_reset = 1;

        #100

        in_reset = 0;

        #1000

        $finish;

    end

endmodule

