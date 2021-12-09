`timescale 1ns / 1ps

module synthesizer(
    input wire clk,
    input wire [11:0] in_freq,
    input wire signal,
    inout wire [3:0] JA
    );

    wire [15:0] sig_square;

    reg [11:0] freq;
    reg isPlaying;
    reg [32:0] count;

    initial begin
        freq = 0;
        isPlaying = 0;
        count = 0;
    end

    // make the sound play for 1 second
    always @ (posedge clk)
    begin
        if (signal == 1 && isPlaying == 0)
        begin
            isPlaying <= 1;
            freq <= in_freq;
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

    square m_square (
        .freq (freq),
        .clk (JA[2]),
        .sig (sig_square)
    );

    make_out m_make_out (
        .sig (sig_square),
        .clk (clk),
        .masterClkP (JA[0]),
        .lrClkP (JA[1]),
        .sigClkP (JA[2]),
        .signalBitP (JA[3])
    );
endmodule

module square(
    input wire [11:0] freq, // input frequency
    input wire clk, // 1MHz clock JA[2]
    output reg [15:0] sig
    );

    reg [31:0] cycleCount; // count of time
    reg [31:0] sigHalfPeriod; // half period of signal

    initial begin
        sig <= 16'b0000111111111111;
        cycleCount <= 0;
        sigHalfPeriod <= 1000000/(440*2); // start at half of a 440Hz signal
    end

    always @(posedge clk)
    begin
        if (cycleCount >= sigHalfPeriod) begin
            sig <= ~sig; // flip signal each half period
            cycleCount <= 0;
        end
        else begin
            cycleCount <= cycleCount + 1;
        end
    end
    always @(freq)
    begin
        sigHalfPeriod = 1000000/(freq*2); // calculate frequency when it changes
    end
endmodule

module make_out(
    input wire [15:0] sig,
    input wire clk, // 100MHz clock
    output reg masterClkP, // master pmodi2s clock
    output reg lrClkP, // left-right clock for stereo
    output reg sigClkP, // single signal bit clock for pmodi2s
    output reg signalBitP // signal bit
    );

    // registers
    reg [15:0] sig_temp;

    // counters
    integer masterClkP_count;
    integer lrClkP_count;
    integer sigClkP_count;

    initial begin
        masterClkP <= 0;
        lrClkP <= 0;
        sigClkP <= 0;
        sig_temp <= sig;
        masterClkP_count <= 0;
        lrClkP_count <= 0;
        sigClkP_count <= 0;
    end

    always @(posedge clk)
    begin
        if (masterClkP_count == 25) begin // 2000kHz / 5
            masterClkP = ~masterClkP;
            masterClkP_count = 0;
        end
        if (sigClkP_count == 50) begin // 1000kHz / 5
            sigClkP = ~sigClkP;
            sigClkP_count = 0;
            if (sigClkP == 0) begin // send the audio to output every negative edge of signal clk
                signalBitP = sig_temp[15];
                sig_temp = sig_temp << 1;
            end
        end
        if (lrClkP_count == 1600) begin // 31.25kHz / 5
            lrClkP = ~lrClkP;
            lrClkP_count = 0;
            sig_temp = sig; // reset the temp signal when swapping sides of audio
        end
        // increment all counters
        masterClkP_count = masterClkP_count + 1;
        lrClkP_count = lrClkP_count + 1;
        sigClkP_count = sigClkP_count + 1;
    end
endmodule
