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
	
	reg [4:0] reg_digit;
	reg [6:0] reg_bcd;
	reg [27:0] reg_bcds;
	
	digitToBCD m_digitToBCD(
	.in_digit (reg_digit),
	.out_bcd (reg_bcd)
	);
	
	always @(*)
	begin
		reg_bcds = 0;
		
		reg_digit = in_minute / 10;
        reg_bcds = {reg_bcds[20:0], reg_bcd};
		$display("DIGIT: %b", reg_digit);
        $display("BCD: %b", reg_bcd);
		
		reg_digit = in_minute % 10;
//		reg_bcds = {reg_bcds[20:0], reg_bcd};
		$display("DIGIT: %b", reg_digit);
		
		reg_digit = in_second / 10;
//		reg_bcds = {reg_bcds[20:0], reg_bcd};
		$display("DIGIT: %b", reg_digit);
		
		reg_digit = in_second % 10;
//		reg_bcds = {reg_bcds[20:0], reg_bcd};
		$display("DIGIT: %b", reg_digit);
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
