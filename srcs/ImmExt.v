module ImmExt(
    input ExtOp,
    input LuOp,
    input [15:0] immdiate,
    
    output [31:0] immdiate_ext
);

    wire [31:0] ext;
    assign ext = ExtOp? {{16{immdiate[15]}}, immdiate}: {16'h0000, immdiate};
    assign immdiate_ext = LuOp? {immdiate, 16'h0000}: ext;

endmodule