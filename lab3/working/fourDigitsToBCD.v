`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:13 10/28/2021 
// Design Name: 
// Module Name:    fourDigitsToBCD 
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
module fourDigitsToBCD(
    input [5:0] in_minute,
    input [5:0] in_second,
    output [27:0] out_bcds
   );
    
    reg [4:0] reg_digit_1;
    wire [6:0] reg_bcd_1;
    reg [4:0] reg_digit_2;
    wire [6:0] reg_bcd_2;
    reg [4:0] reg_digit_3;
    wire [6:0] reg_bcd_3;
    reg [4:0] reg_digit_4;
    wire [6:0] reg_bcd_4;
    
    reg [27:0] reg_bcds;
    
    digitToBCD m_digitToBCD_1(
    .in_digit (reg_digit_1),
    .out_bcd (reg_bcd_1)
    );
    
    digitToBCD m_digitToBCD_2(
    .in_digit (reg_digit_2),
    .out_bcd (reg_bcd_2)
    );
    
    digitToBCD m_digitToBCD_3(
    .in_digit (reg_digit_3),
    .out_bcd (reg_bcd_3)
    );
    
    digitToBCD m_digitToBCD_4(
    .in_digit (reg_digit_4),
    .out_bcd (reg_bcd_4)
    );
    
    always @(*)
    begin
        reg_bcds = 0;
        
        reg_digit_1 = in_minute / 10;
//        reg_bcds = {reg_bcds[20:0], reg_bcd_1};
//      $display("DIGIT: %b", reg_digit);
//        $display("BCD: %b", reg_bcd);
        
        reg_digit_2 = in_minute % 10;
//      reg_bcds = {reg_bcds[20:0], reg_bcd_2};
//      $display("DIGIT: %b", reg_digit);
        
        reg_digit_3 = in_second / 10;
//      reg_bcds = {reg_bcds[20:0], reg_bcd_3};
//      $display("DIGIT: %b", reg_digit);
        
        reg_digit_4 = in_second % 10;
//      reg_bcds = {reg_bcds[20:0], reg_bcd_4};
//      $display("DIGIT: %b", reg_digit);
        reg_bcds = {reg_bcd_1,reg_bcd_2,reg_bcd_3,reg_bcd_4};
    end
    
    assign out_bcds = reg_bcds;


endmodule

module digitToBCD(
    input [4:0] in_digit,
    output reg [6:0] out_bcd
    );
    
    always @(*)
    begin
        case (in_digit)
            0:
            begin
                $display("TEST");
                out_bcd = 7'b0000001;
            end
            1:
            begin
                out_bcd = 7'b1001111;
            end
            2:
            begin
                out_bcd = 7'b0010010;
            end
            3:
            begin
                out_bcd = 7'b0000110;
            end
            4:
            begin
                out_bcd = 7'b1001100;
            end
            5:
            begin
                out_bcd = 7'b0100100;
            end
            6:
            begin
                out_bcd = 7'b0100000;
            end
            7:
            begin
                out_bcd = 7'b0001111;
            end
            8:
            begin
                out_bcd = 7'b0000000;
            end
            9:
            begin
                out_bcd = 7'b0000100;
            end
            default:
                out_bcd = 7'b1111111;
        endcase
    end
    
endmodule
