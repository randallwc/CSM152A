module one_hertz_led (clk,led);

// Input and output declaration
reg clk;
output reg led;

reg[28:0] counter;

initial begin
	led = 1;
	counter = 0;

// Output multiplexer
always @(posedge clk)
	if (counter == 50000000)
		led = ~led;
		counter = 0;
	else
		counter = counter + 1;
		

endmodule
