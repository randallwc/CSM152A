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
		
		
		reg [4:0] CURR_STATE = 0;
		reg [4:0] NEXT_STATE = 0;
		reg [3:0] CT0;
		reg [3:0] CT1;
		reg [3:0] CT2;
		reg [3:0] CT3;
		reg [3:0] CT4;
		reg [3:0] CT5;
		reg [3:0] CT6;
		reg [3:0] CT7;
		reg [3:0] CT8;
		reg [3:0] CT9;
		reg [3:0] CT10;
		reg [3:0] CT11;
		reg [3:0] CT12;
		reg [3:0] CT13;
		reg [3:0] CT14;
		reg [3:0] CT15;
		reg [3:0] CT16;
		reg [3:0] CT17;
		reg [3:0] CT18;
		reg [3:0] CT19;
		
		reg [2:0] key_press1;
		reg [2:0] key_press2;

		
		
		reg [2:0] cycle5counter;
		reg wasfirstkeypressed = 0;
		reg shouldIkeepcounting = 0;
		reg shouldIresetclock = 0;
		
		
		
		
		parameter [4:0] IDLE = 0;
		parameter [4:0] RELOAD_STATE = 1;
		parameter [4:0] CARD_INSERTED = 2;
		parameter [4:0] KEYPRESS1 = 3;
		parameter [4:0] KEYPRESS2 = 4;
		
		
		parameter [4:0] VALIDATE_TRANSACTION = 5;
		parameter [4:0] VEND_STATE = 6;
		parameter [4:0] FAIL_STATE = 7;
		parameter [4:0] OPEN_DOOR_STATE = 8;
		parameter [4:0] RESET_STATE = 9;
		
		
		
		parameter [4:0] GENERAL_WAIT_FOR_CYCLES = 10;
		parameter [4:0] GENERAL_WAIT_FOR_TRANSACTION = 11;
		parameter [4:0] GENERAL_WAIT_FOR_VEND = 12;
		parameter [4:0] GENERAL_INPUT_WAS_VALID = 13;
		parameter [4:0] GENERAL_INPUT_WAS_INVALID = 14;
		
		

		
		// Update state
		// this also allows us to change to reset instead of proceed w next state
		always @(posedge CLK)
		begin
		
			// how we are originally going to start this is with resetting the whole module at first, so we can check for RESET signal here
			if (RESET)
			begin
				CURR_STATE <= IDLE;
			end
			else
			begin
				CURR_STATE <= NEXT_STATE;
			end
			
			
		end
	
		
		
		// take care of when to reset counter
		always @(posedge CLK)
		begin
			if (shouldIresetclock == 0 &&( CURR_STATE == CARD_INSERTED || CURR_STATE == GENERAL_INPUT_WAS_VALID || CURR_STATE == VEND_STATE))
			begin
				shouldIresetclock = 1;
			end
			else
			begin
				shouldIresetclock = 0;
			end
		end
		
		
		// take care of cycle counter
		always @(posedge CLK)
		begin
			if (shouldIresetclock)
			begin
				cycle5counter = 0;
			end
			else
			begin
				cycle5counter = cycle5counter + 1;
			end
		end
		
		
		
	






		// Handle outputs that will be displayed on simulation
		always @(CURR_STATE) 
		begin
		
			if(CURR_STATE == RELOAD_STATE || CURR_STATE == RESET_STATE || CURR_STATE == IDLE || CURR_STATE == CARD_INSERTED || CURR_STATE == KEYPRESS1 || CURR_STATE == KEYPRESS2 || CURR_STATE == GENERAL_WAIT_FOR_CYCLES || CURR_STATE == VALIDATE_TRANSACTION)
			begin
			
				VEND = 0;
				INVALID_SEL = 0;
				COST = 0;
				FAILED_TRAN = 0;
			
			end
			else if (CURR_STATE == GENERAL_INPUT_WAS_INVALID)
			begin
			
				VEND = 0;
				INVALID_SEL = 1;
				COST = 0;
				FAILED_TRAN = 0;
			
			end
			else if (CURR_STATE == FAIL_STATE)
			begin
			
				VEND = 0;
				INVALID_SEL = 0;
				COST = 0;
				FAILED_TRAN = 1;
			
			end
			else if (CURR_STATE == VEND_STATE)
			begin
				// leave rest to be updated later possibly
				VEND = 1;
			
			end
			else if (CURR_STATE == GENERAL_INPUT_WAS_VALID)
			begin

				
				if(key_press1 == 0 && key_press2 >= 0 && key_press2 <= 3)
				begin
					COST = 1;
				end
				else if(key_press1 == 0 && key_press2 >= 4 && key_press2 <= 7)
				begin
					COST = 2;
				end
				else if((key_press1 == 0 &&( key_press2 == 8 || key_press2 == 9)) || (key_press1 == 1 && (key_press2 == 0 || key_press2 == 1)))
				begin
					COST = 3;
				end
				else if(key_press1 == 1 && key_press2 >= 2 && key_press2 <= 5)
				begin
					COST = 4;
				end
				else if(key_press1 == 1 && key_press2 >= 6 && key_press2 <= 7 )
				begin
					COST = 5;
				end
				else if(key_press1 == 1 && (key_press2 == 8 || key_press2 == 9))
				begin
					COST = 6;
				end
				
				
				
				
			end
		end
		
		
		
		
		
		// RESET, RELOAD, AND "VENDING" A ITEM OUT OF THE VENDING MACHINE
		always @(CURR_STATE)
		begin
			if(CURR_STATE == RESET_STATE) // per specs, reset all counters to 0 on reset
			begin
				CT0 <= 0;
				CT1 <= 0;
				CT2 <= 0;
				CT3 <= 0;
				CT4 <= 0;
				CT5 <= 0;
				CT6 <= 0;
				CT7 <= 0;
				CT8 <= 0;
				CT9 <= 0;
				CT10 <= 0;
				CT11 <= 0;
				CT12 <= 0;
				CT13 <= 0;
				CT14 <= 0;
				CT15 <= 0;
				CT16 <= 0;
				CT17 <= 0;
				CT18 <= 0;
				CT19 <= 0;
			end
			else if (CURR_STATE == RELOAD_STATE)
			begin
				CT0 <= 10;
				CT1 <= 10;
				CT2 <= 10;
				CT3 <= 10;
				CT4 <= 10;
				CT5 <= 10;
				CT6 <= 10;
				CT7 <= 10;
				CT8 <= 10;
				CT9 <= 10;
				CT10 <= 10;
				CT11 <= 10;
				CT12 <= 10;
				CT13 <= 10;
				CT14 <= 10;
				CT15 <= 10;
				CT16 <= 10;
				CT17 <= 10;
				CT18 <= 10;
				CT19 <= 10;	
			end
			else if (CURR_STATE == VEND_STATE)
			begin
			
			//concatination is going to look ugly but it works enough
			//implementing an actual concatination module seemed complicated as heck
			 
				if(key_press1 == 0)
				begin
					if (key_press2 == 0)
					begin
						CT0 <= CT0 - 1;
					end
					else if (key_press2 == 1)
					begin
						CT1 <= CT1 - 1;
					end
					else if (key_press2 == 2)
					begin
						CT2 <= CT2 - 1;
					end
					else if (key_press2 == 3)
					begin
						CT3 <= CT3 - 1;
					end
					else if (key_press2 == 4)
					begin
						CT4 <= CT4 - 1;
					end
					else if (key_press2 == 5)
					begin
						CT5 <= CT5 - 1;
					end
					else if (key_press2 == 6)
					begin
						CT6 <= CT6 - 1;
					end
					else if (key_press2 == 7)
					begin
						CT7 <= CT7 - 1;
					end
					else if (key_press2 == 8)
					begin
						CT8 <= CT8 - 1;
					end
					else if (key_press2 == 9)
					begin
						CT9 <= CT9 - 1;
					end
				end
			end
			else if (key_press1 == 1)
			begin
					if (key_press2 == 0)
					begin
						CT10 <= CT10 - 1;
					end
					else if (key_press2 == 1)
					begin
						CT11 <= CT11 - 1;
					end
					else if (key_press2 == 2)
					begin
						CT12 <= CT12 - 1;
					end
					else if (key_press2 == 3)
					begin
						CT13 <= CT13 - 1;
					end
					else if (key_press2 == 4)
					begin
						CT14 <= CT14 - 1;
					end
					else if (key_press2 == 5)
					begin
						CT15 <= CT15 - 1;
					end
					else if (key_press2 == 6)
					begin
						CT16 <= CT16 - 1;
					end
					else if (key_press2 == 7)
					begin
						CT17 <= CT17 - 1;
					end
					else if (key_press2 == 8)
					begin
						CT18 <= CT18 - 1;
					end
					else if (key_press2 == 9)
					begin
					CT19 <= CT19 - 1;
					end
			end
		end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
		// Determine next state, pretty much the largest bulk of code
		always @(*)
		begin
		
			if (CURR_STATE == RESET_STATE) /////////RESET
			begin
				NEXT_STATE = IDLE;
				shouldIkeepcounting = 0;
			end	
			
			
			
			
			
			else if(CURR_STATE == IDLE) ///////////IDLE
			begin
				
				shouldIkeepcounting = 0;
				wasfirstkeypressed = 0; // we reset the stuff we put into key code
				if(RELOAD)
				begin
					NEXT_STATE = RELOAD_STATE;
				end
				else if(CARD_IN)
				begin
					NEXT_STATE = CARD_INSERTED;
				end
				else
				begin
					NEXT_STATE = IDLE;//nothing happened, lets stay in IDLE mode
				end
		
			end
			
			
			
			
			
			
			
			else if (CURR_STATE == CARD_INSERTED) /////////////////CARD INSERTED
			begin
				if (KEY_PRESS && wasfirstkeypressed)
				begin
					key_press2 = ITEM_CODE;
					NEXT_STATE = VALIDATE_TRANSACTION;
					key_press1 = key_press1;
					shouldIkeepcounting = 0;
				end
				else if (KEY_PRESS && ~wasfirstkeypressed)
				begin
					key_press1 = ITEM_CODE;
					key_press2 = key_press2;//
					wasfirstkeypressed = 1;
					NEXT_STATE = CARD_INSERTED; // only the first was entered, run it back
					shouldIkeepcounting = 1;
				end
				else
				begin
					NEXT_STATE = GENERAL_WAIT_FOR_CYCLES;
					key_press1 = key_press1;
					key_press2 = key_press2;
					shouldIkeepcounting = 1;
				end
			end
			
			
			
			
			else if (CURR_STATE == GENERAL_WAIT_FOR_CYCLES)
			begin
				
				if(cycle5counter == 5)
				begin
					NEXT_STATE = GENERAL_INPUT_WAS_INVALID;
					shouldIkeepcounting = 0;
				end
				else if (KEY_PRESS && wasfirstkeypressed)
				begin // do nothing
					key_press2 = ITEM_CODE;
					key_press1 = key_press1;
					NEXT_STATE = VALIDATE_TRANSACTION;
					shouldIkeepcounting = 0;
				end
				else if (KEY_PRESS && !wasfirstkeypressed)
				begin
					key_press1 = ITEM_CODE;
					key_press2 = 0;
					NEXT_STATE = CARD_INSERTED;
					wasfirstkeypressed = 1;
					shouldIkeepcounting = 0;
					
				end
				else
				begin
					key_press1 = key_press1;
					key_press2 = key_press2;
					NEXT_STATE = GENERAL_WAIT_FOR_CYCLES;
					shouldIkeepcounting = 1;
					
				end
			end
			
			
			
			
			else if (CURR_STATE == RELOAD_STATE)
			begin
				NEXT_STATE = IDLE;
				// CT0 <= 10;
				// CT1 <= 10;
				// CT2 <= 10;
				// CT3 <= 10;
				// CT4 <= 10;
				// CT5 <= 10;
				// CT6 <= 10;
				// CT7 <= 10;
				// CT8 <= 10;
				// CT9 <= 10;
				// CT10 <= 10;
				// CT11 <= 10;
				// CT12 <= 10;
				// CT13 <= 10;
				// CT14 <= 10;
				// CT15 <= 10;
				// CT16 <= 10;
				// CT17 <= 10;
				// CT18 <= 10;
				// CT19 <= 10;	
				shouldIkeepcounting = 0;
				
			end
			
			
			
			
			
			
			
			
			
			
			else if (CURR_STATE == VALIDATE_TRANSACTION)
			begin
				// remember total code must be 0-19, so first keypress must be either 0 or 1
				// Keypress of second must be 0-9, inclusive
				shouldIkeepcounting = 0;
				if( (key_press1 == 1 || key_press1 == 0) && ( key_press2 >= 0 && key_press2 <= 9) ) // valid input, but do we have inventory?
				begin		
					
					
					if(key_press1 == 0)
					begin
						if (key_press2 == 0 && CT0 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 1 && CT1 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 2 && CT2 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 3 && CT3 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 4 && CT4 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 5 && CT5 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 6 && CT6 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 7 && CT7 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 8 && CT8 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 9 && CT9 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_INVALID;
						end
					end
					
					else if (key_press1 == 1)
					begin
						if (key_press2 == 0 && CT10 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 1 && CT11 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 2 && CT12 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 3 && CT13 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 4 && CT14 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 5 && CT15 > 0)
						begin
						NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 6 && CT16 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 7 && CT17 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 8 && CT18 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else if (key_press2 == 9 && CT19 > 0)
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_VALID;
						end
						else
						begin
							NEXT_STATE = GENERAL_INPUT_WAS_INVALID;
						end

					
					end
					
				end
				else
				begin
					NEXT_STATE = GENERAL_INPUT_WAS_INVALID;
				end
					
			end	
			
			
			
			
			
			
			
			
			
	
	
		
	
			else if (CURR_STATE == GENERAL_INPUT_WAS_INVALID)
			begin
				NEXT_STATE = IDLE;
				shouldIkeepcounting = 0; // the other always function which takes care of outputs will handle the rest
			end
			else if (CURR_STATE == GENERAL_INPUT_WAS_VALID)
			begin
				if (VALID_TRAN)
				begin
					NEXT_STATE = VEND_STATE;
					shouldIkeepcounting = 0;
				end
				else
				begin
					NEXT_STATE = GENERAL_WAIT_FOR_TRANSACTION;
					shouldIkeepcounting = 1;
				end
			end
			else if (CURR_STATE == FAIL_STATE)
			begin
				NEXT_STATE = IDLE;
				shouldIkeepcounting = 0;
			end
			else if (CURR_STATE == OPEN_DOOR_STATE)
			begin
			    shouldIkeepcounting = 0;
				if(DOOR_OPEN)
				begin
					NEXT_STATE = OPEN_DOOR_STATE;
				end
				else
				begin
				
					NEXT_STATE = IDLE; //door opened and closed
				end
				
			end
			else if (CURR_STATE == GENERAL_WAIT_FOR_TRANSACTION)
			begin
				if (cycle5counter == 5)
				begin
					NEXT_STATE = FAIL_STATE;
					shouldIkeepcounting = 0;
				end
				else if (VALID_TRAN)
				begin
					NEXT_STATE = VEND_STATE;
					shouldIkeepcounting = 0;
				end
				else
				begin
					NEXT_STATE = GENERAL_WAIT_FOR_TRANSACTION;
					shouldIkeepcounting = 1;
				end
			end
			else if (CURR_STATE == GENERAL_WAIT_FOR_VEND)
			begin
			    if(cycle5counter == 5)
			    begin
			        NEXT_STATE = IDLE;
			        shouldIkeepcounting = 0;
			        
			    end
			    else if (DOOR_OPEN)
			    begin
			        NEXT_STATE = OPEN_DOOR_STATE;
			        shouldIkeepcounting = 0;
			     
			    end
			    else
			    begin
			        NEXT_STATE = GENERAL_WAIT_FOR_VEND;
			        shouldIkeepcounting = 1; // yes
			    end
			end
			else if (CURR_STATE == VEND_STATE)
			begin
			    if(DOOR_OPEN)
					begin
						NEXT_STATE = OPEN_DOOR_STATE;
						shouldIkeepcounting = 0;
					end
					else
					begin
						NEXT_STATE = GENERAL_WAIT_FOR_VEND;
						shouldIkeepcounting = 1; 
					end
			end
		end
		
		

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
endmodule