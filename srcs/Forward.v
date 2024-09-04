module Forward(
    input rst,
    input ID_EX_RegWrite,
    input [4:0] ID_EX_WriteAddr,
    input EX_MEM_RegWrite,
    input [4:0] EX_MEM_WriteAddr,
    input MEM_WB_RegWrite,
    input [4:0] MEM_WB_WriteAddr,
    input [4:0] rs,
    input [4:0] rt,
    
    output reg [1:0] Forward_ID_A,
    output reg [1:0] Forward_ID_B,
    output reg [1:0] Forward_EX_A,
    output reg [1:0] Forward_EX_B,
    output reg Forward_MEM
);

    always @(*) begin
    if (rst) begin
        Forward_ID_A <= 2'b00;
        Forward_ID_B <= 2'b00;
        Forward_EX_A <= 2'b00;
        Forward_EX_B <= 2'b00;
        Forward_MEM <= 1'b0;
    end
    else begin
        if (EX_MEM_RegWrite && (EX_MEM_WriteAddr != 5'b00000) && (EX_MEM_WriteAddr == rs)) Forward_ID_A = 2'b01;  // 从EX转发
        else if (MEM_WB_RegWrite && (MEM_WB_WriteAddr != 5'b00000) && (MEM_WB_WriteAddr == rs) && ((EX_MEM_WriteAddr != rs) || ~EX_MEM_RegWrite)) Forward_ID_A = 2'b10;  // 从MEM转发
        else Forward_ID_A = 2'b00;

        if (EX_MEM_RegWrite && (EX_MEM_WriteAddr != 5'b00000) && (EX_MEM_WriteAddr == rt)) Forward_ID_B = 2'b01;  // 从EX转发
        else if (MEM_WB_RegWrite && (MEM_WB_WriteAddr != 5'b00000) && (MEM_WB_WriteAddr == rt) && ((EX_MEM_WriteAddr != rt) || ~EX_MEM_RegWrite)) Forward_ID_B = 2'b10;  // 从MEM转发
        else Forward_ID_B = 2'b00;

        if (ID_EX_RegWrite && (ID_EX_WriteAddr != 5'b00000) && (ID_EX_WriteAddr == rs)) Forward_EX_A = 2'b01;  // 从EX转发
        else if (EX_MEM_RegWrite && (EX_MEM_WriteAddr != 5'b00000) && (EX_MEM_WriteAddr == rs) && ((ID_EX_WriteAddr != rs) || ~ID_EX_RegWrite)) Forward_EX_A = 2'b10;  // 从MEM转发
        else Forward_EX_A = 2'b00;

        if (ID_EX_RegWrite && (ID_EX_WriteAddr != 5'b00000) && (ID_EX_WriteAddr == rt)) Forward_EX_B = 2'b01;  // 从EX转发
        else if (EX_MEM_RegWrite && (EX_MEM_WriteAddr != 5'b00000) && (EX_MEM_WriteAddr == rt) && ((ID_EX_WriteAddr != rs) || ~ID_EX_RegWrite)) Forward_EX_B = 2'b10;  // 从MEM转发
        else Forward_EX_B  = 2'b00;

        if (ID_EX_RegWrite && (ID_EX_WriteAddr != 5'b0) && (ID_EX_WriteAddr == rt)) Forward_MEM = 1'b1;
        else Forward_MEM = 1'b0;
    end
    end

endmodule
