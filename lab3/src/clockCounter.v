`timescale 1ns / 1ps

// module to select which clock to use depending on the adjust input
module clockSelector(
    input wire in_clock,
    input wire in_clock_adj,
    input wire [1:0] in_adjust,
    output wire out_clock
    );

    // set in internal clock
    reg m_clock;
    // connect register to output
    assign clock = m_clock;

    // connect the clock register to different clocks depending on the adjust
    // toggle
    always @(*) begin
        if (in_adjust) begin
            m_clock = in_clock_adj;
        end else begin
            m_clock = in_clock;
        end
    end
endmodule

module clockCounter(
    input wire in_reset,
    input wire in_pause,
    input wire [1:0] in_adjust,
    input wire in_select,
    input wire in_clock,
    input wire in_clock_adj,
    output wire [3:0] out_minute0,
    output wire [3:0] out_minute1,
    output wire [3:0] out_second0,
    output wire [3:0] out_second1
    );

    // set internal count of minutes and seconds
    reg [3:0] m_minute0 = 4'b0000;
    reg [3:0] m_minute1 = 4'b0000;
    reg [3:0] m_second0 = 4'b0000;
    reg [3:0] m_second1 = 4'b0000;

    wire m_clock; // chosen clock
    reg m_is_paused = 0; // paused register

    clockSelector m_clockSelector(
        in_clock(in_clock),
        in_clock_adj(in_clock_adj),
        [1:0] in_adjust(in_adjust),
        out_clock(m_clock)
        );

    // if pause button pressed store value in register
    // pause is async
    always @ (posedge in_clock or posedge in_pause) begin
        // if is paused then 
        if (in_pause) begin
             m_is_paused <= ~m_is_paused;
        end else begin
            // do nothing
        end
    end

    // each chosen clock cycle we want to count the right ammout
    // reset is sync
    always @ (posedge m_clock or posedge in_reset) begin
        if (in_reset) begin
            out_minute0 <= 4'b0000;
            out_minute1 <= 4'b0000;
            out_second0 <= 4'b0000;
            out_second1 <= 4'b0000;
        end

        
    end

endmodule

