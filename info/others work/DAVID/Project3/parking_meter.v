`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// parking_meter
//////////////////////////////////////////////////////////////////////////////////
module parking_meter(
    input add1,
    input add2,
    input add3,
    input add4,
    input rst1,
    input rst2,
    input clk,                 // Assume input clock is 100Hz
    input rst,         
    output [3:0] val1,		    // BCD values to be displayed
    output [3:0] val2,
    output [3:0] val3,
    output [3:0] val4,
    output [6:0] led_cathodes,  // Cathodes for seven-segment display
    output [3:0] led_anodes	 // Anode of 4 seven-segment display, will be used for flashing control
	 );
	 
	 // States: All actions are equivalent to a state with addition
	 // of transition state "WAIT"
	 parameter IDLE = 3'b000;
	 parameter RST1 = 3'b001;
	 parameter RST2 = 3'b010;
	 parameter ADD1 = 3'b011;
	 parameter ADD2 = 3'b100;
	 parameter ADD3 = 3'b101;
	 parameter ADD4 = 3'b110;
	 parameter WAIT = 3'b111;
	 
	 reg[2:0] curr_state = IDLE;
	 reg[2:0] next_state;
	 reg[13:0] time_counter = 14'b00000000000000; // Global Counter
	 reg[7:0] clk_count;
	 reg      pulse_onehz;
	 reg      toggle;
	 
	 // Convert time_counter to BCD
	 BCD_converter BCD_converter1(.global_counter(time_counter),
											.ones(val4),
											.tens(val3),
											.hundreds(val2),
											.thousands(val1)
											);

	 // LED Controller:
	 // Handles flash timing and decodes BCD to cathode ports
	 // Multiplexing control on anodes
	 LED_controller LED_controller (.clk(clk),
											  .toggle(toggle),
											  .rst(rst),
											  .ones(val4),
											  .tens(val3),
											  .hundreds(val2),
											  .thousands(val1),
											  .led_anode(led_anodes),
											  .led_cathode(led_cathodes)); 
										
	 // Moore Finite State Machine
	 // Update State
	 always @(posedge clk) begin
		if(rst)
			curr_state <= IDLE;
		else
			curr_state <= next_state;
	 end
	 
	 // Next State 
	 // Note: we don't have to deal with multiple inputs - this simplifies state machine
	 always @(*) begin
		case(curr_state)
		IDLE: begin
				if(rst1)
					next_state <= RST1;
				else if(rst2)
					next_state <= RST2; 
				else if(add1)
					next_state <= ADD1;
				else if(add2)
					next_state <= ADD2;
				else if(add3)
					next_state <= ADD3;
				else if(add4)
					next_state <= ADD4;
				else
					next_state <= IDLE;
				end
				
		RST1, RST2, ADD1, ADD2, ADD3, ADD4: 
					next_state <= WAIT;
					
		WAIT: begin
				if(time_counter == 0)
					next_state <= IDLE;
				else if(rst1)
					next_state <= RST1;
				else if(rst2)
					next_state <= RST2; 
				else if(add1)
					next_state <= ADD1;
				else if(add2)
					next_state <= ADD2;
				else if(add3)
					next_state <= ADD3;
				else if(add4)
					next_state <= ADD4;
				else
					next_state <= WAIT;
				end
		endcase
	end
	
	// Output Logic for State Machine, Sequential since we have to deal with global counter
	always @(posedge clk or posedge rst) begin
	   if(rst)
			time_counter <= 0;
		else begin
		case(curr_state)
		IDLE: time_counter <= 14'd0;
		RST1: time_counter <= 14'd16;
		RST2: time_counter <= 14'd150;
		ADD1: begin
 			if(time_counter > 9939)
				time_counter <= 9999;
			else
				time_counter <= time_counter + 60;
			end
		ADD2: begin
			if(time_counter > 9879)
				time_counter <= 9999;
			else 
				time_counter <= time_counter + 120;
			end
		ADD3: begin
			if(time_counter > 9819)
				time_counter <= 9999;
			else
				time_counter <= time_counter + 180;
			end
		ADD4: begin				
			if(time_counter > 9699)
				time_counter <= 9999;
			else
				time_counter <= time_counter + 300;
			end
		WAIT:
			if (time_counter != 0 & pulse_onehz)
			time_counter <= time_counter - 1;
		endcase
		end
	end
	
	
	// Timing Block Logic
	always@(posedge clk) begin
		if(rst | rst1 | rst2 ) begin
			clk_count <= 8'b0;
			pulse_onehz <= 0;
			toggle <= 0;
			end
		else if((add1 | add2 | add3 | add4) & (time_counter == 0)) begin
			clk_count <= 8'b0;
			pulse_onehz <= 0;
			toggle <= 0;
			end	
		else begin
			// Clk count
			if (clk_count == 8'd199) 
				clk_count <= 0;
			else 
				clk_count <= clk_count + 1;
			
			// Pulse One Hz
			if ((clk_count == 8'd99) | (clk_count == 8'd199))
				pulse_onehz <= 1;
			else
				pulse_onehz <= 0;
				
			// Toggle logic
			// 1 second period 50% duty cycle
			if (time_counter == 0) begin
				if(clk_count <= 49 || ((clk_count >= 100) && (clk_count <= 149)))
					toggle <= 1;
				else
					toggle <= 0;
				end
			// No flashing when time_counter > 0
			else if (time_counter > 180) begin
				toggle <= 1;
				end
			// 2 second period 50% duty cycle
			else begin
				if(clk_count <= 99)
					toggle <= 1;
				else
					toggle <= 0;
				end
		end
	end
endmodule

// Convert counter output from binary to BCD
module BCD_converter (
	input[13:0] global_counter,
	output[3:0] ones,
	output[3:0] tens,
	output[3:0] hundreds,
	output[3:0] thousands
	);
	
	assign ones = global_counter%10;
	assign tens = (global_counter/10)%10;
	assign hundreds = (global_counter/100) %10;
	assign thousands = (global_counter/1000) %10;
endmodule

module LED_controller (
	input clk,
	input rst,
	input toggle,
	input[3:0] ones,
	input[3:0] tens,
	input[3:0] hundreds,
	input[3:0] thousands,
	output reg[3:0] led_anode,
	output reg[6:0] led_cathode
	);

	//Converts BCD input into digit on 7-segment led display
	function[6:0] display_digit(input[3:0] num);
		case(num)
			4'd1: display_digit = 7'b1001111;
			4'd2: display_digit = 7'b0010010;
			4'd3: display_digit = 7'b0000110;
			4'd4: display_digit = 7'b1001100;
			4'd5: display_digit = 7'b0100100;
			4'd6: display_digit = 7'b0100000;
			4'd7: display_digit = 7'b0001111;
			4'd8: display_digit = 7'b0000000;
			4'd9: display_digit = 7'b0000100;
			default: display_digit = 7'b0000001;
		endcase
	endfunction
	// Used to multiplex
	reg[1:0] i = 0;

	// Flash controller, multiplex the LED display with anodes
	always @(posedge clk) begin
		if(rst) begin
			i <= 0;
		end
		if(toggle) begin
				case(i)
					// Light Ones Digit
					0: begin
						led_anode <= 4'b1110;
						led_cathode <= display_digit(ones);
					end
					// Light Tens Digit
					1: begin
						led_anode <= 4'b1101;
						led_cathode <= display_digit(tens);
					end
					// Light Hundreds Digit
					2: begin
						led_anode <= 4'b1011;
						led_cathode <= display_digit(hundreds);
					end
					// Light Thousands Digit
					3: begin
						led_anode <= 4'b0111;
						led_cathode <= display_digit(thousands);
					end
				endcase
			   i <= i + 1;
		end
		else begin
			led_anode <= 4'b1111;
			led_cathode <= 7'b1111111;
		end
	end
endmodule