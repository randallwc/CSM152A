
`timescale 1ns/1ns






module mytestbench;

	reg CLK;
	reg RESET;
	reg RELOAD;
	reg CARD_IN;
	reg [3:0] ITEM_CODE;
	reg KEY_PRESS;
	reg VALID_TRAN;
	reg DOOR_OPEN;
	
	
	wire VEND;
	wire INVALID_SEL;
	wire [2:0] COST;
	wire FAILED_TRAN;
	
	
	
	
	vending_machine inst(
	
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
	
	
	
	
	
	initial begin
		
		CLK = 0;
		RESET = 0;
		RELOAD = 0;
		CARD_IN = 0;
		KEY_PRESS = 0;
		VALID_TRAN = 0;
		DOOR_OPEN = 0;
		ITEM_CODE = 0;
		
		
		//RESET bc thats how we initialize parameters
		#20
		RESET = 1;
		#20
		RESET = 0;
		
		
		
		// The first test we are gonna do is the successful transaction # 1
		//Then we are going to follow with the two special cases
		#20
		RELOAD = 1;
		#20
		RELOAD = 0;
		#20
		CARD_IN = 1;
		#20 
		ITEM_CODE = 1; // we are entering keypresses
		KEY_PRESS = 1;
		#20
		KEY_PRESS = 0;
		#20
		ITEM_CODE = 3;
		KEY_PRESS = 1;
		#20
		KEY_PRESS = 0;
		#20
		CARD_IN = 0;
		#20
		VALID_TRAN = 1;
		#20
		VALID_TRAN = 0;
		#20
		DOOR_OPEN = 1;
		#20
		DOOR_OPEN = 0;
		
		
		
		//Now we will implement getting through the entire transaction but invalid payment # 2
	
		#500
		CARD_IN = 1;
		#20 
		ITEM_CODE = 1; // we are entering keypresses
		KEY_PRESS = 1;
		#20
		KEY_PRESS = 0;
		#20
		ITEM_CODE = 3;
		KEY_PRESS = 1;
		#20
		KEY_PRESS = 0;
		#20
		CARD_IN = 0;
		#20
		VALID_TRAN = 0;
		#60
		DOOR_OPEN = 1;
		#20
		DOOR_OPEN = 0;
		
		
		
		//Now we will implement inputting the card but no key press for 5 cycles # 3
		#500
		RESET = 1;
		#20
		RESET = 0;
		#20
		CARD_IN = 1;
		#100
		//sHOULD HAVE FAILED BY THIS POINT
		
		RELOAD = 1;
		#20
		RELOAD = 0;
		#20
		RESET = 1;
		#20
		RESET = 0;
		
		
		
		
		
		///// OUT OF RANGE input EXAMPLE #4
		#500
		CARD_IN = 1;
		#20
		KEY_PRESS = 1;
		ITEM_CODE = 3;
		#20
		//SHOULD FAIL HERE
		
		
		
		
		// only one key press input example #5
		#500
		CARD_IN = 1;
		#20 
		KEY_PRESS = 1;
		ITEM_CODE = 0;
		#20
		KEY_PRESS = 0;

		
		//should fail here
		
		
		
		
		
		
		
		
		
		
	end
	
	// So we dont ahve to manually flip flop CLK
	always begin
		#10 CLK = ~CLK;
	end
	
	
	


endmodule