`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Testbench for vending machine
////////////////////////////////////////////////////////////////////////////////

module testbench_305109767;

	// Inputs
	reg CLK;
	reg RESET;
	reg RELOAD;
	reg CARD_IN;
	reg [3:0] ITEM_CODE;
	reg KEY_PRESS;
	reg VALID_TRAN;
	reg DOOR_OPEN;

	// Outputs
	wire VEND;
	wire INVALID_SEL;
	wire [2:0] COST;
	wire FAILED_TRAN;

	// Instantiate the Unit Under Test (UUT)
	vending_machine uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.RELOAD(RELOAD), 
		.CARD_IN(CARD_IN), 
		.ITEM_CODE(ITEM_CODE), 
		.KEY_PRESS(KEY_PRESS), 
		.VALID_TRAN(VALID_TRAN), 
		.DOOR_OPEN(DOOR_OPEN), 
		.VEND(VEND), 
		.INVALID_SEL(INVALID_SEL), 
		.COST(COST), 
		.FAILED_TRAN(FAILED_TRAN)
	);
	
	// Stimulate 100Mhz clock with 10ns periods
	always #5 CLK = ~CLK;
	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 0;
		RELOAD = 0;
		CARD_IN = 0;
		ITEM_CODE = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 0;
		
		/* Base Cases */
		
		// RELOAD
		#50 RELOAD = 1;
		#10 RELOAD = 0;
		
		// RESET
		#50 RESET = 1;
		#10 RESET = 0;
		
		// Test Full Transaction #Slot 11
		#50 RELOAD = 1;
		#10 RELOAD = 0;
		#10 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd1;
		#10 KEY_PRESS = 0;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd1;
		#10 KEY_PRESS = 0;
		#10 VALID_TRAN = 1;
		#10 VALID_TRAN = 0;
		#10;
		CARD_IN = 0;
		DOOR_OPEN = 1;
		#10 DOOR_OPEN = 0;
		
		// Test Full Transaction #Slot 00
		#50 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd0;
		#10 KEY_PRESS = 0;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd0;
		#10 KEY_PRESS = 0;
		#10 VALID_TRAN = 1;
		#10 VALID_TRAN = 0;
		#10;
		CARD_IN = 0;
		DOOR_OPEN = 1;
		#10 DOOR_OPEN = 0;
		
		// Test Invalid Selection - select slot 99 which does not exist
		#50 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd9;
		#10 KEY_PRESS = 0;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd9;
		#10 KEY_PRESS = 0;
		#10 CARD_IN = 0;
		
		// Test 5 Cycles Elapse Before Ones Digit
		#50 CARD_IN = 1;
		#60 CARD_IN = 0;
		
		// Test 5 Cycles Elapse Before Tens Digit
		#50 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd9;
		#10 KEY_PRESS = 0;
		#60 CARD_IN = 0;
		
		// Test Failed Transaction - 5 cycles pass before receiving VALID_TRAN
		#50 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd9;
		#10 KEY_PRESS = 0;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd0;
		#10 KEY_PRESS = 0;
		#60 CARD_IN = 0;
		
		// Test Failed Door - 5 cycles pass before receiving DOOR_OPEN
		#50 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd9;
		#10 KEY_PRESS = 0;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd0;
		#10 KEY_PRESS = 0;
		#10 VALID_TRAN = 1;
		#10 VALID_TRAN = 0;
		#10 CARD_IN = 0;

		/* Edge Cases */
		// Test RELOAD during transaction
		#50 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd9;
		#10 RELOAD = 1;
		#10;
		RELOAD = 0;
		KEY_PRESS = 0;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd0;
		#10 KEY_PRESS = 0;
		#10 VALID_TRAN = 1;
		#10 VALID_TRAN = 0;
		#10 CARD_IN = 0;
		
		// Test RESET during transaction
		#50 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd9;
		#10 RESET = 1;
		#10;
		RESET = 0;
		KEY_PRESS = 0;
		
		// Test Empty Slot - 10
		#50 CARD_IN = 1;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd0;
		#10 KEY_PRESS = 0;
		#10;
		KEY_PRESS = 1;
		ITEM_CODE = 4'd1;
		#10;
		KEY_PRESS = 0;
		#10 CARD_IN = 0;
		
		$stop;
	end
endmodule

