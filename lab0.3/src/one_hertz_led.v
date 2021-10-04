module one_hertz_led(clk,led);
input clk;
output reg led;
reg[28:0] counter;
initial
begin
	led = 1;
	counter = 1;
end
always @ (posedge clk)
begin
	if (counter == 50000000)
	begin
		led = ~led;
		counter = 1;
	end
	else
	begin
		counter = counter + 1;
	end
end	
endmodule