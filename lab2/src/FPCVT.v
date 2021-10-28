`timescale 1ns / 1ps

// 12 bits to floating point
//   7  |   6 5 4  | 3 2 1 0
//  sign| exponent | significand
module FPCVT(
    //Input data in Two's Complement Representation.
    input [11:0] D,
    // Sign bit of the Floating Point Representation.
    output S,
    // 3-Bit Exponent of the Floating Point Representation.
    output [2:0] E,
    // 4-Bit Significand of the Floating Point Representation.
    output [3:0] F
    );
    
    //create wires
    wire [11:0] m_abs_D; 
    wire [2:0] m_E;
    wire [3:0] m_F;
    wire m_sig_bit;
    wire out_S;
    wire [2:0] out_E;
    wire [3:0] out_F;

    // create 3 modules
    // sign module
    getSign m_getSign(
    .in_D(D),
    .out_S(out_S),
    .out_abs_D(m_abs_D)
    );
    // convert float module
    getConvertedFloat m_getConvertedFloat(
    .in_abs_D(m_abs_D),
    .out_E(m_E),
    .out_F(m_F),
    .out_sig_bit(m_sig_bit
    ));
    // round module
    getRoundedFloat m_getRoundedFloat(
    .in_E(m_E),
    .in_F(m_F),
    .in_sig_bit(m_sig_bit),
    .out_E(out_E),
    .out_F(out_F)
    );
    
    assign S = out_S;
    assign E = out_E;
    assign F = out_F;

endmodule

// change 12 bit 2's compliment into sign magnitude representation
module getSign(
    input [11:0] in_D,
    output out_S,
    output reg [11:0] out_abs_D
    );
    
    assign out_S = in_D[11];
    
    always @(*)
    begin
        out_abs_D = in_D;
        if ( in_D[11] == 1 )
        begin
            out_abs_D = ~in_D + 1;
            if (out_abs_D[11] == 1)
            begin
                // edge case for most negative value 10...0
                out_abs_D = ~out_abs_D;
            end
        end
    end
endmodule

// change 12 bit number with a sign bit to float 
// and has output for significant bit after significand
module getConvertedFloat(
    input [11:0] in_abs_D,
    output reg [2:0] out_E,
    output reg [3:0] out_F,
    output reg out_sig_bit
    );
    
    always @(*)
    begin
        casez ( in_abs_D )
            12'b01zz_zzzz_zzzz:
            begin
                out_E = 3'b111;
                out_F = in_abs_D[10:7];
                out_sig_bit = in_abs_D[6];
            end
            12'b001z_zzzz_zzzz:
            begin
                out_E = 3'b110;
                out_F = in_abs_D[9:6];
                out_sig_bit = in_abs_D[5];
            end
            12'b0001_zzzz_zzzz:
            begin
                out_E = 3'b101;
                out_F = in_abs_D[8:5];
                out_sig_bit = in_abs_D[4];
            end
            12'b0000_1zzz_zzzz:
            begin
                out_E = 3'b100;
                out_F = in_abs_D[7:4];
                out_sig_bit = in_abs_D[3];
            end
            12'b0000_01zz_zzzz:
            begin
                out_E = 3'b011;
                out_F = in_abs_D[6:3];
                out_sig_bit = in_abs_D[2];
            end
            12'b0000_001z_zzzz:
            begin
                out_E = 3'b010;
                out_F = in_abs_D[5:2];
                out_sig_bit = in_abs_D[1];
            end
            12'b0000_0001_zzzz:
            begin
                out_E = 3'b001;
                out_F = in_abs_D[4:1];
                out_sig_bit = in_abs_D[0];
            end
            default:
            begin
                out_E = 3'b000;
                out_F = in_abs_D[3:0];
                out_sig_bit = 0; // no significant bit behind the significand
            end
        endcase
    end
endmodule

// given 3 bit exponent, 4 bit significand, 
// and the significant bit after the significand
// round the number either up or down
module getRoundedFloat(
    input [2:0] in_E,
    input [3:0] in_F,
    input in_sig_bit,
    output reg [2:0] out_E,
    output reg [3:0] out_F
    );

    reg [4:0] overflow_F;
    reg [3:0] overflow_E;
    
    always @(*)
    begin
        // add the significant bit after the significand
        // to the float representation
        overflow_F = in_F + in_sig_bit;
        // if F overflows then increase the exponent by 1
        overflow_E = in_E + overflow_F[4];
        
        // catch the edge case where exponent overflows
        // 12'b0111_1111_111
        if ( overflow_E[3] )
        begin
            out_F = 4'b1111;
            out_E = 3'b111;
        end
        else
        begin
            // divide by 2 if overflowed
            out_F = overflow_F >> overflow_F[4];
            // truncate the exponent
            out_E = overflow_E[2:0];
        end
    end
endmodule

