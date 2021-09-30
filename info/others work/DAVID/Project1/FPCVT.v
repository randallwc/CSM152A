`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Convert 13-bits to floating point representation.
//////////////////////////////////////////////////////////////////////////////////
module FPCVT(
    input [12:0] D,
    output S,
    output [2:0] E,
    output [4:0] F
    );
	 
	 wire[12:0] o_mag_D;
	 wire[2:0]  o_E1;
	 wire[4:0]  o_F1;
	 wire 	   o_SB;
	 wire 		o_S;
	 wire[2:0]  o_E2;
	 wire[4:0]	o_F2;
	 
	 //Instantiate sign extractor and use wire for magnitude.
	 sign_extractor sign_extractor1(.i_D(D), .o_S(o_S), 
								.o_mag_D(o_mag_D));
	 
	 //Instantiate float_converter.
	 float_converter float_converter1(.i_mag_D(o_mag_D),
								.o_E(o_E1), .o_F(o_F1), .o_SB(o_SB));
								
	 //Instantiate rounder and drive final outputs.
	 rounder rounder1(.i_E(o_E1), .i_F(o_F1), .i_SB(o_SB),
								.o_E(o_E2), .o_F(o_F2));
								
	 assign S = o_S;
	 assign E = o_E2;
	 assign F = o_F2;

endmodule

//////////////////////////////////////////////////////////////////////////////////
// Converts 13-bit two's complement to sign-magnitude representation.
//////////////////////////////////////////////////////////////////////////////////
module sign_extractor(
    input [12:0] 	i_D,
    output 			o_S,
    output reg [12:0] o_mag_D
    );
	 
	 assign o_S = i_D[12];
	 
	 always @* begin
		o_mag_D = i_D;
		if ( i_D[12] ) begin
			o_mag_D = ~i_D + 1;
			//Handle edge case: most negative value
			if (o_mag_D[12]) begin
				o_mag_D = ~o_mag_D;
			end
		end
	 end

endmodule

//////////////////////////////////////////////////////////////////////////////////
// Converts 13-bit input into float representation with extra
// information for rounding. 
//////////////////////////////////////////////////////////////////////////////////
module float_converter(
    input [12:0] i_mag_D,
    output reg [2:0] o_E,
    output reg [4:0] o_F,
    output reg	  o_SB
    );
	 
	 /* 
	  * Priority encoder to shifter to perform floating
	  * point conversion.
	 */
	 always @* begin
		casez ( i_mag_D )
			13'b0_1zzz_zzzz_zzzz: begin
				o_E = 3'b111;
				o_F = i_mag_D[11:7];
				o_SB = i_mag_D[6];
				end
			13'b0_01zz_zzzz_zzzz: begin
				o_E = 3'b110;
				o_F = i_mag_D[10:6];
				o_SB = i_mag_D[5];
				end
			13'b0_001z_zzzz_zzzz: begin
				o_E = 3'b101;
				o_F = i_mag_D[9:5];
				o_SB = i_mag_D[4];
				end
			13'b0_0001_zzzz_zzzz: begin
				o_E = 3'b100;
				o_F = i_mag_D[8:4];
				o_SB = i_mag_D[3];
				end
			13'b0_0000_1zzz_zzzz: begin
				o_E = 3'b011;
				o_F = i_mag_D[7:3];
				o_SB = i_mag_D[2];
				end
			13'b0_0000_01zz_zzzz: begin
				o_E = 3'b010;
				o_F = i_mag_D[6:2];
				o_SB = i_mag_D[1];
				end
			13'b0_0000_001z_zzzz: begin
				o_E = 3'b001;
				o_F = i_mag_D[5:1];
				o_SB = i_mag_D[0];
				end
			default: begin
				o_E = 3'b000;
				o_F = i_mag_D[4:0];
				o_SB = 0;
				end
		endcase
	end
endmodule

//////////////////////////////////////////////////////////////////////////////////
// Rounds floating point conversion, exponent and significand.
//////////////////////////////////////////////////////////////////////////////////
module rounder(
    input [2:0] i_E,
    input [4:0] i_F,
    input i_SB,
    output reg[2:0] o_E,
    output reg[4:0] o_F
    );
	 
	 reg[5:0] F_overflow;
	 reg[3:0] E_overflow; 
	 
	 always @* begin
		F_overflow = i_F + i_SB;
		E_overflow = i_E + F_overflow[5]; 
		o_F = F_overflow >> F_overflow[5];
		o_E = E_overflow[2:0];
		
		// Edge case: 13'b0_1111_1111_1111
		if ( E_overflow[3] ) begin
			o_F = 5'b11111;
			o_E = 3'b111;
		end
	end
endmodule


