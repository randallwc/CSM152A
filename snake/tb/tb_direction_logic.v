`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:31:57 12/08/2021
// Design Name:   direction_logic
// Module Name:   C:/Users/wrand/Desktop/CSM152A/snake/snake_project/tb_direction_logic.v
// Project Name:  snake_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: direction_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_direction_logic;

	// Inputs
	reg in_button_up;
	reg in_button_down;
	reg in_button_left;
	reg in_button_right;
	reg in_button_reset;

	// Outputs
	wire [4:0] out_direction;

	// Instantiate the Unit Under Test (UUT)
	direction_logic uut (
		.in_button_up(in_button_up), 
		.in_button_down(in_button_down), 
		.in_button_left(in_button_left), 
		.in_button_right(in_button_right), 
		.in_button_reset(in_button_reset), 
		.out_direction(out_direction)
	);

	initial begin
		// Initialize Inputs
		in_button_up = 0;
		in_button_down = 0;
		in_button_left = 0;
		in_button_right = 0;
		in_button_reset = 1;

		// Wait 100 ns for global reset to finish
		#10;
        in_button_reset = 0;
        
		// Add stimulus here
        in_button_up = 1;
        #10
        in_button_up = 0;
        
        in_button_down = 1;
        #10
        in_button_down = 0;
        
        in_button_right = 1;
        #10
        in_button_right = 0;
        
        in_button_left = 1;
        #10
        in_button_left = 0;
        
        #20
        $finish;
	end
      
endmodule

