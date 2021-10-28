`timescale 1ns / 1ps
module fourDigitsToBCD(
    input [5:0] in_minute,
    input [5:0] in_second,
    output [27:0] out_bcds
    );
    
    // internal wires
    wire [6:0] m_wire_bcd_1;
    wire [6:0] m_wire_bcd_2;
    wire [6:0] m_wire_bcd_3;
    wire [6:0] m_wire_bcd_4;
    
    // internal registers
    reg [4:0] m_reg_digit_1;
    reg [4:0] m_reg_digit_2;
    reg [4:0] m_reg_digit_3;
    reg [4:0] m_reg_digit_4;
    reg [27:0] m_reg_bcds;
    
    digitToBCD m_digitToBCD_1(
    .in_digit (m_reg_digit_1),
    .out_bcd (m_wire_bcd_1)
    );
    
    digitToBCD m_digitToBCD_2(
    .in_digit (m_reg_digit_2),
    .out_bcd (m_wire_bcd_2)
    );
    
    digitToBCD m_digitToBCD_3(
    .in_digit (m_reg_digit_3),
    .out_bcd (m_wire_bcd_3)
    );
    
    digitToBCD m_digitToBCD_4(
    .in_digit (m_reg_digit_4),
    .out_bcd (m_wire_bcd_4)
    );
    
    always @(*)
    begin
        m_reg_bcds = 0;
        m_reg_digit_1 = in_minute / 10;
        m_reg_digit_2 = in_minute % 10;
        m_reg_digit_3 = in_second / 10;
        m_reg_digit_4 = in_second % 10;
        m_reg_bcds = {m_wire_bcd_1,m_wire_bcd_2,m_wire_bcd_3,m_wire_bcd_4};
    end

    // connect output
    assign out_bcds = m_reg_bcds;
endmodule

module digitToBCD(
    input [4:0] in_digit,
    output reg [6:0] out_bcd
    );
    
    always @(*)
    begin
        case (in_digit)
            0 : begin
                out_bcd = 7'b0000001;
                end

            1 : begin
                out_bcd = 7'b1001111;
                end

            2 : begin
                out_bcd = 7'b0010010;
                end

            3 : begin
                out_bcd = 7'b0000110;
                end

            4 : begin
                out_bcd = 7'b1001100;
                end

            5 : begin
                out_bcd = 7'b0100100;
                end

            6 : begin
                out_bcd = 7'b0100000;
                end

            7 : begin
                out_bcd = 7'b0001111;
                end

            8 : begin
                out_bcd = 7'b0000000;
                end

            9 : begin
                out_bcd = 7'b0000100;
                end

            default:
                out_bcd = 7'b1111111;
        endcase
    end
endmodule
