`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Vending Machine
//////////////////////////////////////////////////////////////////////////////////
module vending_machine(
    input CLK,
    input RESET,
    input RELOAD,
    input CARD_IN,
    input [3:0] ITEM_CODE,
    input KEY_PRESS,
    input VALID_TRAN,
    input DOOR_OPEN,
    output reg VEND,
    output reg INVALID_SEL,
    output reg [2:0] COST,
    output reg FAILED_TRAN
    );
reg [3:0] slot_0;
reg [3:0] slot_1;
reg [3:0] slot_2;
reg [3:0] slot_3;
reg [3:0] slot_4;
reg [3:0] slot_5;
reg [3:0] slot_6;
reg [3:0] slot_7;
reg [3:0] slot_8;
reg [3:0] slot_9;
reg [3:0] slot_10;
reg [3:0] slot_11;
reg [3:0] slot_12;
reg [3:0] slot_13;
reg [3:0] slot_14;
reg [3:0] slot_15;
reg [3:0] slot_16;
reg [3:0] slot_17;
reg [3:0] slot_18;
reg [3:0] slot_19;
reg [5:0] five_cycles_counter = 0;
reg [5:0] initial_count = 0;

// Have counter run in another procedural block
always @(posedge CLK) begin
	 if (!(curr_state == S_TRANSACT || 
			curr_state == S_ONES_DIGIT || 
			curr_state == S_TENS_DIGIT ||
			curr_state == S_VALID || 
			curr_state == S_VEND || 
			curr_state == S_DOOR_OPEN))
			five_cycles_counter <= 0;
	 else
			five_cycles_counter <= five_cycles_counter + 1;
end

// States Declaration: 12 States Total
parameter S_IDLE = 4'b0000;
parameter S_RESET = 4'b0001;
parameter S_RELOAD = 4'b0010;
parameter S_TRANSACT = 4'b0011;
parameter S_ONES_DIGIT = 4'b0100;
parameter S_TENS_DIGIT = 4'b0101;
parameter S_VALID = 4'b0110;
parameter S_INVALID = 4'b0111;
parameter S_FAILED_TRAN = 4'b1000;
parameter S_VEND = 4'b1001;
parameter S_DOOR_OPEN = 4'b1010;
parameter S_DOOR_CLOSE = 4'b1011;

reg[3:0] curr_state = S_IDLE;
reg[3:0] next_state;
reg[3:0] ones_digit;
reg[3:0] tens_digit;
reg[7:0] item_num;
reg set_ones_digit;
reg set_tens_digit;
reg decrement_flag;

// Determine the item number with inputed ITEM_CODE
always @(*) begin
    item_num <= (tens_digit * 10) + ones_digit;
end

// Mealy Finite State Machine
// Update State
always @(posedge CLK) begin
if(RESET)
    curr_state <= S_RESET;
else
    curr_state <= next_state;
end

// Next State 
always @(*) begin
    case(curr_state)
        S_IDLE: begin
            if(RELOAD)
                next_state <= S_RELOAD; 
            else if(CARD_IN) begin
					 initial_count <= five_cycles_counter;
                next_state <= S_TRANSACT;
				end
            else
                next_state <= S_IDLE;
        end
		  // If during anyone of transaction states, CARD_IN goes low return to IDLE
		  // S_TRANSACT, S_ONES_DIGIT, S_TENS_DIGIT, S_VALID, S_INVALID
        S_TRANSACT: begin
				if (~CARD_IN) 
					 next_state <= S_IDLE;
            else if(KEY_PRESS) begin
                initial_count <= five_cycles_counter;
                next_state <= S_ONES_DIGIT;
				end
            else if (five_cycles_counter - initial_count >= 4)
                next_state <= S_INVALID;
            else
                next_state <= S_TRANSACT; 
        end

        S_ONES_DIGIT: begin
		  		if (~CARD_IN) 
					 next_state <= S_IDLE;
            else if(KEY_PRESS)
                next_state <= S_TENS_DIGIT;
            else if (five_cycles_counter - initial_count >= 5)
                next_state <= S_INVALID;
            else 
                next_state <= S_ONES_DIGIT;
        end

        S_TENS_DIGIT: begin
				if (~CARD_IN) 
					 next_state <= S_IDLE;
				else begin
					initial_count <= five_cycles_counter;
					case(item_num)
						 0: next_state <= ((slot_0 > 0) ? S_VALID: S_INVALID);
						 1: next_state <= ((slot_1 > 0) ? S_VALID: S_INVALID);
						 2: next_state <= ((slot_2 > 0) ? S_VALID: S_INVALID);
						 3: next_state <= ((slot_3 > 0) ? S_VALID: S_INVALID);
						 4: next_state <= ((slot_4 > 0) ? S_VALID: S_INVALID);
						 5: next_state <= ((slot_5 > 0) ? S_VALID: S_INVALID);
						 6: next_state <= ((slot_6 > 0) ? S_VALID: S_INVALID);
						 7: next_state <= ((slot_7 > 0) ? S_VALID: S_INVALID);
						 8: next_state <= ((slot_8 > 0) ? S_VALID: S_INVALID);
						 9: next_state <= ((slot_9 > 0) ? S_VALID: S_INVALID);
						 10: next_state <= ((slot_10 > 0) ? S_VALID: S_INVALID);
						 11: next_state <= ((slot_11 > 0) ? S_VALID: S_INVALID);
						 12: next_state <= ((slot_12 > 0) ? S_VALID: S_INVALID);
						 13: next_state <= ((slot_13 > 0) ? S_VALID: S_INVALID);
						 14: next_state <= ((slot_14 > 0) ? S_VALID: S_INVALID);
						 15: next_state <= ((slot_15 > 0) ? S_VALID: S_INVALID);
						 16: next_state <= ((slot_16 > 0) ? S_VALID: S_INVALID);
						 17: next_state <= ((slot_17 > 0) ? S_VALID: S_INVALID);
						 18: next_state <= ((slot_18 > 0) ? S_VALID: S_INVALID);
						 19: next_state <= ((slot_19 > 0) ? S_VALID: S_INVALID);
						 default: next_state <= S_INVALID;
					endcase
				end
        end

        S_VALID: begin
				if (VALID_TRAN) begin
                initial_count <= five_cycles_counter;
                next_state <= S_VEND;
				end
            else if (five_cycles_counter - initial_count >= 5)
                next_state <= S_FAILED_TRAN;
            else
                next_state <= S_VALID;
        end

        S_VEND: begin
            if (DOOR_OPEN) begin
                initial_count <= five_cycles_counter;
                next_state <= S_DOOR_OPEN;
				end
            else if (five_cycles_counter - initial_count >= 5)
                next_state <= S_IDLE;
            else 
                next_state <= S_VEND;
        end
        
        S_DOOR_OPEN: begin
            if (!DOOR_OPEN)
                next_state <= S_DOOR_CLOSE;
            else if (five_cycles_counter - initial_count >= 5)
                next_state <= S_IDLE;
            else 
                next_state <= S_DOOR_OPEN;
        end
		  // S_RESET, S_RELOAD, S_INVALID, S_FAILED_TRAN, S_DOOR_CLOSE
		  default: begin
			   initial_count <= 0;
            next_state <= S_IDLE;
		  end
    endcase
end

always @(posedge CLK) begin
	case(curr_state)
		S_RESET: begin
		      slot_0 <= 0;
				slot_1 <= 0;
				slot_2 <= 0;
				slot_3 <= 0;
				slot_4 <= 0;
				slot_5 <= 0;
				slot_6 <= 0;
				slot_7 <= 0;
				slot_8 <= 0;
				slot_9 <= 0;
				slot_10 <= 0;
				slot_11 <= 0;
				slot_12 <= 0;
				slot_13 <= 0;
				slot_14 <= 0;
				slot_15 <= 0;
				slot_16 <= 0;
				slot_17 <= 0;
				slot_18 <= 0;
				slot_19 <= 0;
				decrement_flag <= 0;
		end
		S_RELOAD: begin
		      slot_0 <= 10;
				slot_1 <= 10;
				slot_2 <= 10;
				slot_3 <= 10;
				slot_4 <= 10;
				slot_5 <= 10;
				slot_6 <= 10;
				slot_7 <= 10;
				slot_8 <= 10;
				slot_9 <= 10;
				slot_10 <= 10;
				slot_11 <= 10;
				slot_12 <= 10;
				slot_13 <= 10;
				slot_14 <= 10;
				slot_15 <= 10;
				slot_16 <= 10;
				slot_17 <= 10;
				slot_18 <= 10;
				slot_19 <= 10;
				decrement_flag <= 0;
		end
		S_VEND: begin
				if(~decrement_flag) begin
					decrement_flag <= 1;
					case (item_num)
						 0: slot_0 <= slot_0 - 1;
						 1: slot_1 <= slot_1 - 1;
						 2: slot_2 <= slot_2 - 1;
						 3: slot_3 <= slot_3 - 1;
						 4: slot_4 <= slot_4 - 1;
						 5: slot_5 <= slot_5 - 1;
						 6: slot_6 <= slot_6 - 1;
						 7: slot_7 <= slot_7 - 1;
						 8: slot_8 <= slot_8 - 1;
						 9: slot_9 <= slot_9 - 1;
						 10: slot_10 <= slot_10 - 1;
						 11: slot_11 <= slot_11 - 1;
						 12: slot_12 <= slot_12 - 1;
						 13: slot_13 <= slot_13 - 1;
						 14: slot_14 <= slot_14 - 1;
						 15: slot_15 <= slot_15 - 1;
						 16: slot_16 <= slot_16 - 1;
						 17: slot_17 <= slot_17 - 1;
						 18: slot_18 <= slot_18 - 1;
						 19: slot_19 <= slot_19 - 1;
					endcase
				end
		end
		default: decrement_flag <= 0;
	endcase
end
			
			
// Output Logic for State Machine, Combinatorial
always @(*) begin
    case(curr_state)
        S_IDLE, S_TRANSACT: begin
            VEND <= 0;
            INVALID_SEL <= 0;
            FAILED_TRAN <= 0;
            COST <= 3'b000;
            set_ones_digit <= 0;
            set_tens_digit <= 0;
				ones_digit <= 0;
				tens_digit <= 0;
        end
        S_RESET: begin
            VEND <= 0;
            INVALID_SEL <= 0;
            FAILED_TRAN <= 0;
            COST <= 3'b000;
        end
        S_RELOAD: begin
		      VEND <= 0;
            INVALID_SEL <= 0;
            FAILED_TRAN <= 0;
				COST <= 3'b000;
        end
        // Remember item code inputed into vending machine
        S_ONES_DIGIT: begin
            if (~set_ones_digit) begin
                set_ones_digit <= 1;
                ones_digit <= ITEM_CODE;
            end
        end
        S_TENS_DIGIT: begin
            if (~set_tens_digit) begin
                set_tens_digit <= 1;
                tens_digit <= ITEM_CODE;
            end
        end
        S_INVALID: begin
           INVALID_SEL <= 1; 
        end
        S_VALID: begin
            // Find the cost of the item 
            COST <= item_cost(item_num);
        end 
        S_FAILED_TRAN: begin
           FAILED_TRAN <= 1; 
        end
        S_VEND: begin
           // Decrement count of item in vending machine and sent VEND to high
				VEND <= 1;
        end
		  default: begin
		      set_ones_digit <= 0;
            set_tens_digit <= 0;
				ones_digit <= 0;
				tens_digit <= 0;
		  end
        /* DOOR_CLOSE and DOOR_OPEN do not output anything from previous states. 
           Therefore, there is no need to include. */
    endcase
end

// Function to retrieve cost of item
function[2:0] item_cost(input[3:0] item_num);
    if (item_num >= 0 && item_num <=3)
        item_cost = 1;
    else if (item_num >= 4 && item_num <= 7) 
        item_cost = 2;
    else if (item_num >= 8 && item_num <= 11) 
        item_cost = 3;
    else if (item_num >= 12 && item_num <= 15) 
        item_cost = 4;
    else if (item_num >= 16 && item_num <= 17) 
        item_cost = 5;
    else 
        item_cost = 6;
endfunction     

endmodule
