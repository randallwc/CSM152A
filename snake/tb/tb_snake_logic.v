`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:54:49 11/19/2021
// Design Name:   snake_logic
// Module Name:   /home/ise/snake/tb_snake_logic.v
// Project Name:  snake
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: snake_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_snake_logic;

	// Inputs
	reg in_update_clock;
	reg in_reset;
	reg [4:0] in_direction;

	// Outputs
	wire [2549:0] out_snakeX;
	wire [2294:0] out_snakeY;

	// Instantiate the Unit Under Test (UUT)
	snake_logic uut (
		.in_update_clock(in_update_clock), 
		.in_reset(in_reset), 
		.in_direction(in_direction), 
		.out_snakeX(out_snakeX), 
		.out_snakeY(out_snakeY)
	);
    
    always #1 in_update_clock = ~in_update_clock;

	initial begin
		// Initialize Inputs
        in_update_clock = 0;
		in_reset = 1;
		in_direction = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

        in_reset = 0;
        
        #1000;
        
        in_direction = 5'b00010;
        
        #1000;
        
        in_direction = 5'b10000;
        
        #1000;
        
        in_direction = 5'b01000;
        
        #1000;
        
        in_direction = 5'b00100;
        
        #1000;
        $finish;

	end
      
endmodule

