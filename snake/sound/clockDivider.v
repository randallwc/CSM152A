// module to divide the main clock into 4 other clocks
module clockDivider(
    input wire in_clock,
    input wire in_reset,
    output wire out_one_hz_clock
    );

    reg m_one_hz_clock;

    reg [31:0] m_one_hz_count;

    assign out_one_hz_clock = m_one_hz_clock;

    localparam ONE_HZ = 50000000-1;
    
    initial begin
        m_one_hz_clock <= 0;
        m_one_hz_count <= 0;
    end

    // one hz
    always @ (posedge in_clock or posedge in_reset) begin
        if (in_reset) begin
            m_one_hz_clock <= 0;
            m_one_hz_count <= 0;
        end else if (m_one_hz_count == ONE_HZ) begin
            m_one_hz_clock <= ~out_one_hz_clock; 
            m_one_hz_count <= 0;
        end else begin
            m_one_hz_clock <= out_one_hz_clock; 
            m_one_hz_count <= m_one_hz_count + 1;
        end
    end
endmodule