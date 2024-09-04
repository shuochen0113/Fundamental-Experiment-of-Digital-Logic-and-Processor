module IF_ID_Reg(
    input clk,
    input rst,
    input flush,
    input hold,
    input [31:0] input_instruction,
    input [31:0] current_pc // 传递PC，用于后续分支跳转指令进行计算
);

    reg [31:0] instruction;
    reg [31:0] pc_plus_4;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instruction <= 0;
            pc_plus_4 <= 0;
        end
        else if(~hold && flush) begin
            instruction <= 0;
            pc_plus_4 <= current_pc;
        end
        else if (~hold) begin
            instruction <= input_instruction;
            pc_plus_4 <= current_pc + 4;
        end
    end

endmodule