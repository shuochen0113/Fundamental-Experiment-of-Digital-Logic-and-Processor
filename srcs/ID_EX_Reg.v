module ID_EX_Reg(
    input clk,
    input rst,
    input flush,
    input input_RegWrite,
    input input_MemRead,
    input input_MemWrite,
    input [1:0] input_MemtoReg,
    input input_ALUSrc1,
    input input_ALUSrc2,
    input [3:0] input_ALUOp,
    input [4:0] input_WriteAddr,
    input [31:0] input_rs_data,
    input [31:0] input_rt_data,
    input [31:0] input_imm_ext,
    input [31:0] input_pc_plus_4,
    input [1:0] input_Forward_EX_A,
    input [1:0] input_Forward_EX_B,
    input input_Forward_MEM,
    input [5:0] input_Funct,
    input [4:0] input_Shamt
);

    reg RegWrite;
    reg MemRead;
    reg MemWrite;
    reg [1:0] MemtoReg;
    reg ALUSrc1;
    reg ALUSrc2;
    reg [3:0] ALUOp;
    reg [4:0] WriteAddr;
    reg [31:0] rs_data;
    reg [31:0] rt_data;
    reg [31:0] imm_ext;
    reg [31:0] pc_plus_4;
    reg [1:0] Forward_EX_A;
    reg [1:0] Forward_EX_B;
    reg Forward_MEM;
    reg [5:0] Funct;
    reg [4:0] Shamt;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            ALUSrc1 <= 0;
            ALUSrc2 <= 0;
            ALUOp <= 0;
            WriteAddr <= 0;
            rs_data <= 0;
            rt_data <= 0;
            imm_ext <= 0;
            pc_plus_4 <= 0;
            Forward_EX_A <= 0;
            Forward_EX_B <= 0;
            Forward_MEM <= 0;
            Funct <= 0;
            Shamt <= 0;
        end            
        else if(flush) begin
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= input_MemtoReg;
            ALUSrc1 <= input_ALUSrc1;
            ALUSrc2 <= input_ALUSrc2;
            ALUOp <= input_ALUOp;
            WriteAddr <= input_WriteAddr;
            rs_data <= input_rs_data;
            rt_data <= input_rt_data;
            imm_ext <= input_imm_ext;
            pc_plus_4 <= input_pc_plus_4;
            Forward_EX_A <= input_Forward_EX_A;
            Forward_EX_B <= input_Forward_EX_B;
            Forward_MEM <= input_Forward_MEM;
            Funct <= input_Funct;
            Shamt <= input_Shamt;
        end
        else begin
            RegWrite <= input_RegWrite;
            MemRead <= input_MemRead;
            MemWrite <= input_MemWrite;
            MemtoReg <= input_MemtoReg;
            ALUSrc1 <= input_ALUSrc1;
            ALUSrc2 <= input_ALUSrc2;
            ALUOp <= input_ALUOp;
            WriteAddr <= input_WriteAddr;
            rs_data <= input_rs_data;
            rt_data <= input_rt_data;
            imm_ext <= input_imm_ext;
            pc_plus_4 <= input_pc_plus_4;
            Forward_EX_A <= input_Forward_EX_A;
            Forward_EX_B <= input_Forward_EX_B;
            Forward_MEM <= input_Forward_MEM;
            Funct <= input_Funct;
            Shamt <= input_Shamt;
        end
    end

endmodule