`timescale 1ns / 1ns


module clock_gen(
    input clk_in,
    input rst,
    output clk_div_2,
    output clk_div_4,
    output clk_div_8,
    output clk_div_16,
    output clk_div_28,
    output clk_div_5,
    output [7:0] toggle_counter
    );
    /* Output registers */
    reg clk2, clk4, clk8, clk16, clk28, clk5;
    reg [7:0] clk00;
    /* Counter registers */
    reg [4:0] counter; // Counter for basic dividers
    reg [4:0] counter_28; // 28 divider special counter
    reg [3:0] counter_5; // 5 divider special counter
    reg [1:0] strobe; // strobe on 3
	 
	 
	 
    always @(posedge clk_in) begin
        /* Reset signal */
        if(rst) begin
            strobe <= 0;
            counter <= 0;
            counter_5 <= 0;
            counter_28 <= 0;
            clk2 <= 0;
            clk4 <= 0;
            clk8 <= 0;
            clk16 <= 0;
            clk28 <= 0;
            clk5 <= 0;
            clk00 <= 0;
        end
        else begin 
            /* Basic Dividers */
            counter <= counter + 1;
            clk2 <= counter[0];
            clk4 <= counter[1];
            clk8 <= counter[2];
            clk16 <= counter[3];
            /* Clk-28 Divider */
            counter_28 <= counter_28 + 1; 
            if(counter_28 == 28) begin // Reset on counter == 28
                counter_28 <= 0;
            end
            if(counter_28 < 14) begin // Set low
                clk28 <= 0;
            end else begin // Set high
                clk28 <= 1;
            end
            /* Clk-5 Divider */
            if(counter_5 == 10) begin // Reset on counter == 10
                counter_5 <= 0;
            end
            if(counter_5 < 5) begin // Set low
                clk5 <= 0;
            end else begin // Set high
                clk5 <= 1;
            end
            counter_5 <= counter_5 + 1; 
            /* Strobe counter */
            if(strobe == 3) begin
                clk00 <= clk00 - 5;
            end else begin
                clk00 <= clk00 + 2;
            end
            strobe <= strobe + 1;
        end
    end
    /* Assign wires to register values */
    assign clk_div_2 = clk2;
    assign clk_div_4 = clk4;
    assign clk_div_8 = clk8;
    assign clk_div_16 = clk16;
    assign clk_div_28 = clk28;
    assign clk_div_5 = clk5;
    assign toggle_counter = clk00;
endmodule



