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
    );


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
    output [4:0] out_direction
    );
    
    reg [4:0] m_direction;
    
    initial begin
        m_direction = 5'b00001;
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
    input in_update_clock,
    input in_reset,
    input [4:0] in_direction,
    output wire [9*`SIZE:0] out_snakeX,
    output wire [8*`SIZE:0] out_snakeY
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
            assign out_snakeX[j+:9] = m_snakeX[i];
            assign out_snakeY[j+:8] = m_snakeY[i];
        end
    endgenerate
    
endmodule