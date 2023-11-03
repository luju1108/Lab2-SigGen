module counter #(
    parameter INCR_WIDTH = 8,
    parameter OFFSET_WIDTH = 8,
    parameter ADDRESS_WIDTH = 8
)(
// interface signals
    input  logic [INCR_WIDTH-1:0]        incr,
    input  logic [OFFSET_WIDTH-1:0]      offset,
    input  logic                         clk,  // clock
    input  logic                         rst,  // reset
    input  logic                         en,   // counter enable
    output logic [ADDRESS_WIDTH-1:0]     countIncr, // cout output
    output logic [ADDRESS_WIDTH-1:0]     countOffset // cout output
);

//synchronous reset
always_ff @ (posedge clk)

    if (en) begin
        if (rst) begin
            countIncr <= {ADDRESS_WIDTH{1'b0}};
            countOffset <= {ADDRESS_WIDTH{1'b0}} + offset;
        end
        else begin
            countIncr <= countIncr + incr;
            countOffset <= countIncr + incr + offset;
        end
    end

endmodule
