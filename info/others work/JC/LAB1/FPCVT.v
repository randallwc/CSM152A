`timescale 1ns / 1ps




module FPCVT(D, out, S, E, F);

   input [12:0] D;
   output [8:0] out; 
   output wire S;
   output wire [2:0] E;
   output wire [4:0] F;

	wire [12:0] positiveBit;
	// Simply detects if number is negative, and computes it's complement of two's if it is negative
	calculateTwosCompliment convert(D, positiveBit, S);
	// This function converts our non-twos complement number into floating point format
	convertToFloatRepresentation convert2(E, F, positiveBit);
	 
	// Constructing our output
	assign out[8] = S;
   assign out[7:5] = E[2:0];
   assign out[4:0] = F[4:0];
	 
endmodule






module calculateTwosCompliment(in, convertedOutput, magSign);

	input [12:0] in;
	output reg [12:0] convertedOutput;
	output reg magSign;
	
	always @ (*) begin
		// Simply return value if it is already positive
		if (in[12] == 1'b0) 
			begin
				convertedOutput = in;
			end
			
		else // Number is negative and we need to fix it
			begin

				if (in[12:0] != 13'b1000000000000)
					begin
						// The part we compute two's compliment, flip bits and add one
						convertedOutput = ~in + 1'b1;
					end
				else
					begin
						// We are at the overflow limit, need to reset
						convertedOutput = 13'b0111111111111;
					
					end
			end
		magSign = in[12];

	end

endmodule


module convertToFloatRepresentation(E, F, positiveRepresentation);

	input [12:0] positiveRepresentation;
	output reg [2:0] E;
	output reg [4:0] F;
	

	reg [12:0] mantissa;
	
	
	//I know this is ugly, but I couldnt find another way to do it
	always @(*) begin
		// Per documentation, the lowest exponent we will go to is 0.
		if (positiveRepresentation[12] == 0) begin
			
			E = 3'b111;
			if (positiveRepresentation[11] == 0) begin
				E = 3'b110;
				if (positiveRepresentation[10] == 0) begin
					E = 3'b101;
					if (positiveRepresentation[9] == 0) begin
						E = 3'b100;
						if (positiveRepresentation[8] == 0) begin
							E = 3'b011;
							if (positiveRepresentation[7] == 0) begin
								E = 3'b010;
								if (positiveRepresentation[6] == 0) begin
									E = 3'b001;
									if (positiveRepresentation[5] == 0) begin
										E = 3'b000;
									end
								end
							end
						end
					end
				end
			end
			
			
		end
			mantissa = (positiveRepresentation << 8 - E); // Thought this was just move over by E, but that was incorrect
	
		F = mantissa[12:8];
		
		
		// Rounding
		if (mantissa[7] == 1) begin // We have to round up
	 
			if (F != 5'b11111) begin
				F = F + 1'b1;
			
			end
			else begin // we have an overflow in F. F = 5'b11111
				if (E != 3'b111) begin
					
					E = E + 1'b1;
					F = 5'b10000;
					
				
				end
				
				//If we reach this, then Both our E and F are at max values, and we cannot go further
			
			end
		end
	end


endmodule