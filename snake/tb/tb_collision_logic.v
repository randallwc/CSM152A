`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:38:02 12/08/2021
// Design Name:   collision_logic
// Module Name:   C:/Users/wrand/Desktop/CSM152A/snake/tb/tb_collision_logic.v
// Project Name:  snake_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: collision_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_collision_logic;

	// Inputs
	reg [9:0] in_pixelX;
	reg [8:0] in_pixelY;
	reg [159:0] in_snakeX;
	reg [143:0] in_snakeY;
	reg [7:0] in_snake_size;
	reg [9:0] in_appleX;
	reg [8:0] in_appleY;

	// Outputs
	wire out_snake;
	wire out_apple;
	wire out_border;
	wire out_lethal;
	wire out_nonlethal;
	wire out_oobounds;

	// Instantiate the Unit Under Test (UUT)
	collision_logic uut (
		.in_pixelX(in_pixelX), 
		.in_pixelY(in_pixelY), 
		.in_snakeX(in_snakeX), 
		.in_snakeY(in_snakeY), 
		.in_snake_size(in_snake_size), 
		.in_appleX(in_appleX), 
		.in_appleY(in_appleY), 
		.out_snake(out_snake), 
		.out_apple(out_apple), 
		.out_border(out_border), 
		.out_lethal(out_lethal), 
		.out_nonlethal(out_nonlethal), 
		.out_oobounds(out_oobounds)
	);

	initial begin
		// Initialize Inputs
		in_pixelX = 0;
		in_pixelY = 0;
		in_snakeX = 200;
		in_snakeY = 200;
		in_snake_size = 1;
		in_appleX = 100;
		in_appleY = 100;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		in_pixelX = 100;
		in_pixelY = 100;
        #10;

		in_pixelX = 200;
		in_pixelY = 200;
        #10;
        
        in_pixelX = 0;
		in_pixelY = 0;
        #10;
        
        in_pixelX = 150;
		in_pixelY = 150;
        #10;

        $finish;
	end
      
endmodule

