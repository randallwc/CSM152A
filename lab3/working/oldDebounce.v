// module to debounce an input signal // TODO -- CLEAN
module debouncer(
    input wire in_button,
    input wire in_clock,
    output wire out_button_debounced
    );

    reg m_button_debounced = 0;
    reg [15:0] m_count;

    assign out_button_debounced = m_button_debounced;

    always @ (posedge in_clock) begin
        //$display(m_count," ",m_button_debounced," ", out_button_debounced);
        if (in_button) begin
            m_count <= m_count + 1'b1;
            // if button held for 2^16 in_clock cycles
            if (m_count == 16'hffff) begin
                m_count <= 0;
                m_button_debounced <= 1;
            end
        end else begin
            m_count <= 0;
            m_button_debounced <= 0;
        end
    end
endmodule