`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:10:51 12/08/2021
// Design Name:   apple_logic
// Module Name:   C:/Users/wrand/Desktop/CSM152A/snake/tb/tb_apple_logic.v
// Project Name:  snake_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: apple_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_apple_logic;

	// Inputs
	reg in_update_clock;
	reg in_reset;
	reg in_nonlethal;

	// Outputs
	wire [7:0] out_snake_size;
	wire [9:0] out_appleX;
	wire [8:0] out_appleY;

	// Instantiate the Unit Under Test (UUT)
	apple_logic uut (
		.in_update_clock(in_update_clock), 
		.in_reset(in_reset), 
		.in_nonlethal(in_nonlethal), 
		.out_snake_size(out_snake_size), 
		.out_appleX(out_appleX), 
		.out_appleY(out_appleY)
	);
    
    always #1 in_update_clock = ~ in_update_clock;

	initial begin
		// Initialize Inputs
		in_update_clock = 0;
		in_reset = 1;
		in_nonlethal = 0;

		// Wait 100 ns for global reset to finish
		#100;
        in_reset=0;
        
        #100;
        in_nonlethal=1;
        
		// Add stimulus here
        #10;
        in_nonlethal=0;
        #1000;
        $finish;

	end
      
endmodule

