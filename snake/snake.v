`timescale 1ns / 1ps
`define SIZE 16

module snake(
    input wire in_clock,
    input wire in_button_up,
    input wire in_button_down,
    input wire in_button_left,
    input wire in_button_right,
    input wire in_button_reset,

    output wire [2:0] out_VGA_R,
    output wire [2:0] out_VGA_G,
    output wire [1:0] out_VGA_B,
    output wire [7:0] Led,
    output wire out_hSync,
    output wire out_vSync,

    inout wire [3:0] JA
    );

    wire m_button_up;
    wire m_button_down;
    wire m_button_left;
    wire m_button_right;
    wire m_button_reset;

    wire m_VGA_clock;
    wire m_update_clock;

    wire [9:0] m_pixelX;
    wire [8:0] m_pixelY;
    wire m_hSync;
    wire m_vSync;

    wire [4:0] m_direction;
    assign Led = m_snake_size;

    wire [10*`SIZE-1:0] m_snakeX;
    wire [9*`SIZE-1:0] m_snakeY;

    wire [7:0] m_snake_size;
    wire [9:0] m_appleX;
    wire [8:0] m_appleY;

    wire m_snake;
    wire m_apple;
    wire m_border;
    wire m_lethal; // dies
    wire m_nonlethal; // score
    wire m_oobounds;

    wire [2:0] m_VGA_R;
    wire [2:0] m_VGA_G;
    wire [1:0] m_VGA_B;

    debouncer m_debouncer_up(
    .in_button(in_button_up),
    .in_clock(in_clock),
    .out_button_debounced(m_button_up)
    );

    debouncer m_debouncer_down(
    .in_button(in_button_down),
    .in_clock(in_clock),
    .out_button_debounced(m_button_down)
    );

    debouncer m_debouncer_left(
    .in_button(in_button_left),
    .in_clock(in_clock),
    .out_button_debounced(m_button_left)
    );

    debouncer m_debouncer_right(
    .in_button(in_button_right),
    .in_clock(in_clock),
    .out_button_debounced(m_button_right)
    );

    debouncer m_debouncer_reset(
    .in_button(in_button_reset),
    .in_clock(in_clock),
    .out_button_debounced(m_button_reset)
    );

    clock_divider m_clock_divider(
    .in_clock(in_clock),
    .out_VGA_clock(m_VGA_clock),
    .out_update_clock(m_update_clock)
    );

    vga_controller m_vga_controller(
    .in_VGA_clock(m_VGA_clock),
    .in_reset(m_button_reset),
    .out_pixelX(m_pixelX),
    .out_pixelY(m_pixelY),
    .out_hSync(m_hSync),
    .out_vSync(m_vSync)
    );

    direction_logic m_direction_logic(
    .in_button_up(m_button_up),
    .in_button_down(m_button_down),
    .in_button_left(m_button_left),
    .in_button_right(m_button_right), // skip debouncer
    .in_button_reset(m_button_reset),
    .out_direction(m_direction)
    );

    snake_logic m_snake_logic(
    .in_update_clock(m_update_clock),
    .in_reset(m_button_reset),
    .in_direction(m_direction),
    .out_snakeX(m_snakeX),
    .out_snakeY(m_snakeY)
    );

    apple_logic m_apple_logic(
    .in_update_clock(m_update_clock),
    .in_reset(m_button_reset),
    .in_nonlethal(m_nonlethal),
    .out_snake_size(m_snake_size),
    .out_appleX(m_appleX),
    .out_appleY(m_appleY)
    );

    collision_logic m_collision_logic(
    .in_pixelX(m_pixelX),
    .in_pixelY(m_pixelY),
    .in_snakeX(m_snakeX),
    .in_snakeY(m_snakeY),
    .in_snake_size(m_snake_size),
    .in_appleX(m_appleX),
    .in_appleY(m_appleY),
    .out_snake(m_snake),
    .out_apple(m_apple),
    .out_border(m_border),
    .out_lethal(m_lethal),
    .out_nonlethal(m_nonlethal),
    .out_oobounds(m_oobounds)
    );

    pixel_logic m_pixel_logic(
    .in_reset(m_button_reset),
    .in_snake(m_snake),
    .in_apple(m_apple),
    .in_border(m_border),
    .in_lethal(m_lethal),
    .in_oobounds(m_oobounds),
    .out_VGA_R(m_VGA_R),
    .out_VGA_G(m_VGA_G),
    .out_VGA_B(m_VGA_B)
    );

    synthesizer m_sound(
    .clk(in_clock),
    .in_freq(440),
    .signal(m_lethal || m_nonlethal || m_button_reset),
    .JA(JA)
    );

    assign out_VGA_R = m_VGA_R;
    assign out_VGA_G = m_VGA_G;
    assign out_VGA_B = m_VGA_B;

    assign out_hSync = m_hSync;
    assign out_vSync = m_vSync;

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

   always @ (posedge in_clock)
     if (clk_en)
       begin
          step_d[2:0]  <= {in_button, step_d[2:1]};
       end

   always @ (posedge in_clock)
     inst_vld <= ~step_d[0] & step_d[1] & clk_en_d;

   assign out_button_debounced = inst_vld;
endmodule

module direction_logic(
    input wire in_button_up,
    input wire in_button_down,
    input wire in_button_left,
    input wire in_button_right,
    input wire in_button_reset,
    output [4:0] out_direction
    );

    reg [4:0] m_direction;

    initial begin
        m_direction = 5'b00001;
    end

    always @(
    posedge in_button_reset or
    posedge in_button_up or
    posedge in_button_down or
    posedge in_button_left or
    posedge in_button_right
    ) begin
        if (in_button_reset) begin
            m_direction <= 5'b00001;
        end else if (in_button_up) begin
            m_direction <= 5'b10000;
        end else if (in_button_down) begin
            m_direction <= 5'b01000;
        end else if (in_button_left) begin
            m_direction <= 5'b00100;
        end else begin
            m_direction <= 5'b00010;
        end
    end

    assign out_direction = m_direction;
endmodule

module snake_logic(
    input wire in_update_clock,
    input wire in_reset,
    input wire [4:0] in_direction,
    output wire [10*`SIZE-1:0] out_snakeX,
    output wire [9*`SIZE-1:0] out_snakeY
    );

    integer i;

    reg [9:0] m_snakeX[`SIZE:0];
    reg [8:0] m_snakeY[`SIZE:0];

//    reg [10*`SIZE-1:0] m_snakeX;
//    reg [9*`SIZE-1:0] m_snakeY;

    initial begin
        for (i = 0; i < `SIZE; i = i+1) begin
            m_snakeX[i] <= 320; // 320;
            m_snakeY[i] <= 240; // 240;
        end
    end

/*    always @(posedge in_reset) begin
        for (i = 0; i <= `SIZE; i = i+1) begin
            m_snakeX[i] = 320;
            m_snakeY[i] = 240;
        end
    end*/

    always @(posedge in_reset or posedge in_update_clock) begin
        if (in_reset) begin
            for (i = 0; i < `SIZE; i = i+1) begin
                m_snakeX[i] <= 320;
                m_snakeY[i] <= 240;
            end
        end else begin
            for (i = `SIZE-1; i > 0; i = i-1) begin
                m_snakeX[i] <= m_snakeX[i-1];
                m_snakeY[i] <= m_snakeY[i-1];
            end

            case (in_direction)
                5'b10000: m_snakeY[0] <= m_snakeY[0] - 10;
                5'b01000: m_snakeY[0] <= m_snakeY[0] + 10;
                5'b00100: m_snakeX[0] <= m_snakeX[0] - 10;
                5'b00010: m_snakeX[0] <= m_snakeX[0] + 10;
            endcase
        end
    end

    generate
        genvar j;
        for (j=0; j<`SIZE; j=j+1) begin: stage
            assign out_snakeX[10*j+:10] = m_snakeX[j];
            assign out_snakeY[9*j+:9] = m_snakeY[j];
        end
    endgenerate

//    assign out_snakeX = m_snakeX;
//    assign out_snakeY = m_snakeY;

endmodule

module collision_logic(
    input wire [9:0] in_pixelX,
    input wire [8:0] in_pixelY,
    input wire [10*`SIZE-1:0] in_snakeX,
    input wire [9*`SIZE-1:0] in_snakeY,
    input wire [7:0] in_snake_size, // currently 8-bit to represent SIZE = 255
    input wire [9:0] in_appleX,
    input wire [8:0] in_appleY,
    output wire out_snake,
    output wire out_apple,
    output wire out_border,
    output wire out_lethal,
    output wire out_nonlethal,
    output wire out_oobounds
    );

    wire found_snake_head;
    reg found_snake_body;
    integer i;
    wire [7:0] m_snake_size;
    reg m_nonlethal;
    reg m_lethal;

    assign m_snake_size = in_snake_size % `SIZE;

    initial begin
        found_snake_body <= 0;
    end

    always @(in_pixelX, in_pixelY) begin
        found_snake_body = 0;
        for (i = 1; i < `SIZE; i = i+1) begin // change to in_snake_size
            if (found_snake_body == 0 && i < in_snake_size) begin
                found_snake_body = (in_pixelX >= in_snakeX[10*i +:10] && in_pixelX < in_snakeX[10*i+:10]+10
                               && in_pixelY >= in_snakeY[9*i+:9] && in_pixelY < in_snakeY[9*i+:9]+10);
            end
        end
    end

    always @(in_snakeX,in_snakeY,in_appleX,in_appleY) begin
        m_nonlethal = in_appleX == in_snakeX[9:0] && in_appleY == in_snakeY[8:0]; //(in_appleX > in_snakeX[9:0] - 10) && (in_appleX < in_snakeX[9:0] + 10) && (in_appleY > in_snakeY[8:0] - 10) && (in_appleY < in_snakeY[8:0] + 10);

        m_lethal = 0;
        for (i = 4; i < `SIZE; i = i+1) begin // change to in_snake_size
            if (m_lethal == 0 && i < in_snake_size) begin
                m_lethal = (in_snakeX[9:0] == in_snakeX[10*i +:10] && in_snakeY[8:0] == in_snakeY[9*i+:9]);
            end
        end

        m_lethal = m_lethal || ((in_snakeX[9:0] == 10) + (in_snakeX[9:0] == 620) + (in_snakeY[8:0] == 10) + (in_snakeY[8:0] == 460) == 1);
    end

    assign found_snake_head = (in_pixelX >= in_snakeX[9:0] && in_pixelX < in_snakeX[9:0]+10 &&
                            in_pixelY >= in_snakeY[8:0] && in_pixelY < in_snakeY[8:0]+10);

    assign out_snake = (found_snake_head || found_snake_body); // fix to show body
    assign out_apple = (in_pixelX >= in_appleX && in_pixelX < in_appleX+10 && in_pixelY >= in_appleY && in_pixelY < in_appleY+10);
    assign out_border = ((in_pixelX >= 0 && in_pixelX < 20) || (in_pixelX >= 620 && in_pixelX < 640) ||
                         (in_pixelY >= 0 && in_pixelY < 20) || (in_pixelY >= 460 && in_pixelY < 480));
    assign out_lethal = m_lethal; //(found_snake_head && (out_border)); //(found_snake_head && (found_snake_body || out_border));
    assign out_nonlethal = m_nonlethal; // relies on correct apple generation
    assign out_oobounds = (in_pixelX >= 640 || in_pixelY >= 480);

endmodule

module apple_logic(
    input wire in_update_clock, // game clock
    input wire in_reset,
    input wire in_nonlethal,
    output wire [7:0] out_snake_size,
    output wire [9:0] out_appleX,
    output wire [8:0] out_appleY
    );

    reg spawn_apple;

    reg [7:0] m_snake_size;

    reg [9:0] m_appleX;
    reg [8:0] m_appleY;

    reg [9:0] m_next_appleX;
    reg [8:0] m_next_appleY;

    initial begin
        spawn_apple <= 0;
        m_snake_size <= 3; // snake length at start
        m_appleX <= 200;
        m_appleY <= 200;
        m_next_appleX <= 0;
        m_next_appleY <= 0;
    end

    always @(
    posedge in_reset or
    posedge in_update_clock) begin
        if (in_reset) begin
            m_next_appleX = 20;
            m_next_appleY = 20;
        end else begin
            m_next_appleX = (m_next_appleX + 10)% 600; // + 20
            m_next_appleY = (m_next_appleY + 10)% 440;
        end
    end

    always @(posedge in_reset or posedge in_nonlethal) begin
        if (in_reset) begin
            spawn_apple = 0;
            m_snake_size = 3; // snake length at start
            m_appleX = 200;
            m_appleY = 200;
        end else begin
            m_snake_size = m_snake_size + 1;
            m_appleX = m_next_appleX + 20;
            m_appleY = m_next_appleY + 20;
        end
    end

    assign out_snake_size = m_snake_size;
    assign out_appleX = m_appleX;
    assign out_appleY = m_appleY;

endmodule

module pixel_logic(
    input wire in_reset,
    input wire in_snake,
    input wire in_apple,
    input wire in_border,
    input wire in_lethal,
    input wire in_oobounds,
    output wire [2:0] out_VGA_R,
    output wire [2:0] out_VGA_G,
    output wire [1:0] out_VGA_B
    );

    reg [2:0] m_VGA_R;
    reg [2:0] m_VGA_G;
    reg [1:0] m_VGA_B;

    reg found_lethal;

    initial begin
        m_VGA_R <= 3'b000;
        m_VGA_G <= 3'b000;
        m_VGA_B <= 2'b00;

        found_lethal <= 0;
    end

    always @(posedge in_reset or posedge in_lethal) begin
        if (in_reset) begin
            found_lethal <= 0;
        end
        else begin
            found_lethal <= 1;
        end
    end

    always @(in_reset or in_snake or in_apple or in_border or in_oobounds) begin
        if (in_reset) begin
            m_VGA_R <= 3'b000;
            m_VGA_G <= 3'b000;
            m_VGA_B <= 2'b00;
        end
        else begin
            if (in_oobounds) begin
                m_VGA_R <= 3'b000;
                m_VGA_G <= 3'b000;
                m_VGA_B <= 2'b00;
            end
            else if (found_lethal) begin
                m_VGA_R <= 3'b111;
                m_VGA_G <= 3'b111;
                m_VGA_B <= 2'b11;
            end

            else if (in_snake) begin
                m_VGA_R <= 3'b000;
                m_VGA_G <= 3'b111;
                m_VGA_B <= 2'b00;
            end

            else if (in_apple) begin
                m_VGA_R <= 3'b111;
                m_VGA_G <= 3'b000;
                m_VGA_B <= 2'b00;
            end

            else if (in_border) begin
                m_VGA_R <= 3'b000;
                m_VGA_G <= 3'b000;
                m_VGA_B <= 2'b11;
            end

            else begin
                m_VGA_R <= 3'b000;
                m_VGA_G <= 3'b000;
                m_VGA_B <= 2'b00;
            end
        end
    end

    assign out_VGA_R = m_VGA_R;
    assign out_VGA_G = m_VGA_G;
    assign out_VGA_B = m_VGA_B;

endmodule

module vga_controller(
    input wire in_VGA_clock,
    input wire in_reset,
    output [9:0] out_pixelX,
    output [8:0] out_pixelY,
    output out_hSync,
    output out_vSync
    );

    // video structure constants
    parameter hpixels = 800; // horizontal pixels per line
    parameter vlines = 521; // vertical lines per frame
    parameter hpulse = 96; // hsync pulse length
    parameter vpulse = 2; // vsync pulse length
    parameter hbp = 144; // end of horizontal back porch
    parameter hfp = 784; // beginning of horizontal front porch
    parameter vbp = 31; // end of vertical back porch
    parameter vfp = 511; // beginning of vertical front porch
    // active horizontal video is therefore: 784 - 144 = 640
    // active vertical video is therefore: 511 - 31 = 480

    reg [9:0] m_pixelX;
    reg [9:0] m_pixelY;

    initial begin
        m_pixelX <= 0;
        m_pixelY <= 0;
    end

    // generate sync pulses (active low)
    // ----------------
    // "assign" statements are a quick way to
    // give values to variables of type: wire
    assign out_hSync = (m_pixelX < hpulse) ? 0:1;
    assign out_vSync = (m_pixelY < vpulse) ? 0:1;

    // Horizontal & vertical counters --
    // this is how we keep track of where we are on the screen.
    // ------------------------
    // Sequential "always block", which is a block that is
    // only triggered on signal transitions or "edges".
    // posedge = rising edge  &  negedge = falling edge
    // Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
    always @(posedge in_VGA_clock or posedge in_reset)
    begin
        // reset condition
        if (in_reset == 1)
        begin
            m_pixelX <= 0;
            m_pixelY <= 0;
        end
        else
        begin
            // keep counting until the end of the line
            if (m_pixelX < hpixels - 1)
                m_pixelX <= m_pixelX + 1;
            else
            // When we hit the end of the line, reset the horizontal
            // counter and increment the vertical counter.
            // If vertical counter is at the end of the frame, then
            // reset that one too.
            begin
                m_pixelX <= 0;
                if (m_pixelY < vlines - 1) begin
                    m_pixelY <= m_pixelY + 1;
                end else begin
                    m_pixelY <= 0;
                end
            end
        end
    end

    assign out_pixelX = m_pixelX-hbp;
    assign out_pixelY = m_pixelY-vbp;

endmodule

// TODO add reset
module clock_divider(
    input wire in_clock,
    output wire out_update_clock,
    output wire out_VGA_clock
    );

    // 17-bit counter variable
    reg [16:0] q;

    reg m_update_clock;
    reg m_VGA_clock;

    reg [32:0] update_count;

    initial begin
        m_update_clock = 0;
        m_VGA_clock = 0;
        update_count = 0;
        q = 0;
    end

    always@(posedge in_clock)
    begin
//        m_VGA_clock = ~m_VGA_clock;
        update_count = update_count + 1;
        if(update_count == 24999999)
        begin
            m_update_clock = ~m_update_clock;
            update_count = 0;
        end
    end

    // Clock divider --
    // Each bit in q is a clock signal that is
    // only a fraction of the master clock.
    // TODO -- add reset
//    always @(posedge in_clock or posedge clr)
    always @(posedge in_clock)
    begin
//        // reset condition
//        if (clr == 1)
//            q <= 0;
//        // increment counter by one
//        else
            q <= q + 1;
    end

    // 100Mhz  2^2 = 25MHz
    // FIXED -- divide by factor of 4 instead of 2
    assign out_VGA_clock = q[1];
    assign out_update_clock = m_update_clock;
endmodule
