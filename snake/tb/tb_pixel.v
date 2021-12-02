`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:36:32 11/30/2021
// Design Name:   pixel_logic
// Module Name:   /home/ise/snake/tb_pixel.v
// Project Name:  snake
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pixel_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_pixel;

	// Inputs
	reg in_reset;
	reg in_snake;
	reg in_apple;
	reg in_border;
	reg in_lethal;
	reg in_oobounds;

	// Outputs
	wire [2:0] out_VGA_R;
	wire [2:0] out_VGA_G;
	wire [1:0] out_VGA_B;

	// Instantiate the Unit Under Test (UUT)
	pixel_logic uut (
		.in_reset(in_reset), 
		.in_snake(in_snake), 
		.in_apple(in_apple), 
		.in_border(in_border), 
		.in_lethal(in_lethal), 
		.in_oobounds(in_oobounds), 
		.out_VGA_R(out_VGA_R), 
		.out_VGA_G(out_VGA_G), 
		.out_VGA_B(out_VGA_B)
	);

	initial begin
		// Initialize Inputs
		in_reset = 1;
		in_snake = 0;
		in_apple = 0;
		in_border = 0;
		in_lethal = 0;
		in_oobounds = 0;

		// Wait 100 ns for global reset to finish
		#100;
        in_reset = 0;
        
		// Add stimulus here
        #100;
        in_snake = 1;
		in_apple = 0;
		in_border = 0;
		in_lethal = 0;
		in_oobounds = 0;
        
        #100;
        in_snake = 0;
		in_apple = 1;
		in_border = 0;
		in_lethal = 0;
		in_oobounds = 0;
        
        #100;
        in_snake = 0;
		in_apple = 0;
		in_border = 1;
		in_lethal = 0;
		in_oobounds = 0;
        
        #100;
        in_snake = 0;
		in_apple = 0;
		in_border = 0;
		in_lethal = 0;
		in_oobounds = 1;
        
        #100;
        in_lethal = 1;
        
        #100
        in_snake = 1;
		in_apple = 0;
		in_border = 0;
		in_lethal = 0;
		in_oobounds = 0;
        
        #100;
        in_snake = 0;
		in_apple = 0;
		in_border = 0;
		in_lethal = 0;
		in_oobounds = 1;

	end
      
endmodule

