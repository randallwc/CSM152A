`timescale 1ns / 1ps

// display to one of the 7-segment displays
module sevenSegmentDisplay(
    input wire [3:0] in_value,
    output wire [7:0] out_seven_segment
    );

    reg [7:0] m_seven_segment;

    assign out_seven_segment = m_seven_segment;

    // https://www.youtube.com/watch?v=EKX1K9oV_c4&ab_channel=AbdulRehman2050
    always @ (*) begin
        case(in_value)
            4'h0: m_seven_segment = 8'b11000000; // 0
            4'h1: m_seven_segment = 8'b11111001; // 1
            4'h2: m_seven_segment = 8'b10100100; // 2
            4'h3: m_seven_segment = 8'b10110000; // 3
            4'h4: m_seven_segment = 8'b10011001; // 4
            4'h5: m_seven_segment = 8'b10010010; // 5
            4'h6: m_seven_segment = 8'b10000010; // 6
            4'h7: m_seven_segment = 8'b11111000; // 7
            4'h8: m_seven_segment = 8'b10000000; // 8
            4'h9: m_seven_segment = 8'b10010000; // 9
            default: m_seven_segment = 8'b11111111; // error
        endcase
    end
endmodule

// module to debounce an input signal
module debouncer(
    input wire in_button,
    input wire in_clock,
    input wire out_button_debounced
    );

    reg m_button_debounced = 0;
    reg [11:0] m_count;

    assign out_button_debounced = m_button_debounced;

    always @ (posedge in_clock) begin
        if (in_button) begin
            m_count <= m_count + 1'b1;
            // if button held for 12 in_clock cycles
            if (m_count == 12'hfff) begin
                m_count <= 0;
                m_button_debounced <= 1;
            end
        end else begin
            m_count <= 0;
            m_button_debounced <= 0;
        end
    end
endmodule

// module to select which clock to use depending on the adjust input
module clockSelector(
    input wire in_clock,
    input wire in_clock_adj,
    input wire in_adjust,
    output wire out_clock
    );

    // set in internal clock
    reg m_clock;
    // connect register to output
    assign out_clock = m_clock;

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

// module to count up minutes and seconds depending on the reset, pause,
// adjust, and select inputs
module clockCounter(
    input wire in_reset,
    input wire in_pause,
    input wire in_adjust,
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

    // connect registers to outputs
    assign out_minute0 = m_minute0;
    assign out_minute1 = m_minute1;
    assign out_second0 = m_second0;
    assign out_second1 = m_second1;

    wire m_clock; // chosen clock
    reg m_is_paused = 0; // paused register

    clockSelector m_clockSelector(
        in_clock(in_clock),
        in_clock_adj(in_clock_adj),
        in_adjust(in_adjust),
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
        // only do something if not paused
        else if (m_is_paused == 0) begin
            // SHOULD UPDATE CLOCK IN MODULE m_clockSelector
            // adjust mode is on
            if (in_adjust) begin
                // increase seconds at 2hz
                // while blinking minutes TODO
                if (in_select) begin
                    // count up to 59 for seconds
                    if (m_second1 == 5 && m_second0 == 9) begin
                        m_second1 <= 0;
                        m_second0 <= 0;
                    end else if (m_second0 == 9) begin
                        m_second1 <= m_second1 + 4'b1;
                        m_second0 <= 0;
                    end else begin
                        m_second0 <= m_second0 + 4'b1;
                    end
                // increase minutes at 2hz
                // while blinking seconds TODO
                end else begin
                    // count up to 99 for minutes
                    if (m_minute1 == 9 && m_minute0 == 9) begin
                        m_minute1 <= 0;
                        m_minute0 <= 0;
                    end else if (m_minute0 == 9) begin
                        m_minute1 <= m_minute1 + 4'b1;
                        m_minute0 <= 0;
                    end else begin
                        m_minute0 <= m_minute0 + 4'b1;
                    end
                end
            // normal mode i.e. not adjusting
            end else begin
                // check seconds
                // seconds goes up to 59
                if (m_second1 == 5 && m_second0 == 9) begin
                    // second overflow
                    // set seconds to 0
                    m_second1 <= 0;
                    m_second0 <= 0;
                    // minutes goes up to 99
                    if (m_minute1 == 9 && m_minute0 == 9) begin
                        m_minute1 <= 0;
                        m_minute0 <= 0;
                    end else if (m_minute0 == 9) begin
                        m_minute1 <= m_minute1 + 4'b1;
                        m_minute0 <= 0;
                    end else begin
                        m_minute0 <= m_minute0 + 4'b1;
                    end
                end else if (m_second0 == 9) begin
                    m_second1 <= m_second1 + 4'b1;
                    m_second0 <= 0;
                end else begin
                    m_second0 <= m_second0 + 4'b1;
                end
            end
        end
    end
endmodule
