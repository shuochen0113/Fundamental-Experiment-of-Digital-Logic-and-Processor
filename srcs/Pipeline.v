module Pipeline(
    input clk,
    input rst,
    output [3:0] ano,
    output [7:0] leds
    // TODO: ���UART
);

    // �쳣���ж�
    wire exception;

    // �����ź�
    wire [2:0] PCSrc;
    wire Branch;
    wire [2:0] BranchCondition;
    wire Jump;
    wire RegWrite;
    wire [1:0] RegDst;
    wire MemRead;
    wire MemWrite;
    wire [1:0] MemtoReg;
    wire ALUSrc1;
    wire ALUSrc2;
    wire ExtOp;
    wire LuOp;
    wire [3:0] ALUOp;

    // ð�ձ����ź�
    wire control_hazard;
    wire data_hazard;

    // ת�������ź�
    wire [1:0] Forward_ID_A;  // IDת����ԪA(to rs)
    wire [1:0] Forward_ID_B;  // IDת����ԪB(to rt)
    wire [1:0] Forward_EX_A;  // EXת����ԪA(to rs)
    wire [1:0] Forward_EX_B;  // EXת����ԪB(to rt)
    wire Forward_MEM;         // MEMת����Ԫ(to rt, for lw-sw hazard)

    // IF�׶�ʹ�õ��ź�
    // reg [31:0] input_pc;
    // wire pc_hold;
    wire [31:0] output_pc;
    wire [31:0] instruction;
    wire [31:0] branch_target; // �����֧Ŀ���ַ
    wire [31:0] jump_target; // ������תĿ���ַ
    wire [31:0] jump_reg_target; // ����Ĵ�����תĿ���ַ
    wire IF_ID_flush;  // ����ð��ʱ��Ҫflush IF/ID
    wire IF_ID_hold;  // load_use_hazardʱ��Ҫ����IF/ID
    //wire [31:0] pc_to_ID;

    // ID�׶�ʹ�õ��ź�
    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;

    wire [31:0] rs_data;
    wire [31:0] rt_data;
    wire [31:0] ID_rs_data_actual;  // ID�׶ο���ת������ʵrs_data
    wire [31:0] ID_rt_data_actual;  // ID�׶ο���ת������ʵrt_data
    wire [31:0] imm_ext;
    wire ID_EX_flush;  // load_use_hazard��Ҫflush ID/EX
    wire [4:0] WriteAddr;
    wire whether_branch;  // ���������ۿ�ѧ��zero�źţ�������Ӧ����ķ�ָ֧��
    wire branch_hazard;

    // EX�׶�ʹ�õ��ź�
    wire [31:0] EX_rs_data_actual;  // EX�׶ο���ת������ʵrs_data
    wire [31:0] EX_rt_data_actual;  // EX�׶ο���ת������ʵrt_data
    wire [4:0] ALUCtl;
    wire Sign;
    wire [31:0] ALUin1;
    wire [31:0] ALUin2;
    wire [31:0] ALUOut;

    // MEM�׶�ʹ�õ��ź�
    wire [31:0] MEM_WriteData;
    wire [31:0] MEM_ReadData;
    wire [31:0] MEM_PeripheralData; 
    wire [31:0] MEM_Data;  // ѡ�������ݴ洢�����ݻ�����������
    wire [31:0] MEMOut;
    wire peripherial;   // ��������ź�


/*-------------------------------------------BEGIN_IF-------------------------------------------
---------------------IF�׶εĹ�����ʵ��ȡ��ǰPC��ַ��ָ���PC+4(����IF/ID����Ĵ�����)-------------------*/

    assign pc_hold = data_hazard; // load_use_hazard��Ҫ���ֵ�ǰPC

//    // ��һ��PC��ַ
//    always @(*) begin
//        case (PCSrc)
//            3'b000: input_pc = output_pc + 4;
//            3'b001: input_pc = branch_target; 
//            3'b010: input_pc = jump_target; 
//            3'b011: input_pc = jump_reg_target; 
//            3'b100: input_pc = 32'h8000_0004; // �쳣����������
//            default: input_pc = 32'hffff_ffff; // δ֪����
//        endcase
//    end

    assign IF_ID_flush = control_hazard || exception;
    assign IF_ID_hold = data_hazard && ~exception; 

    PC pc1(
        .clk(clk),
        .rst(rst),
        .PCSrc(PCSrc),
        .branch_target(branch_target),
        .jump_target(jump_target),
        .jump_reg_target(jump_reg_target),
        // .input_pc(input_pc),
        //.pc_hold(pc_hold),
        .data_hazard(data_hazard),
        .exception(exception),
        .output_pc(output_pc)
    );

    InstMem instmem1(
        .address(output_pc),
        .inst(instruction)
    );

    IF_ID_Reg ifidreg1(
        .clk(clk),
        .rst(rst),
        .flush(IF_ID_flush),
        .hold(IF_ID_hold),
        .input_instruction(instruction),
        .current_pc(output_pc)
    );

/*-------------------------------------------END_IF-----------------------------------------------------------*/


/*-------------------------------------------BEGIN_ID----------------------------------------------------------
------------ID�׶εĹ�����ָ������ͼĴ�����ȡ�������ź����ɣ����������ɣ���֧��תָ�����ǰ�ж�---------------------------*/
    
    // assign ID_EX_flush = data_hazard;
    assign opcode = ifidreg1.instruction[31:26];
    assign rs = ifidreg1.instruction[25:21];
    assign rt = ifidreg1.instruction[20:16];
    assign rd = ifidreg1.instruction[15:11];
    assign shamt = ifidreg1.instruction[10:6];
    assign funct = ifidreg1.instruction[5:0];

    Control control1(
        .OpCode(opcode),
        .Funct(funct),
        .Exception(exception),
        .PCSrc(PCSrc),
        .Branch(Branch),
        .BranchCondition(BranchCondition),
        .Jump(Jump),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ALUSrc1(ALUSrc1),
        .ALUSrc2(ALUSrc2),
        .ExtOp(ExtOp),
        .LuOp(LuOp),
        .ALUOp(ALUOp)
    );

    RegFile regfile1(
        .clk(clk),
        .rst(rst),
        .RegWrite(memwbreg1.RegWrite),  
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(memwbreg1.WriteAddr),
        .write_data(memwbreg1.MEMOut),
        .read_data1(rs_data),
        .read_data2(rt_data)
    );

    ImmExt immext1(
        .ExtOp(ExtOp),
        .LuOp(LuOp),
        .immdiate({rd, shamt, funct}),
        .immdiate_ext(imm_ext)
    );

    // �Ĵ���д��ַ�ж�
    assign WriteAddr = (RegDst == 2'b00)? rt:
    (RegDst == 2'b01)? rd:
    (RegDst == 2'b10)? 5'd31:  // $ra��31�żĴ���
    5'd26;  // �쳣�����д��$k0�Ĵ���

    // ����ð��
    DataHazard datahazard1(
        .ID_EX_RegWrite(idexreg1.RegWrite),
        .ID_EX_WriteAddr(idexreg1.WriteAddr),
        .EX_MEM_WriteAddr(exmemreg1.WriteAddr),  
        .ID_EX_MemRead(idexreg1.MemRead),
        .ID_MemWrite(MemWrite),
        .EX_MEM_MemRead(exmemreg1.MemRead),  
        .rs(rs),
        .rt(rt),
        .PCSrc(PCSrc),
        .data_hazard(data_hazard)
    );

    Forward forward1(
        .rst(rst),
        .ID_EX_RegWrite(idexreg1.RegWrite),
        .ID_EX_WriteAddr(idexreg1.WriteAddr),
        .EX_MEM_RegWrite(exmemreg1.RegWrite),  
        .EX_MEM_WriteAddr(exmemreg1.WriteAddr),  
        .MEM_WB_RegWrite(memwbreg1.RegWrite), 
        .MEM_WB_WriteAddr(memwbreg1.WriteAddr),  
        .rs(rs),
        .rt(rt),
        .Forward_ID_A(Forward_ID_A),
        .Forward_ID_B(Forward_ID_B),
        .Forward_EX_A(Forward_EX_A),
        .Forward_EX_B(Forward_EX_B),
        .Forward_MEM(Forward_MEM)
    );

    assign ID_rs_data_actual = (Forward_ID_A == 2'b01)? exmemreg1.ALUOut: (Forward_ID_A == 2'b10)? memwbreg1.MEMOut: rs_data;  
    assign ID_rt_data_actual = (Forward_ID_B == 2'b01)? exmemreg1.ALUOut: (Forward_ID_B == 2'b10)? memwbreg1.MEMOut: rt_data;  

    // ��ת��ַ����
    assign jump_target = {ifidreg1.pc_plus_4[31:28], rs, rt, rd, shamt, funct, 2'b00};
    assign jump_reg_target = ID_rs_data_actual;

    // ��֧�������
    assign whether_branch = 
    (BranchCondition == 3'b001)? (~(ID_rs_data_actual == ID_rt_data_actual)):  // bne
    (BranchCondition == 3'b010)? (ID_rs_data_actual[31] || ID_rs_data_actual == 32'h00000000): // blez
    (BranchCondition == 3'b011)? (~(ID_rs_data_actual[31] || ID_rs_data_actual == 32'h00000000)): // bgtz
    (BranchCondition == 3'b100)? (ID_rs_data_actual[31]): // bltz
    (ID_rs_data_actual == ID_rt_data_actual);  // beq
    assign branch_target = (whether_branch)? (ifidreg1.pc_plus_4 + (imm_ext<<2)): ifidreg1.pc_plus_4 + 4;  // �����branch�Ͳ�stall, �������ﻹҪ+4

    // ����ð��
    assign branch_hazard = whether_branch && Branch;
    ControlHazard controlhazard1(
        .jump(Jump),
        .branch_hazard(branch_hazard),
        .control_hazard(control_hazard)
    );
    
    assign ID_EX_flush = data_hazard;

    ID_EX_Reg idexreg1(
        .clk(clk),
        .rst(rst),
        .flush(ID_EX_flush),
        .input_RegWrite(RegWrite),
        .input_MemRead(MemRead),
        .input_MemWrite(MemWrite),
        .input_MemtoReg(MemtoReg),
        .input_ALUSrc1(ALUSrc1),
        .input_ALUSrc2(ALUSrc2),
        .input_ALUOp(ALUOp),
        .input_WriteAddr(WriteAddr),
        .input_rs_data(ID_rs_data_actual),
        .input_rt_data(ID_rt_data_actual),
        .input_imm_ext(imm_ext),
        .input_pc_plus_4(ifidreg1.pc_plus_4),
        .input_Forward_EX_A(Forward_EX_A),
        .input_Forward_EX_B(Forward_EX_B),
        .input_Forward_MEM(Forward_MEM),
        .input_Funct(funct),
        .input_Shamt(shamt)
    );

/*-------------------------------------------END_ID----------------------------------------------------------*/


/*-------------------------------------------BEGIN_EX----------------------------------------------------------
--------EX�׶εĹ����ǽ��ת��ѡ���źŸ�ALU����ALU�����źŵĿ�����������----------------------------------------------*/
    
    assign EX_rs_data_actual = (idexreg1.Forward_EX_A == 2'b01)? exmemreg1.ALUOut: (idexreg1.Forward_EX_A == 2'b10)? memwbreg1.MEMOut: idexreg1.rs_data; 
    assign EX_rt_data_actual = (idexreg1.Forward_EX_B == 2'b01)? exmemreg1.ALUOut: (idexreg1.Forward_EX_B == 2'b10)? memwbreg1.MEMOut: idexreg1.rt_data;  
    assign ALUin1 = idexreg1.ALUSrc1? {27'h00000, idexreg1.Shamt}: EX_rs_data_actual;
    assign ALUin2 = idexreg1.ALUSrc2? idexreg1.imm_ext: EX_rt_data_actual;

    ALUControl alucontrol1(
        .ALUOp(idexreg1.ALUOp),
        .Funct(idexreg1.Funct),
        .ALUCtl(ALUCtl),
        .Sign(Sign)
    );

    ALU alu1(
        .in1(ALUin1),
        .in2(ALUin2),
        .ALUCtl(ALUCtl),
        .Sign(Sign),
        .out(ALUOut)
    );

    EX_MEM_Reg exmemreg1(
        .clk(clk),
        .rst(rst),
        .input_MemRead(idexreg1.MemRead),
        .input_MemWrite(idexreg1.MemWrite),
        .input_rt_data(idexreg1.rt_data),
        .input_WriteAddr(idexreg1.WriteAddr),
        .input_MemtoReg(idexreg1.MemtoReg),
        .input_RegWrite(idexreg1.RegWrite),
        .input_ALUOut(ALUOut),
        .input_pc_plus_4(idexreg1.pc_plus_4),
        .input_Forward_MEM(idexreg1.Forward_MEM)
    );

/*-------------------------------------------END_EX----------------------------------------------------------*/


/*-------------------------------------------BEGIN_MEM----------------------------------------------------------
------------------------------------MEM�׶εĹ����ǽ��д洢���Ķ�д-------------------------------------------------*/

    assign peripheral = (exmemreg1.ALUOut == 32'h4000_0010 || (exmemreg1.ALUOut >= 32'h4000_0018 && exmemreg1.ALUOut <= 32'h4000_0020));
    assign MEM_WriteData = exmemreg1.Forward_MEM? memwbreg1.MEMOut: exmemreg1.rt_data;

    DataMem datamem1(
        .clk(clk),
        .rst(rst),
        .MemRead(exmemreg1.MemRead && ~peripheral),
        .MemWrite(exmemreg1.MemWrite && ~peripheral),
        .Address(exmemreg1.ALUOut),
        .Write_data(MEM_WriteData),
        .Read_data(MEM_ReadData)
    );

    Peripheral peripheral1(
        .clk(clk),
        .rst(rst),
        .MemRead(exmemreg1.MemRead && peripheral),
        .MemWrite(exmemreg1.MemWrite && peripheral),
        .Address(exmemreg1.ALUOut),
        .Write_data(MEM_WriteData),
        .Read_data(MEM_PeripheralData),
        .ano(ano),
        .leds(leds)
    );

    assign MEM_Data = peripheral? MEM_PeripheralData: MEM_ReadData;
    assign MEMOut = (exmemreg1.MemtoReg == 2'b00)? exmemreg1.ALUOut:
    (exmemreg1.MemtoReg == 2'b01)? MEM_Data:
    exmemreg1.pc_plus_4;

    MEM_WB_Reg memwbreg1 (
        .clk(clk),
        .rst(rst),
        .input_RegWrite(exmemreg1.RegWrite),
        .input_WriteAddr(exmemreg1.WriteAddr),
        .input_MEMOut(MEMOut)
    );

/*-------------------------------------------END_MEM----------------------------------------------------------*/


/*------------WB�׶εĹ�����д�Ĵ������Ѿ�һ����ID�׶ε���������������ˣ���ȡ�Ŀ����ź�Ҳ��MEM/WB����Ĵ�������ź�-----------------*/

endmodule