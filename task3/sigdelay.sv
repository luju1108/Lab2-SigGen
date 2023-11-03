module sigdelay #(
    parameter OFFSET_WIDTH = 8,
              DATA_WIDTH = 8,
              ADDRESS_WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic wr,
    input logic rd,
    input logic [OFFSET_WIDTH-1:0] offset,
    input logic [DATA_WIDTH-1:0] mic_signal,
    output logic [DATA_WIDTH-1:0] delayed_signal
);

logic [ADDRESS_WIDTH-1:0] wr_address;
logic [ADDRESS_WIDTH-1:0] rd_address;

counter addrCounter(
    .clk (clk),
    .rst (rst),
    .offset (offset),
    .wr_en (wr),
    .rd_en (rd),
    .countIncr (rd_address),
    .countOffset (wr_address)
);

ram2ports rWSig(
    .clk (clk),
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr (wr_address),
    .rd_addr (rd_address),
    .din (mic_signal),
    .dout (delayed_signal)
);

endmodule