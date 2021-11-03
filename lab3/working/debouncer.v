`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:49:52 11/03/2021 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
    input wire in_button, // board's button
    input wire in_clock, // 100MHz board clock
    output wire out_button_debounced // clean output
    );
    
    wire clk_en;
    wire [2:0] buffer;
    wire buffer_neg;
    
    clock_enable m_clk_en(in_clock,clk_en);
    
    dff m_dff_0(in_clock, clk_en, in_button, buffer[0]);
    dff m_dff_1(in_clock, clk_en, buffer[0], buffer[1]);
    dff m_dff_2(in_clock, clk_en, buffer[1], buffer[2]);
    
    assign buffer_neg = ~buffer[2];
    assign out_button_debounced = buffer[1] & buffer_neg; // only is high on first clk_en tick when buffer[2] is low but buffer[1] is high
endmodule

module clock_enable(input in_clock, output clk_en); // used to create longer samples of button
    reg [26:0] counter = 0;
    always @(posedge in_clock) begin
        counter <= (counter>=249999) ? 0 : counter+1;
    end
    assign clk_en = (counter == 249999) ? 1'b1 : 1'b0;
endmodule

module dff(input in_clock, clk_en,D, output reg Q=0); // D flip flop to store value whenever slow clock ticks
    always @(posedge in_clock) begin
        if(clk_en==1) 
            Q <= D;
    end
endmodule 