`timescale 1ns / 1ps

module debouncer_tb;

    // Inputs
    reg in_button;
    reg in_clock;

    // Outputs
    wire out_button_debounced;

    // Instantiate the Unit Under Test (UUT)
    debouncer uut (
        .in_button(in_button), 
        .in_clock(in_clock), 
        .out_button_debounced(out_button_debounced)
    );

    always #1 in_clock = ~in_clock;

    initial begin
        // Initialize Inputs
        in_button = 0;
        in_clock = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        in_button = 1;
        #5
        in_button = 0;
        #5
        in_button = 1;
        #280000
        in_button = 0;
        #280000
        $finish;
    end

endmodule

