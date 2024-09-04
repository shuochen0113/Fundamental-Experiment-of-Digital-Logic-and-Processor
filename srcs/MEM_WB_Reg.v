module MEM_WB_Reg (
    input clk,
    input rst,
    input input_RegWrite,
    input [4:0] input_WriteAddr,
    input [31:0] input_MEMOut
);

    reg RegWrite;
    reg [4:0] WriteAddr;
    reg [31:0] MEMOut;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RegWrite <= 0;
            WriteAddr <= 0;
            MEMOut <= 0;
        end
        else begin
            RegWrite <= input_RegWrite;
            WriteAddr <= input_WriteAddr;
            MEMOut <= input_MEMOut;
        end
    end

endmodule