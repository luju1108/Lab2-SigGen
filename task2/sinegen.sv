module sinegen #(
    parameter INCR_WIDTH = 8,
    parameter OFFSET_WIDTH = 8,
    parameter DATA_WIDTH = 8,
    parameter ADDRESS_WIDTH = 8
)(
    input logic [INCR_WIDTH-1:0] incr,
    input logic [OFFSET_WIDTH-1:0] offset,
    input logic rst,
    input logic en,
    input logic clk,
    output logic [DATA_WIDTH-1:0] dout1,
    output logic [DATA_WIDTH-1:0] doutOffset
);

    logic [ADDRESS_WIDTH-1:0] address1; // interconnect wire
    logic [ADDRESS_WIDTH-1:0] addressOffset;

counter addrCounter(
    .clk (clk),
    .rst (rst),
    .en (en),
    .offset (offset),
    .incr (incr),
    .countIncr (address1),
    .countOffset (addressOffset)
);

rom sineRom(
    .clk (clk),
    .addr1 (address1),
    .addr2 (addressOffset),
    .dout1 (dout1),
    .dout2 (doutOffset)
);

endmodule
