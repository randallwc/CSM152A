`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:28 10/28/2021 
// Design Name: 
// Module Name:    clockCounter 
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
module clockCounter(
    input in_norm_clk,
    input in_adj_clk,
    input in_sel,
    input in_adj,
    input in_rst,
    input in_pause,
    output [5:0] out_minute,
    output [5:0] out_second
    );
    
    reg [5:0] reg_minute;
    reg [5:0] reg_second;

    initial begin
        reg_minute = 0;
        reg_second = 0;
    end
    
    always @(posedge in_rst)
    begin
        reg_minute = 0;
        reg_second = 0;
    end
    
    always @(posedge in_norm_clk)
    begin
        if (in_rst)
        begin
            reg_second = 0;
            reg_minute = 0;
        end
        else if (in_pause)
        begin
            // do nothing
        end
        else if (!in_adj)
        begin
            reg_second = reg_second + 1;
            reg_minute = reg_minute + (reg_second / 60);
            
            reg_second = reg_second % 60;
            reg_minute = reg_minute % 60;
        end
    end
    
    always @(posedge in_adj_clk)
    begin
        if (in_rst)
        begin
            reg_second = 0;
            reg_minute = 0;
        end
        else if (in_pause)
        begin
            // do nothing
        end
        else if (in_adj)
        begin
            if (!in_sel)
            begin
                reg_minute = reg_minute + 1;
                reg_minute = reg_minute % 60;
            end
            else
                reg_second = reg_second + 1;
                reg_second = reg_second % 60;
            begin
            
            end
        end
    end
    
    assign out_minute = reg_minute;
    assign out_second = reg_second;

endmodule
