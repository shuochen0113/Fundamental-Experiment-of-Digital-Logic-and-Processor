module Control(
	input  [5:0] OpCode,
	input  [5:0] Funct,

    output Exception, // �쳣�����ź�

	output [2:0] PCSrc,
    output Branch,
    output [2:0] BranchCondition, // ��תָ�����ת����
    output Jump,
    output RegWrite,
    output [1:0] RegDst,
    output MemRead,
    output MemWrite,
    output [1:0] MemtoReg,
    output ALUSrc1,
    output ALUSrc2,
    output ExtOp,
    output LuOp,
    output [3:0] ALUOp
);

    // Exception���˴�������δָ֪��
    assign Exception = 
    (OpCode == 6'h0f || OpCode == 6'h08 || OpCode == 6'h09 || OpCode == 6'h0c || OpCode == 6'h0d ||
    OpCode == 6'h0a || OpCode == 6'h0b || OpCode == 6'h23 || OpCode == 6'h2b || OpCode == 6'h04 || 
    OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || OpCode == 6'h01 || OpCode == 6'h02 || OpCode == 6'h03 ||
    (OpCode == 6'h00 && 
    (Funct == 6'h20 || Funct == 6'h21 || Funct == 6'h22 || Funct == 6'h23 || Funct == 6'h24 || Funct == 6'h25 ||
    Funct == 6'h26 || Funct == 6'h27 || Funct == 6'h2a || Funct == 6'h2b || Funct == 6'h0 || Funct == 6'h02 || 
    Funct == 6'h03 || Funct == 6'h08 || Funct == 6'h09)))
    ?1'b0:1'b1;

    // PCSrc
    assign PCSrc = 
    Exception?3'b100:  // �쳣����������
	(OpCode == 6'h04 || OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || OpCode == 6'h01)?3'b001:  // ��תָ��
    (OpCode == 6'h02 || OpCode == 6'h03)?3'b010:  // j��jalָ��
    (OpCode == 6'h00 && (Funct == 6'h08 || Funct == 6'h09))?3'b011:	// jr��jalrָ��
	3'b000; 

    // Branch
    assign Branch =
	((OpCode == 6'h04 || OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || OpCode == 6'h01) && ~Exception)? 1'b1: 1'b0;

    // BranchCondition
    assign BranchCondition = 
    (OpCode == 6'h05)? 3'b001: // bne
    (OpCode == 6'h06)? 3'b010: // blez
    (OpCode == 6'h07)? 3'b011: // bgtz
    (OpCode == 6'h01)? 3'b100: // bltz
    3'b000;

    // Jump
    assign Jump = 
    ((OpCode == 6'h02 || OpCode == 6'h03 || (OpCode == 6'h0 && (Funct == 6'h08 || Funct == 6'h09))) && ~Exception)?
    1'b1: 1'b0;

    // RegWrite
    assign RegWrite = 
	((~((OpCode == 6'h2b || OpCode == 6'h04 || OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || 
    OpCode == 6'h01 || OpCode == 6'h02) || (OpCode == 6'h00 && Funct == 6'h08))) && ~Exception)? 
    1'b1: 1'b0;

    // RegDst
	assign RegDst = 
    Exception? 2'b11:  // �쳣��ַ�Ĵ���
	(OpCode == 6'h03)? 2'b10:  // jal
    (OpCode == 6'h00)? 2'b01:  // R��ָ�д��rd
	2'b00;  // д��rt

    // MemRead
    assign MemRead = 
	(OpCode == 6'h23 && ~Exception)? 1'b1: 1'b0;

    // MemWrite
	assign MemWrite = 
	(OpCode == 6'h2b && ~Exception)? 1'b1: 1'b0;

    // MemtoReg
	assign MemtoReg = 
	(OpCode == 6'h23)? 2'b01: // lw��д����memout
	(OpCode == 6'h03 || (OpCode == 6'h00 && Funct == 6'h09) && Exception)? 2'b10: // jal, jalr, �쳣����д����pc
	2'b00;  // д����aluout

    // ALUSrc1, =1 ƫ����?, =0 ReadData1
	assign ALUSrc1 = 
	(OpCode == 6'h00 && (Funct == 6'h00 || Funct == 6'h02 || Funct == 6'h03))? 1'b1: 1'b0;

    // ALUSrc2, =1 ������?, =0 ReadData2
	assign ALUSrc2 = 
	(OpCode == 6'h0f || OpCode == 6'h08 || OpCode == 6'h09 || OpCode == 6'h0c || OpCode == 6'h0d ||
    OpCode == 6'h0a || OpCode == 6'h0b || OpCode == 6'h23 || OpCode == 6'h2b)?
    1'b1: 1'b0;

    // ExtOp, andi��ori���޷�����չ
	assign ExtOp = 
	(OpCode == 6'h0c || OpCode == 6'h0d)? 1'b0: 1'b1;

    // LuOp
	assign LuOp = 
	(OpCode == 6'h0f)? 1'b1: 1'b0;	

	// ALUOp
	assign ALUOp[2:0] = 
		(OpCode == 6'h00)? 3'b010:  // R��ָ��
		(OpCode == 6'h04 || OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || OpCode == 6'h01)? 3'b001: // Branch
		(OpCode == 6'h0c)? 3'b100: // andi
		(OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: // slti, sltiu
		(OpCode == 6'h0d)? 3'b110:	// ori
		3'b000; 
	assign ALUOp[3] = OpCode[0];

endmodule