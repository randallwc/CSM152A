`timescale 1ns / 1ps
`include "constants.v"

module snake_logic(
    input in_update_clock,
    input in_reset,
    input [4:0] in_direction,
    output wire [9*SIZE:0] out_snakeX,
    output wire [8*SIZE:0] out_snakeY
    );
    

    integer i;
    
    reg [9:0] m_snakeX[SIZE:0];
    reg [8:0] m_snakeY[SIZE:0];
    
    initial begin
        for (i = 0; i <= SIZE; i = i+1) begin
            m_snakeX[i] = 320;
            m_snakeY[i] = 240;
        end
    end
    
    always @(posedge in_reset) begin
        for (i = 0; i <= SIZE; i = i+1) begin
            m_snakeX[i] = 320;
            m_snakeY[i] = 240;
        end
    end
    
    always @(posedge in_update_clock) begin
        for (i = SIZE; i > 0; i = i-1) begin
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
        for (j=0; j<SIZE; j=j+1) begin: stage
            assign out_snakeX[j+:9] = m_snakeX[i];
            assign out_snakeY[j+:8] = m_snakeY[i];
        end
    endgenerate
    
endmodule
