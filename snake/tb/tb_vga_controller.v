`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:03:00 12/08/2021
// Design Name:   vga_controller
// Module Name:   C:/Users/wrand/Desktop/CSM152A/snake/tb/tb_vga_controller.v
// Project Name:  snake_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_vga_controller;

	// Inputs
	reg in_VGA_clock;
	reg in_reset;

	// Outputs
	wire [9:0] out_pixelX;
	wire [8:0] out_pixelY;
	wire out_hSync;
	wire out_vSync;

	// Instantiate the Unit Under Test (UUT)
	vga_controller uut (
		.in_VGA_clock(in_VGA_clock), 
		.in_reset(in_reset), 
		.out_pixelX(out_pixelX), 
		.out_pixelY(out_pixelY), 
		.out_hSync(out_hSync), 
		.out_vSync(out_vSync)
	);
    
    always #1 in_VGA_clock = ~ in_VGA_clock;

	initial begin
		// Initialize Inputs
		in_reset = 1;
        in_VGA_clock = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
        in_reset = 0;
        
        #10000
        
		// Add stimulus here
        $finish;
	end
      
endmodule

