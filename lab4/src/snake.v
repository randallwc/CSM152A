`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:27:41 11/16/2021 
// Design Name: 
// Module Name:    snake 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define SIZE 255

module snake(
    input wire in_clock,
    input wire in_button_up,
    input wire in_button_down,
    input wire in_button_left,
    input wire in_button_right,
    input wire in_button_reset,
    
    output wire [7:0] out_VGA_R,
    output wire [7:0] out_VGA_G,
    output wire [7:0] out_VGA_B,
    output wire out_hSync,
    output wire out_vSync
    );

    reg m_button_up;
    reg m_button_down;
    reg m_button_left;
    reg m_button_right;
    reg m_button_reset;
    
    reg m_VGA_clock;
    reg m_update_clock;  
    
    reg [9:0] m_pixelX;
    reg [8:0] m_pixelY;
    
    reg [4:0] m_direction;
    
    reg [10*`SIZE-1:0] out_snakeX;
    reg [9*`SIZE-1:0] out_snakeY;  

    reg [7:0] m_snake_size;
    reg [9:0] m_appleX;
    reg [8:0] m_appleY;
    
    reg m_snake;
    reg m_apple;
    reg m_border;
    reg m_lethal;
    reg m_nonlethal;
    
    reg [7:0] m_VGA_R;
    reg [7:0] m_VGA_G;
    reg [7:0] m_VGA_B;
    
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
    .out_pixelY(m_pixelY)
    );
    
    direction_logic m_direction_logic(
    .in_button_up(m_button_up),
    .in_button_down(m_button_down),
    .in_button_left(m_button_left),
    .in_button_right(m_button_right),
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
    .out_nonlethal(m_nonlethal)
    );
    
    pixel_logic m_pixel_logic(
    .in_reset(m_button_reset),
    .in_snake(m_snake),
    .in_apple(m_apple),
    .in_border(m_border),
    .in_lethal(m_lethal),
    .out_VGA_R(m_VGA_R),
    .out_VGA_G(m_VGA_G),
    .out_VGA_B(m_VGA_B)
    );
    
    assign out_VGA_R = m_VGA_R;
    assign out_VGA_G = m_VGA_G;
    assign out_VGA_B = m_VGA_B;
        
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
    
    always @(posedge in_button_reset) begin
    
    end
    
    always @(posedge in_button_up) begin
        m_direction = 5'b10000;
    end
    
    always @(posedge in_button_down) begin
        m_direction = 5'b01000;
    end
    
    always @(posedge in_button_left) begin
        m_direction = 5'b00100;
    end
    
    always @(posedge in_button_up) begin
        m_direction = 5'b00010;
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
    
    initial begin
        for (i = 0; i <= `SIZE; i = i+1) begin
            m_snakeX[i] = 320;
            m_snakeY[i] = 240;
        end
    end
    
    always @(posedge in_reset) begin
        for (i = 0; i <= `SIZE; i = i+1) begin
            m_snakeX[i] = 320;
            m_snakeY[i] = 240;
        end
    end
    
    always @(posedge in_update_clock) begin
        for (i = `SIZE; i > 0; i = i-1) begin
            m_snakeX[i] = m_snakeX[i-1];
            m_snakeX[i] = m_snakeX[i-1];
        end
        
        case (in_direction)
            5'b10000: m_snakeY[0] = m_snakeY[0] - 10;
            5'b01000: m_snakeY[0] = m_snakeY[0] + 10;
            5'b00100: m_snakeX[0] = m_snakeX[0] - 10;
            5'b00010: m_snakeX[0] = m_snakeX[0] + 10;
        endcase
    end
    
    generate
        genvar j;
        for (j=0; j<`SIZE; j=j+1) begin: stage
            assign out_snakeX[j+:10] = m_snakeX[i];
            assign out_snakeY[j+:9] = m_snakeY[i];
        end
    endgenerate
    
endmodule

module collision_logic(
    input wire in_pixelX,
    input wire in_pixelY,
    input wire [10*`SIZE-1:0] in_snakeX,
    input wire [9*`SIZE-1:0] in_snakeY,
    input wire [7:0] in_snake_size, // currently 8-bit to represent SIZE = 255
    input wire [9:0] in_appleX,
    input wire [8:0] in_appleY,
    output wire out_snake,
    output wire out_apple,
    output wire out_border,
    output wire out_lethal,
    output wire out_nonlethal
    );
    
    reg found_snake_head;
    reg found_snake_body;
    integer i;
    
    initial begin
        found_snake_head = 0;
        found_snake_body = 0;
    end
    
    always @(in_pixelX, in_pixelY) begin
        found_snake_head = (in_pixelX >= in_snakeX[9:0] && in_pixelX < in_snakeX[9:0]+10 &&
                            in_pixelY >= in_snakeY[8:0] && in_pixelY < in_snakeY[8:0]+10);
        for (i = 1; i < in_snake_size; i = i+1) begin
            if (found_snake_body == 0) begin
                found_snake_body = (in_pixelX >= in_snakeX[i+:10] && in_pixelX < in_snakeX[i+:10]+10 
                               && in_pixelY >= in_snakeY[i+:9] && in_pixelY < in_snakeY[i+:9]+10);
            end
        end
    end

    assign out_snake = (found_snake_head || found_snake_body);
    assign out_apple = (in_pixelX >= in_appleX && in_pixelX < in_appleX+10 && in_pixelY >= in_appleY && in_pixelY < in_appleY+10);
    assign out_border = ((in_pixelX >= 0 && in_pixelX < 10) || (in_pixelX >= 630 && in_pixelX < 640) || 
                         (in_pixelY >= 0 && in_pixelY < 10) || (in_pixelY >= 470 && in_pixelY < 480));
    assign out_lethal = (found_snake_head && (found_snake_body || out_border));
    assign out_nonlethal = (found_snake_head && out_apple); // relies on correct apple generation

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
    
    reg m_snake_size;
    
    reg [9:0] m_appleX;
    reg [8:0] m_appleY;
    
    initial begin
        spawn_apple = 0;
        m_snake_size = 1;
        m_appleX = 40;
        m_appleY = 40;
    end
    
    always @(posedge in_reset) begin
        spawn_apple = 0;
        m_snake_size = 1;
        m_appleX = 40;
        m_appleY = 40;
    end
    
    always @(posedge in_nonlethal) begin
        spawn_apple = 1;
    end
    
    always @(posedge in_update_clock) begin
        if (spawn_apple) begin
            m_snake_size = m_snake_size + 1;
            m_appleX = 600;
            m_appleY = 440; // needs to be randomized
            
            spawn_apple = 0;
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
    output wire [7:0] out_VGA_R,
    output wire [7:0] out_VGA_G,
    output wire [7:0] out_VGA_B
    );
    
    reg [7:0] m_VGA_R;
    reg [7:0] m_VGA_G;
    reg [7:0] m_VGA_B;
    
    reg found_lethal;
    
    initial begin
        m_VGA_R = 8'b00000000;
        m_VGA_G = 8'b00000000;
        m_VGA_B = 8'b00000000;
        
        found_lethal = 0;
    end
    
    always @(posedge in_reset) begin
        m_VGA_R = 8'b00000000;
        m_VGA_G = 8'b00000000;
        m_VGA_B = 8'b00000000;
    
        found_lethal = 0;
    end
    
    always @(*) begin
        if (in_lethal) begin
            found_lethal = 1;
        end
        
        if (found_lethal) begin
            m_VGA_R = 8'b11111111;
            m_VGA_G = 8'b11111111;
            m_VGA_B = 8'b11111111;
        end
        
        else if (in_snake) begin
            m_VGA_R = 8'b00000000;
            m_VGA_G = 8'b11111111;
            m_VGA_B = 8'b00000000;
        end
        
        else if (in_apple) begin
            m_VGA_R = 8'b11111111;
            m_VGA_G = 8'b00000000;
            m_VGA_B = 8'b00000000;
        end
        
        else if (in_border) begin
            m_VGA_R = 8'b00000000;
            m_VGA_G = 8'b00000000;
            m_VGA_B = 8'b11111111;
        end
        
        else begin
            m_VGA_R = 8'b00000000;
            m_VGA_G = 8'b00000000;
            m_VGA_B = 8'b00000000;
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
    output [8:0] out_pixelY
    );
    
    reg [9:0] m_pixelX;
    reg [8:0] m_pixelY;
    
    initial begin
        m_pixelX = 0;
        m_pixelY = 0;
    end
    
    always @(posedge in_reset) begin
        m_pixelX = 0;
        m_pixelY = 0;
    end
    
    always @(posedge in_VGA_clock) begin
        if (m_pixelX < 640) begin
            m_pixelX = m_pixelX + 1;
        end
        
        else begin
            m_pixelX = 0;
        
            if (m_pixelY < 480) begin
                m_pixelY = m_pixelY + 1;
            end
            
            else begin
                m_pixelY = 0;
            end
        end
    end
    
    assign out_pixelX = m_pixelX;
    assign out_pixelY = m_pixelY;
    
endmodule


module clock_divider(
    input wire in_clock, 
    output wire out_update_clock, 
    output wire out_VGA_clock
    );
    
    reg m_update_clock;
    reg m_VGA_clock;
    
	reg [21:0] update_count;	
    
    initial begin
        m_update_clock = 0;
        m_VGA_clock = 0;
        
        update_count = 0;
    end

	always@(posedge in_clock)
	begin
        m_VGA_clock = ~m_VGA_clock;
    
		update_count = update_count + 1;
		if(update_count == 1777777)
		begin
			m_update_clock = ~m_update_clock;
			update_count = 0;
		end	
	end
    
    assign out_update_clock = m_update_clock;
    assign out_VGA_clock = m_VGA_clock;
    
endmodule
