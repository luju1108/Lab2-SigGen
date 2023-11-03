module sinegen #(
    parameter INCR_WIDTH = 8,
    parameter DATA_WIDTH = 8,
    parameter ADDRESS_WIDTH = 8
)(
    input logic [INCR_WIDTH-1:0] incr,
    input logic rst,
    input logic en,
    input logic clk,
    output logic [DATA_WIDTH-1:0] dout
);

    logic [ADDRESS_WIDTH-1:0] address; // interconnect wire

counter addrCounter(
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .count (address)
);

rom sineRom(
    .clk (clk),
    .addr (address),
    .dout (dout)
);

endmodule
