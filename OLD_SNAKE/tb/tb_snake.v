`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:49:07 11/30/2021
// Design Name:   snake
// Module Name:   /home/ise/snake/tb_snake.v
// Project Name:  snake
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: snake
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_snake;

	// Inputs
	reg in_clock;
	reg in_button_up;
	reg in_button_down;
	reg in_button_left;
	reg in_button_right;
	reg in_button_reset;

	// Outputs
	wire [2:0] out_VGA_R;
	wire [2:0] out_VGA_G;
	wire [1:0] out_VGA_B;
	wire out_hSync;
	wire out_vSync;

	// Instantiate the Unit Under Test (UUT)
	snake uut (
		.in_clock(in_clock), 
		.in_button_up(in_button_up), 
		.in_button_down(in_button_down), 
		.in_button_left(in_button_left), 
		.in_button_right(in_button_right), 
		.in_button_reset(in_button_reset), 
		.out_VGA_R(out_VGA_R), 
		.out_VGA_G(out_VGA_G), 
		.out_VGA_B(out_VGA_B), 
		.out_hSync(out_hSync), 
		.out_vSync(out_vSync)
	);
    
    always #5 in_clock = ~in_clock;

	initial begin
		// Initialize Inputs
		in_clock = 0;
		in_button_up = 0;
		in_button_down = 0;
		in_button_left = 0;
		in_button_right = 0;
		in_button_reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        in_button_reset = 0;
        
		// Add stimulus here

	end
      
endmodule

