`timescale 1ns / 1ps

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
