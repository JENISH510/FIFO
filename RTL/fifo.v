//rtl for sync. fifo

module fifo (clk,rst,data_in,write_en,read_en,full,empty,data_out);

//take parameters

parameter ADDR_WIDTH = 4,
          DATA_WIDTH = 8,
          DEPTH = 1 << ADDR_WIDTH;

//ports directions

input clk,rst;
input [DATA_WIDTH-1:0]data_in;
input read_en;
input write_en;
output reg [DATA_WIDTH-1:0] data_out;
output reg empty,full;

//take internal wires

reg [DATA_WIDTH-1:0]mem [0:DEPTH-1];
reg [ADDR_WIDTH-1:0]wr,rd;

//write conditions

always@(posedge clk or negedge rst)
begin
    if (!rst) begin
        data_out <= 0;
        wr <= 0;
        rd <= 0;
        full <= 0;
        empty <= 1;
    end

    //write / read logic

    else begin
        if (write_en && !full)begin
            mem[wr] <= data_in;
            wr <= wr + 1;
        end
        if (read_en && !empty)begin
            data_out <= mem[rd];
            rd <= rd + 1;
        end

    //logic for full and empty    

        full <= ((wr + 1) == rd);
        empty <= (wr == rd);
    end
end
endmodule

