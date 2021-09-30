module four_bit_counter(clk, rst, a0, a1, a2, a3);
input clk, rst;
output reg a0, a1, a2, a3;
always @ (posedge clk) begin
 if (rst) begin
   a0 <= 1'b0;
   a1 <= 1'b0;
   a2 <= 1'b0;
   a3 <= 1'b0;
 end else begin
   a0 <= ~a0;
   a1 <= a0 ^ a1;
   a2 <= (a0 & a1) ^ a2;
   a3 <= ((a0 & a1) & a2) ^ a3;
 end
end
endmodule
