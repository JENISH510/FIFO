// =====================================================
// FIFO RTL - SystemVerilog Version
// Synchronous FIFO with parameterized depth and width
// =====================================================

module fifo #(
    parameter int ADDR_WIDTH = 4,
    parameter int DATA_WIDTH = 8
) (
    input  logic                    clk,
    input  logic                    rst,
    input  logic [DATA_WIDTH-1:0]   data_in,
    input  logic                    write_en,
    input  logic                    read_en,
    output logic [DATA_WIDTH-1:0]   data_out,
    output logic                    full,
    output logic                    empty
);

    localparam int DEPTH = 1 << ADDR_WIDTH;

    // Internal signals
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    logic [ADDR_WIDTH-1:0] wr_ptr;
    logic [ADDR_WIDTH-1:0] rd_ptr;

    // Write and read logic
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            data_out <= '0;
            wr_ptr   <= '0;
            rd_ptr   <= '0;
            full     <= 1'b0;
            empty    <= 1'b1;
        end else begin
            // Write operation
            if (write_en && !full) begin
                mem[wr_ptr] <= data_in;
                wr_ptr      <= wr_ptr + 1;
            end

            // Read operation
            if (read_en && !empty) begin
                data_out <= mem[rd_ptr];
                rd_ptr   <= rd_ptr + 1;
            end

            // Flag generation
            full  <= ((wr_ptr + 1) == rd_ptr);
            empty <= (wr_ptr == rd_ptr);
        end
    end

endmodule
