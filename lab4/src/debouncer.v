`timescale 1ns / 1ps

module debouncer(
    input wire in_button, // board's button
    input wire in_clock, // 100MHz board clock
    output wire out_button_debounced // clean output
    );

    wire [17:0] clk_dv_inc;
    reg [16:0] clk_dv;
    reg clk_en;
    reg clk_en_d;

    reg inst_vld;
    reg [2:0] step_d;
   
    initial begin
        clk_dv <= 0;
        clk_en <= 0;
        clk_en_d <= 0;
        
        inst_vld <= 0;
        step_d <= 0;
    end

   // ===========================================================================
   // 763Hz timing signal for clock enable
   // ===========================================================================

   assign clk_dv_inc = clk_dv + 1;
   
   always @ (posedge in_clock)
   begin
      clk_dv <= clk_dv_inc[16:0];
      clk_en <= clk_dv_inc[17];
      clk_en_d <= clk_en;
   end
   
   // ===========================================================================
   // Instruction Stepping Control
   // ===========================================================================

   always @ (posedge in_clock)
     if (clk_en)
       begin
          step_d[2:0]  <= {in_button, step_d[2:1]};
       end

   always @ (posedge in_clock)
     inst_vld <= ~step_d[0] & step_d[1] & clk_en_d;

   assign out_button_debounced = inst_vld;
endmodule
