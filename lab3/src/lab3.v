`timescale 1ns / 1ps

// display to one of the 7-segment displays
module sevenSegmentDisplay(
    input wire [3:0] in_value,
    output wire [7:0] out_seven_segment
    );

    reg [7:0] m_seven_segment;

    assign out_seven_segment = m_seven_segment;
    
    initial begin
        m_seven_segment = 8'b11111111;
    end

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

module debouncer(
    input wire in_button, // board's button
    input wire in_clock, // 100MHz board clock
    output wire out_button_debounced // clean output
    );

    wire [17:0] clk_dv_inc;
    reg [16:0] clk_dv;
    reg clk_en;
    reg clk_en_d;

    reg inst_vld;
    reg [2:0] step_d;
   
    initial begin
        clk_dv <= 0;
        clk_en <= 0;
        clk_en_d <= 0;
        
        inst_vld <= 0;
        step_d <= 0;
    end

   // ===========================================================================
   // 763Hz timing signal for clock enable
   // ===========================================================================

   assign clk_dv_inc = clk_dv + 1;
   
   always @ (posedge in_clock)
   begin
      clk_dv <= clk_dv_inc[16:0];
      clk_en <= clk_dv_inc[17];
      clk_en_d <= clk_en;
   end
   
   // ===========================================================================
   // Instruction Stepping Control
   // ===========================================================================

   always @ (posedge in_clock)
     if (clk_en)
       begin
          step_d[2:0]  <= {in_button, step_d[2:1]};
       end

   always @ (posedge in_clock)
     inst_vld <= ~step_d[0] & step_d[1] & clk_en_d;

   assign out_button_debounced = inst_vld;
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
    
    initial begin
        m_clock <= 0;
    end
    
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
    output wire [3:0] out_second1,
    output wire out_is_paused
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
        .in_clock(in_clock),
        .in_clock_adj(in_clock_adj),
        .in_adjust(in_adjust),
        .out_clock(m_clock)
        );

    assign out_is_paused = m_is_paused;

    // if pause button pressed store value in register
    // pause is async
    always @ (posedge in_pause) begin
        m_is_paused <= ~m_is_paused;
    end

    // each chosen clock cycle we want to count the right ammout
    // reset is sync
    always @ (posedge m_clock or posedge in_reset) begin
        if (in_reset) begin
            m_minute0 <= 4'b0000;
            m_minute1 <= 4'b0000;
            m_second0 <= 4'b0000;
            m_second1 <= 4'b0000;
        end 
        // only do something if not paused
        else if (m_is_paused == 0) begin
            // SHOULD UPDATE CLOCK IN MODULE m_clockSelector
            // adjust mode is on
            if (in_adjust) begin
                // increase seconds at 2hz
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

// module to divide the main clock into 4 other clocks
module clockDivider(
    input wire in_clock,
    input wire in_reset,
    output wire out_one_hz_clock,
    output wire out_two_hz_clock,
    output wire out_segment_clock,
    output wire out_blink_clock
    );

    reg m_one_hz_clock;
    reg m_two_hz_clock;
    reg m_segment_clock;
    reg m_blink_clock;

    reg [31:0] m_one_hz_count;
    reg [31:0] m_two_hz_count;
    reg [31:0] m_segment_count;
    reg [31:0] m_blink_count;

    assign out_one_hz_clock = m_one_hz_clock;
    assign out_two_hz_clock = m_two_hz_clock;
    assign out_segment_clock = m_segment_clock;
    assign out_blink_clock = m_blink_clock;

    localparam ONE_HZ   = 50000000-1;
    localparam TWO_HZ   = 25000000-1;
    localparam THREE_HZ = 12500000-1;
    localparam ONE_KHZ  = 50000-1;
    
    initial begin
        m_one_hz_clock <= 0;
        m_two_hz_clock <= 0;
        m_segment_clock <= 0;
        m_blink_clock <= 0;
        
        m_one_hz_count <= 0;
        m_two_hz_count <= 0;
        m_segment_count <= 0;
        m_blink_count <= 0;
    end

    // one hz
    always @ (posedge in_clock or posedge in_reset) begin
        if (in_reset) begin
            m_one_hz_clock <= 0;
            m_one_hz_count <= 0;
        end else if (m_one_hz_count == ONE_HZ) begin
            m_one_hz_clock <= ~out_one_hz_clock; 
            m_one_hz_count <= 0;
        end else begin
            m_one_hz_clock <= out_one_hz_clock; 
            m_one_hz_count <= m_one_hz_count + 1;
        end
    end

    // two hz
    always @ (posedge in_clock or posedge in_reset) begin
        if (in_reset) begin
            m_two_hz_clock <= 0;
            m_two_hz_count <= 0;
        end else if (m_two_hz_count == TWO_HZ) begin
            m_two_hz_clock <= ~out_two_hz_clock; 
            m_two_hz_count <= 0;
        end else begin
            m_two_hz_clock <= out_two_hz_clock; 
            m_two_hz_count <= m_two_hz_count + 1;
        end
    end

    // 1 khz
    always @ (posedge in_clock or posedge in_reset) begin
        if (in_reset) begin
            m_segment_clock <= 0;
            m_segment_count <= 0;
        end else if (m_segment_count == ONE_KHZ) begin
            m_segment_clock <= ~out_segment_clock; 
            m_segment_count <= 0;
        end else begin
            m_segment_clock <= out_segment_clock; 
            m_segment_count <= m_segment_count + 1;
        end
    end

    // 3 hz
    always @ (posedge in_clock or posedge in_reset) begin
        if (in_reset) begin
            m_blink_clock <= 0;
            m_blink_count <= 0;
        end else if (m_blink_count == THREE_HZ) begin
            m_blink_clock <= ~out_blink_clock;
            m_blink_count <= 0;
        end else begin
            m_blink_clock <= out_blink_clock;
            m_blink_count <= m_blink_count + 1;
        end
    end
endmodule

module stopwatch(
    input wire b_clock,
    input wire b_reset,
    input wire b_pause,
    input wire b_select,
    input wire b_adjust,
    output reg [7:0] b_seg,
    output reg [3:0] b_an,
    output wire b_led_pause,
    output wire b_led_is_paused,
    output wire b_led_pause_db,
    output wire b_led_reset,
    output wire b_led_adjust,
    output wire b_led_select
    );

    // connect leds
    assign b_led_pause = b_pause;
    assign b_led_pause_db = m_pause_state;
    assign b_led_reset = b_reset;
    assign b_led_adjust = b_adjust;
    assign b_led_select = b_select;

    wire [3:0] m_seconds0;
    wire [3:0] m_seconds1;
    wire [3:0] m_minutes0;
    wire [3:0] m_minutes1;

    wire [7:0] m_display_seconds0;
    wire [7:0] m_display_seconds1;
    wire [7:0] m_display_minutes0;
    wire [7:0] m_display_minutes1;
    wire [7:0] m_display_empty;

    wire m_one_hz_clock;
    wire m_two_hz_clock;
    wire m_segment_clock;
    wire m_blink_clock;
    wire m_reset_state;
    wire m_pause_state;

    reg [1:0] m_current_display_segment = 2'b00;
    reg m_blink_minute = 1'b0;
    reg m_blink_second = 1'b0;

    debouncer m_debouncer_reset(
    .in_button(b_reset),
    .in_clock(b_clock),
    .out_button_debounced(m_reset_state)
    );

    debouncer m_debouncer_pause(
    .in_button(b_pause),
    .in_clock(b_clock),
    .out_button_debounced(m_pause_state)
    );

    clockDivider m_clockDivider(
    .in_clock(b_clock),
    .in_reset(m_reset_state),
    .out_one_hz_clock(m_one_hz_clock),
    .out_two_hz_clock(m_two_hz_clock),
    .out_segment_clock(m_segment_clock),
    .out_blink_clock(m_blink_clock)
    );

    clockCounter m_clockCounter(
    .in_reset(m_reset_state),
    .in_pause(m_pause_state),
    .in_adjust(b_adjust),
    .in_select(b_select),
    .in_clock(m_one_hz_clock),
    .in_clock_adj(m_two_hz_clock),
    .out_minute0(m_minutes0),
    .out_minute1(m_minutes1),
    .out_second0(m_seconds0),
    .out_second1(m_seconds1),
    .out_is_paused(b_led_is_paused) // connect toggle led
    );

    sevenSegmentDisplay m_sevenSegment_second0(
    .in_value(m_seconds0),
    .out_seven_segment(m_display_seconds0)
    );

    sevenSegmentDisplay m_sevenSegment_second1(
    .in_value(m_seconds1),
    .out_seven_segment(m_display_seconds1)
    );

    sevenSegmentDisplay m_sevenSegment_minute0(
    .in_value(m_minutes0),
    .out_seven_segment(m_display_minutes0)
    );

    sevenSegmentDisplay m_sevenSegment_minute1(
    .in_value(m_minutes1),
    .out_seven_segment(m_display_minutes1)
    );

    sevenSegmentDisplay m_sevenSegment_blank(
    .in_value(4'b1111),
    .out_seven_segment(m_display_empty)
    );

    always @ (posedge m_segment_clock) begin
        if (b_adjust) begin // blinking
            if (~b_select) begin // blink minutes
                if (m_current_display_segment == 0) begin
                    b_an <= 4'b0111;
                    if (m_blink_clock) begin
                        b_seg <= m_display_minutes1;
                    end else begin
                        b_seg <= m_display_empty;
                    end
                    m_current_display_segment <= m_current_display_segment + 1;
                end if (m_current_display_segment == 1) begin
                    b_an <= 4'b1011;
                    if (m_blink_clock) begin
                        b_seg <= m_display_minutes0;
                    end else begin
                        b_seg <= m_display_empty;
                    end
                    m_current_display_segment <= m_current_display_segment + 1;
                end if (m_current_display_segment == 2) begin
                    b_an <= 4'b1101;
                    b_seg <= m_display_seconds1;
                    m_current_display_segment <= m_current_display_segment + 1;
                end if (m_current_display_segment == 3) begin
                    b_an <= 4'b1110;
                    b_seg <= m_display_seconds0;
                    m_current_display_segment <= m_current_display_segment + 1;
                end
            end else begin // blink seconds
                if (m_current_display_segment == 0) begin
                    b_an <= 4'b0111;
                    b_seg <= m_display_minutes1;
                    m_current_display_segment <= m_current_display_segment + 1;
                end if (m_current_display_segment == 1) begin
                    b_an <= 4'b1011;
                    b_seg <= m_display_minutes0;
                    m_current_display_segment <= m_current_display_segment + 1;
                end if (m_current_display_segment == 2) begin
                    b_an <= 4'b1101;
                    if (m_blink_clock) begin
                        b_seg <= m_display_seconds1;
                    end else begin
                        b_seg <= m_display_empty;
                    end
                    m_current_display_segment <= m_current_display_segment + 1;
                end if (m_current_display_segment == 3) begin
                    b_an <= 4'b1110;
                    if (m_blink_clock) begin
                        b_seg <= m_display_seconds0;
                    end else begin
                        b_seg <= m_display_empty;
                    end
                    m_current_display_segment <= m_current_display_segment + 1;
                end
            end
        end else begin // normal
            if (m_current_display_segment == 0) begin
                b_an <= 4'b0111;
                b_seg <= m_display_minutes1;
                m_current_display_segment <= m_current_display_segment + 1;
            end if (m_current_display_segment == 1) begin
                b_an <= 4'b1011;
                b_seg <= m_display_minutes0;
                m_current_display_segment <= m_current_display_segment + 1;
            end if (m_current_display_segment == 2) begin
                b_an <= 4'b1101;
                b_seg <= m_display_seconds1;
                m_current_display_segment <= m_current_display_segment + 1;
            end if (m_current_display_segment == 3) begin
                b_an <= 4'b1110;
                b_seg <= m_display_seconds0;
                m_current_display_segment <= m_current_display_segment + 1;
            end
        end
    end
endmodule
