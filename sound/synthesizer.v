`timescale 1ns / 1ps

module synthesizer(clk, signal,JA);
    input clk;
    input signal;
    inout [3:0] JA;

    wire [15:0] sig_square;
    reg [11:0] freq = 440;

    reg isPlaying;
    reg [32:0] count;
    
    // TODO
        // make a counter
        // make a flag isPlaying
    always @ (posedge clk)
    begin
        if (signal == 1 && isPlaying == 0)
        begin
            isPlaying <= 1;
            freq <= 440;
            count <= 50000000;
        end
        else if (signal == 1 && isPlaying == 1) begin
            count <= 50000000;
        end
        else if (isPlaying == 1 && count > 0) begin
            count <= count - 1;
        end else if (isPlaying == 1 && count == 0) begin
            isPlaying <= 0;
            freq <= 0;
        end
    end
    
    osc_square squosc_ (
        .freq   (freq),
        .clk    (JA[2]),
        .sig    (sig_square)
    );

    pmod_out out_ (
        .sig    (sig_square),
        .clk    (clk),
        .MCLK   (JA[0]),
        .LRCLK  (JA[1]),
        .SCLK   (JA[2]),
        .SDIN   (JA[3])
    );

endmodule
