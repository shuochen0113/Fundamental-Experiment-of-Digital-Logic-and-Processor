module EX_MEM_Reg(
    input clk,
    input rst,
    input input_MemRead,
    input input_MemWrite,
    input [31:0] input_rt_data,
    input [4:0] input_WriteAddr,
    input [1:0] input_MemtoReg,
    input input_RegWrite,
    input [31:0] input_ALUOut,
    input [31:0] input_pc_plus_4,
    input input_Forward_MEM
);

    reg MemRead;
    reg MemWrite;
    reg [31:0] rt_data;
    reg [4:0] WriteAddr;
    reg [1:0] MemtoReg;
    reg RegWrite;
    reg [31:0] ALUOut;
    reg [31:0] pc_plus_4;
    reg Forward_MEM;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            MemRead <= 0;
            MemWrite <= 0;
            rt_data <= 0;
            WriteAddr <= 0;
            MemtoReg <= 0;
            RegWrite <= 0;
            ALUOut <= 0;
            pc_plus_4 <= 0;
            Forward_MEM <= 0;
        end
        else begin
            MemRead <= input_MemRead;
            MemWrite <= input_MemWrite;
            rt_data <= input_rt_data;
            WriteAddr <= input_WriteAddr;
            MemtoReg <= input_MemtoReg;
            RegWrite <= input_RegWrite;
            ALUOut <= input_ALUOut;
            pc_plus_4 <= input_pc_plus_4;
            Forward_MEM <= input_Forward_MEM;
        end
    end
            

endmodule