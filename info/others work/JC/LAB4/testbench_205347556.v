`timescale 1ms/1ms




module mytestbench;
		reg RST;
		reg CLK;
		reg RST1;
		reg RST2;
		reg ADD1;
		reg ADD2;
		reg ADD3;
		reg ADD4;
		
		// outputs
		wire A1;
		wire A2;
		wire A3;
		wire A4;
		wire [6:0] LED_SEG;
		wire [3:0] VAL1;
		wire [3:0] VAL2;
		wire [3:0] VAL3;
		wire [3:0] VAL4;
		
	
		parking_meter park(
		
			.rst(RST),
			.clk(CLK),
			.rst1(RST1),
			.rst2(RST2),
			.add1(ADD1),
			.add2(ADD2),
			.add3(ADD3),
			.add4(ADD4),
			
			.a1(A1),
			.a2(A2),
			.a3(A3),
			.a4(A4),
			.led_seg(LED_SEG),
			.val1(VAL1),
			.val2(VAL2),
			.val3(VAL3),
			.val4(VAL4)
		
		);
		
		initial begin
			
			RST = 0;
			CLK = 0;
			RST1 = 0;
			RST2 = 0;
			ADD1 = 0;
			ADD2 = 0;
			ADD3 = 0;
			ADD4 = 0;
			
			
			
			#200
			RST = 1;
			#10
			RST = 0;
			#1000
			ADD1 = 1;
			#10
			ADD1 = 0;
			#65000	// once we get past this, the timer will expire, and should be blinking at 0
			RST2 = 1; // will reset to 150 seconds
			#10
			RST2 = 0;
			#1000
			ADD2 = 1; //add 120 seconds
			#10
			ADD2 = 0;
			#1000
			RST1 = 1; // reset to 16 seconds immediately
			#10
			RST1 = 0;	
			#10000 // should count down to 6 seconds
			ADD3 = 1; // should add 180, total at 186 seconds
			#10
			ADD3 = 0;
			#10000 // after this, it should be at 176
			ADD4 = 1; // add another 300 seconds
			#10
			ADD4 = 0;
			#60000 // after this, it should be at 416 seconds
			ADD4 = 1; // add to 716
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 1016
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 1316
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 1616
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 1916
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 2216
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 2516
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 2816
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 3116
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 3416
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 3716
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 4016
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 4316
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 4616
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 4916
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 5216
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 5516
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 5816
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 6116
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 6416
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 6716
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 7016
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 7316
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 7616
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 7916
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 8216
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 8516
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 8816
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 9116
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 9416
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 9716
			#10
			ADD4 = 0;
			#10
			ADD4 = 1; // add to 9999, this is where we top out, if there was no limit, this would go to 1016
			#10
			ADD4 = 0;
			#30000
			RST1 = 1;
			#10
			RST1 = 0;
			#6000
			RST = 1;
			#10
			RST = 0;
			
	
		end
		
		always begin
			#5 CLK = ~CLK;
		end
endmodule