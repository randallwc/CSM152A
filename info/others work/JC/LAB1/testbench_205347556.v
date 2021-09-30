`timescale 1ns / 1ps


module myTestBench;

	reg [12:0] D;

	wire[8:0] out;
	wire S;
	wire[2:0] E;
	wire[4:0] F;

	FPCVT uut(.D(D), .out(out), .S(S), .E(E), .F(F));



	initial begin

		D = -1;
		#100;
		D = 0;
		#100;
		D = 1;
		#100;
		D = 10;
		#100;
		D = -10;
		#100;
		D = 129;
		#100;
		D = -128;
		#100;
		

		D = -4096;
		#100;
		D = -255;
		#100;
		D = 4095;
		#100;
		D = 256;
		#100;

	end

endmodule