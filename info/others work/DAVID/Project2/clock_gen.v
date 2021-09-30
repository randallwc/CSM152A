`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Top level module of clock generator
//////////////////////////////////////////////////////////////////////////////////
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
    
    clock_div_two task_one(
        .clk_in (clk_in),
        .rst (rst),
        .clk_div_2(clk_div_2),
        .clk_div_4(clk_div_4),
        .clk_div_8(clk_div_8),
        .clk_div_16(clk_div_16)
    );
    clock_div_even task_two(
        .clk_in (clk_in),
        .rst (rst),
        .clk_div_28(clk_div_28)
    );
    clock_div_odd task_three(
        .clk_in (clk_in),
        .rst (rst),
        .clk_div_5(clk_div_5)
    );
    clock_strobe task_four(
        .clk_in (clk_in),
        .rst (rst),
        .glitchy_counter (toggle_counter)
    );
endmodule

// Design Task 1
module clock_div_two (
	input clk_in,
	input rst,
   output clk_div_2,
   output clk_div_4,
   output clk_div_8,
   output clk_div_16
	);
   reg[3:0] counter = 4'b0000;
	always @ (posedge clk_in) begin
		if (rst)
			counter = 4'b0000;
		else
			counter = counter + 1'b1;
   end
	assign clk_div_2 = counter[0];
	assign clk_div_4 = counter[1];
	assign clk_div_8 = counter[2];
	assign clk_div_16 = counter[3];
endmodule

// Design Task 2
module clock_div_even (
	input clk_in,
   input rst,
   output clk_div_28
	);
	
	reg[3:0] counter = 4'b0000;
	reg clk_div_28 = 0;
	always @ (posedge clk_in) begin
		if (rst) begin
			counter = 4'b0000;
			clk_div_28 = 0;
			end
		else begin
			if (counter == 4'b1101) begin
			   clk_div_28 = ~clk_div_28;
				counter = 4'b0000;
			end
			else
				counter = counter + 1;
		end
   end
endmodule

// Design Task 3
module clock_div_odd(
	input clk_in,
   input rst,
   output clk_div_5
	);
	
	reg[2:0] counter_pos = 4'b000;
	reg[2:0] counter_neg = 4'b000;
	reg clk_div_odd_pos = 0;
	reg clk_div_odd_neg = 0;
	
	assign clk_div_5 = clk_div_odd_pos | clk_div_odd_neg;
	
	always @ (posedge clk_in) begin
		if (rst) begin
			counter_pos = 4'b000;
			clk_div_odd_pos = 0;
			end
		else begin
			if (counter_pos == 4'b100) begin
			   clk_div_odd_pos = 0;
				counter_pos = 4'b000;
			end
			else begin
				counter_pos = counter_pos + 1;
				if(counter_pos == 4'b011)
					clk_div_odd_pos = 1;
			end
		end
   end
	always @ (negedge clk_in) begin
		if (rst) begin
			counter_neg = 4'b000;
			clk_div_odd_neg = 0;
			end
		else begin
			if (counter_neg == 4'b100) begin
			   clk_div_odd_neg = 0;
				counter_neg = 4'b000;
			end
			else begin
				counter_neg = counter_neg + 1;
				if(counter_neg == 4'b011)
					clk_div_odd_neg = 1;
			end
		end
   end
endmodule

// Design Task 4
module clock_strobe(
	input clk_in,
	input rst,
	output [7:0] glitchy_counter
    );
		
	reg[1:0] counter = 2'b00; 
	reg[7:0] glitchy_counter = 8'b00000000;
	reg pulse = 0;

	always @ (negedge clk_in) begin
		if (rst) begin
			counter = 2'b00;
			pulse = 0;
			end
		else begin
			if (counter == 2'b11) begin
			   pulse = 1;
				counter = 2'b00;
			end
			else begin
				counter = counter + 1;
				pulse = 0;
			end
		end
   end
	
	// Counter
	always @ (posedge clk_in) begin
		if (rst) 
			glitchy_counter = 8'b00000000;
		else begin
			if (pulse)
				glitchy_counter = glitchy_counter - 5;
			else
				glitchy_counter = glitchy_counter + 2;
		end
	end
endmodule
	