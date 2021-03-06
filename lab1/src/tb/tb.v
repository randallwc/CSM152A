`timescale 1ns / 1ps

module tb;

reg [7:0] sw;
reg       clk;
reg       btnS;
reg       btnR;

// Stuff for SEQ.CODE
integer seq_file;
integer seq_line;
reg[7:0] instruction_line;
reg[10:0] lines;

integer   i;

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire                 RsRx;                   // From model_uart0_ of model_uart.v
wire                 RsTx;                   // From uut_ of nexys3.v
wire [7:0]           led;                    // From uut_ of nexys3.v
// End of automatics

initial
begin
    clk = 0;
    btnR = 1;
    btnS = 0;
    seq_file = 0;
    #1000 btnR = 0;
    #1500000;
    seq_file = $fopen("C:/Users/wrand/Desktop/CSM152A/lab1/fib.code", "r");
    if (seq_file == 0) 
    begin
        $display("ERROR: FILE READ ERROR");
        $finish;
    end
    seq_line = $fscanf(seq_file, "%b\n", instruction_line); // read first line
    $display("DEBUG: Number of lines: binary=%b base10=%i", instruction_line, instruction_line);
    lines = instruction_line; // save value
    #1000;        
end
  
always @(posedge clk)
begin
    if (seq_file != 0)
    begin
        $display("DEBUG: lines left %i",lines);
        if (!$feof(seq_file) && lines > 0) // if not end of file and not past num lines
        begin
            seq_line = $fscanf(seq_file, "%b\n", instruction_line); // read line
            tskRunInst(instruction_line); // run instruction
            lines = lines - 1; // decrement num lines
        end
        else
        begin
            $fclose(seq_file);
            $finish;
        end
    end
end

always #5 clk = ~clk;

model_uart model_uart0_ (// Outputs
                        .TX                  (RsRx),
                        // Inputs
                        .RX                  (RsTx)
                        /*AUTOINST*/);

defparam model_uart0_.name = "UART0";
defparam model_uart0_.baud = 1000000;

nexys3 uut_ (/*AUTOINST*/
            // Outputs
            .RsTx                   (RsTx),
            .led                    (led[7:0]),
            // Inputs
            .RsRx                   (RsRx),
            .sw                     (sw[7:0]),
            .btnS                   (btnS),
            .btnR                   (btnR),
            .clk                    (clk));

task tskRunInst;
    input [7:0] inst;
    begin
        $display ("%d ... Running instruction %08b", $stime, inst);
        sw = inst;
        #1500000 btnS = 1;
        #3000000 btnS = 0;
    end
endtask //

task tskRunPUSH;
    input [1:0] ra;
    input [3:0] immd;
    reg [7:0]   inst;
    begin
        inst = {2'b00, ra[1:0], immd[3:0]};
        tskRunInst(inst);
    end
endtask //

task tskRunSEND;
    input [1:0] ra;
    reg [7:0]   inst;
    begin
        inst = {2'b11, ra[1:0], 4'h0};
        tskRunInst(inst);
    end
endtask //

task tskRunADD;
    input [1:0] ra;
    input [1:0] rb;
    input [1:0] rc;
    reg [7:0]   inst;
    begin
        inst = {2'b01, ra[1:0], rb[1:0], rc[1:0]};
        tskRunInst(inst);
    end
endtask //

task tskRunMULT;
    input [1:0] ra;
    input [1:0] rb;
    input [1:0] rc;
    reg [7:0]   inst;
    begin
         inst = {2'b10, ra[1:0], rb[1:0], rc[1:0]};
         tskRunInst(inst);
    end
endtask //

always @ (posedge clk)
    if (uut_.inst_vld)
        $display("%d ... instruction %08b executed", $stime, uut_.inst_wd);

always @ (led)
    $display("%d ... led output changed to %08b", $stime, led);

endmodule // tb
// Local Variables:
// verilog-library-flags:("-y ../src/")
// End:
