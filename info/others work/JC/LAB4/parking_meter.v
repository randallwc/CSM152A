/*
 * Parking meter module for final project
 */
module parking_meter(
    input clk,
    input rst,
    input add1,
    input add2,
    input add3,
    input add4,
    input rst1,
    input rst2,
    output reg a1,
    output reg a2,
    output reg a3,
    output reg a4,
    output reg [6:0] led_seg,
	 output reg [3:0] val1,
	 output reg [3:0] val2,
	 output reg [3:0] val3,
	 output reg [3:0] val4
);
    /* CLK DIVIDER*/
    reg [1:0] seg_div = 0;
    reg [31:0] clk_div = 0;     
    reg [31:0] blink_div = 0;
    /* Blink state on/off */
    reg blink_state = 0;
    /* Display value, this will change with inputs */
    reg [13:0] to_display = 0;
    reg [3:0] values [0:3];
    reg [3:0] val;

    /* Clk divider data,  */
    always @(posedge clk) begin
        /* Change which anode lights up */
        seg_div = seg_div + 1; 
        clk_div = clk_div + 1;
        blink_div = blink_div + 1;
        if(rst) begin 
            to_display = 0;
            clk_div = 0;
            seg_div = 0;
            blink_div = 0;
        end else if(rst1) begin 
            to_display = 60;
            clk_div = 0;
            blink_div = 0;
        end else if(rst2) begin 
            to_display = 150;
            clk_div = 0;
            blink_div = 0;
        end else if(add1) begin 
            to_display = to_display + 60;
            clk_div = 0;
            blink_div = 0;
        end else if(add2) begin 
            to_display = to_display + 120;
            clk_div = 0;
            blink_div = 0;
        end else if (add3) begin 
            to_display = to_display + 180;
            clk_div = 0;
            blink_div = 0;
        end else if (add4) begin 
            to_display = to_display + 300;
            clk_div = 0;
            blink_div = 0;
        end
        
        if(clk_div >= 100 && to_display > 0) begin
            to_display = to_display - 1;
            clk_div = 0;
        end
        
        if(to_display == 0) begin
            if(blink_div >= 50) begin
                blink_state = ~blink_state;
                blink_div = 0;
            end
        end else if(to_display < 180) begin
            if(blink_div >= 100) begin
                blink_state = ~blink_state;
                blink_div = 0;
            end
        end else begin
            blink_state = 0;
        end
        /* Corner case */
        if(to_display > 9999) begin
            to_display = 9999;
        end
        
        val1 <= to_display % 10;
        val2 <= (to_display % 100) / 10;
        val3 <= (to_display % 1000) / 100;
        val4 <= (to_display % 10000) / 1000;
        if(seg_div[1:0] == 0) begin
            a1 <= blink_state;
            a2 <= 1;
            a3 <= 1;
            a4 <= 1;
            val <= to_display % 10;
        end else if(seg_div[1:0] == 1) begin 
            a1 <= 1;
            a2 <= blink_state;
            a3 <= 1;
            a4 <= 1;
            if(to_display < 10 && to_display != 0) begin
                val <= 10;
            end else begin
                val <= (to_display % 100) / 10;
            end
        end else if(seg_div[1:0] == 2) begin
            a1 <= 1;
            a2 <= 1;
            a3 <= blink_state;
            a4 <= 1;
            if(to_display < 100 && to_display != 0) begin
                val <= 10;
            end else begin
                val <= (to_display % 1000) / 100;
            end
        end else begin
            a1 <= 1;
            a2 <= 1;
            a3 <= 1;
            a4 <= blink_state;
            if(to_display < 1000 && to_display != 0) begin
                val <= 10;
            end else begin
                val <= (to_display % 10000) / 1000;
            end
        end
        case(val) 
            4'b0000: led_seg <= 7'b1000000; // 0
            4'b0001: led_seg <= 7'b1111001; // 1
            4'b0010: led_seg <= 7'b0100100; // 2
            4'b0011: led_seg <= 7'b0110000; // 3
            4'b0100: led_seg <= 7'b0011001; // 4
            4'b0101: led_seg <= 7'b0010010; // 5
            4'b0110: led_seg <= 7'b0000010; // 6
            4'b0111: led_seg <= 7'b1111000; // 7
            4'b1000: led_seg <= 7'b0000000; // 8
            4'b1001: led_seg <= 7'b0010000; // 9
            default: led_seg <= 7'b1111111; // <empty>
        endcase
    end

endmodule