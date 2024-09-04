module DataHazard(
    input ID_EX_RegWrite,
    input [4:0] ID_EX_WriteAddr,
    input [4:0] EX_MEM_WriteAddr,
    input ID_EX_MemRead,
    input ID_MemWrite,
    input EX_MEM_MemRead,
    input [4:0] rs,
    input [4:0] rt,
    input PCSrc,

    output data_hazard
);

    // case1: branch,jr,jalr在ID时用到前一条指令EX或者MEM的结果
    wire hazard1;
    assign hazard1 = (PCSrc == 3'b001 || PCSrc == 3'b011) && ((ID_EX_RegWrite || ID_EX_MemRead) && (ID_EX_WriteAddr != 5'b00000) && (ID_EX_WriteAddr == rs || ID_EX_WriteAddr == rt));

    // case2: branch,jr,jalr在ID时用到前二条指令MEM的结果
    wire hazard2;
    assign hazard2 = (PCSrc == 3'b001 || PCSrc == 3'b011) && EX_MEM_MemRead && ((EX_MEM_WriteAddr != 5'b00000) && (EX_MEM_WriteAddr == rs || EX_MEM_WriteAddr == rt));

    // case3: EX阶段用到前一条指令MEM的结果
    wire hazard3;
    assign hazard3 = (PCSrc == 3'b000) && ID_EX_MemRead && ~ID_MemWrite && ((ID_EX_WriteAddr != 5'b00000) && (ID_EX_WriteAddr == rs || ID_EX_WriteAddr == rt));

    assign data_hazard = hazard1 || hazard2 || hazard3;    

endmodule