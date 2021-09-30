`timescale 1ms / 1ms

////////////////////////////////////////////////////////////////////////////////
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_305109767;

	// Inputs
	reg add1;
	reg add2;
	reg add3;
	reg add4;
	reg rst1;
	reg rst2;
	reg clk;
	reg rst;
	// Outputs
	wire [3:0] val1;
	wire [3:0] val2;
	wire [3:0] val3;
	wire [3:0] val4;
	wire [6:0] cathodes;
	wire [3:0] anodes;
	
	// Instantiate the Unit Under Test (UUT)
	parking_meter uut (
		.add1(add1), 
		.add2(add2), 
		.add3(add3), 
		.add4(add4), 
		.rst1(rst1), 
		.rst2(rst2), 
		.clk(clk), 
		.rst(rst), 
		.val1(val1), 
		.val2(val2), 
		.val3(val3), 
		.val4(val4), 
		.led_cathodes(cathodes), 
		.led_anodes(anodes)
	);
	
	// Stimulated 100Hz Clock with 10 ms period
   always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		add1 = 0;
		add2 = 0;
		add3 = 0;
		add4 = 0;
		rst1 = 0;
		rst2 = 0;
		clk = 0;
		rst = 1;
		
		/* Base Cases */
		
		// Reset to initial state test
		#15 rst = 0;
		
		// Reset to 16s test
		#3000 rst1 = 1;
		#15 rst1 = 0;
		
		// Reset to 150s test
		#3000 rst2 = 1;
		#15 rst2 = 0;
		
		// Add 60s test
		#3000 rst = 1;
		#15 rst = 0;
		#1000 add1 = 1;
		#15 add1 = 0;
		
		// Add 120s test
		#3000 rst = 1;
		#15 rst = 0;
		#1000 add2 = 1;
		#15 add2 = 0;
		
		// Add 180s test
		#3000 rst = 1;
		#15 rst = 0;
		#1000 add3 = 1;
		#15 add3 = 0;
		
		// Add 300s test
		#3000 rst = 1;
		#15 rst = 0;
		#1000 add4 = 1;
		#15 add4 = 0;
		
		/* Edge Case */
		// Consecutive add test
		// One hertz clock and half hertz clock should only resync on first add 
		#3000 rst = 1;
		#15 rst = 0;
		#15 add1 = 1;
		#15 add1 = 0;
		#15 add2 = 1;
		#15 add2 = 0;
		#15 add3 = 1;
		#15 add3 = 0;
		#15 add4 = 1;
		#15 add4 = 0;
		
		// Reset to 16 when counter is not empty 
		#3000 rst = 1;
		#15 rst = 0;
		#1000 add1 = 1;
		#15 add1 = 0;
		#1000 rst1 = 1;
		#15 rst1 = 0;
		
		// Reset to 150 when counter is not empty 
		#3000 rst = 1;
		#15 rst = 0;
		#1000 add1 = 1;
		#15 add1 = 0;
		#1000 rst2 = 1;
		#15 rst2 = 0;
		
		// Examine crossing 180 second behavior. 
		#3000 rst1 = 1;
		#15 rst1 = 0;
		#1000 add3 = 1;
		#15 add3 = 0;

		// Examine behavior when timer reaches 0.
		#20000 rst1 = 1;
		#10 rst1 = 0;	

		// Examine behavior when adding exceeds max timer value (9999)
		#20000 rst = 1;
		#10 rst = 0;
		
		// Add 300 exceeds
		#10 add4 = 1;
		#650 add4 = 0;
		
		// Add 300 exceeds
		#1000 add4 = 1;
		#10 add4 = 0;
		
		// Add 180 exceeds
		#1000 add3 = 1;
		#10 add3 = 0;
		
		// Add 120 exceeds
		#1000 add2 = 1;
		#10 add2 = 0;
		
		// Add 60 exceeds
		#1000 add1 = 1;
		#10 add1 = 0;
		#10000;
      $stop;
	end
endmodule

