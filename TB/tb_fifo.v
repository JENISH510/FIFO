//tb for fifo

module tb_fifo ;

parameter ADDR_WIDTH = 4,
          DATA_WIDTH = 8,
          DEPTH = 1 << ADDR_WIDTH;

reg clk;
reg rst;
reg read_en;
reg write_en;
reg [DATA_WIDTH-1:0]data_in;
wire [DATA_WIDTH-1:0]data_out;
wire empty;
wire full;

//instansiation

fifo DUT (.clk(clk),
          .rst(rst),
          .read_en(read_en),
          .write_en(write_en),
          .data_in(data_in),
          .data_out(data_out),
          .empty(empty),
          .full(full)
          );

//generate clk

initial begin
    clk = 0;
    forever
    #5 clk = ~clk;
end

//scenarios

initial begin
    rst = 0;
    write_en = 0;
    read_en = 0;
    data_in = 0;
#10

    rst = 1;
    #10
    write_en = 1;
    data_in = $random;#10
    data_in = $random;#10
    data_in = $random;#10
    data_in = $random;#10
    data_in = $random;#10
    write_en = 0;
    #10;

    read_en = 1;#10
    read_en = 0;#10

    write_en = 1;
   
    repeat(16)begin
        data_in = $random; #10;
    end
    write_en = 0;
    #10

    read_en = 1;
    repeat(16)begin
    #10;
    end
    read_en = 0;

        
    rst = 0; #10
    rst = 1; #10;

    #200;
    $finish;
end
endmodule
