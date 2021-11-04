module debouncer(
    input wire in_button, // board's button
    input wire in_clock, // 100MHz board clock
    output wire out_button_debounced // clean output
    );
// module debounce(
//     //declare inputs
//     in_clock, in_button,
//     //declare output
//     out_button_debounced
//     );
//
//     //formally declare inputs
//     input in_clock;
//     input in_button;
//
//     //formally declare output
//     output out_button_debounced;

    reg dbTemp;
    reg [15:0] counter;

    reg syncClk0;
    reg syncClk1;

    always @(posedge in_clock) begin
        syncClk0 <= in_button;
    end

    always @(posedge in_clock) begin
        syncClk1 <= syncClk0;
    end

    always @(posedge in_clock) begin
        if(dbTemp == syncClk1) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 1'b1;

            if(counter == 16'hffff) begin
                dbTemp <= ~out_button_debounced;
            end
        end
    end

    assign out_button_debounced = dbTemp;
endmodule
