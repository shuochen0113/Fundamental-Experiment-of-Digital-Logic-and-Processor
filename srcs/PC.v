module PC(
    input clk,
    input rst,
    input [2:0] PCSrc,
    input [31:0] branch_target,
    input [31:0] jump_target,
    input [31:0] jump_reg_target,
    input data_hazard,
    input exception,
    // input [31:0] input_pc,
    // input pc_hold, // 保持PC不动的控制信号
    
    output reg [31:0] output_pc
);

    wire [31:0] pc_plus_4;
    assign pc_plus_4 = output_pc + 4;
    wire pc_write;
    assign pc_write = ~data_hazard || exception;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            output_pc <= 32'h00400000;
        end
//        else if(pc_hold) begin
//            output_pc <= output_pc; // 保持pc
//        end
        else if (pc_write) begin
            case (PCSrc)
                3'b000: output_pc <= pc_plus_4;
                3'b001: output_pc <= branch_target; 
                3'b010: output_pc <= jump_target; 
                3'b011: output_pc <= jump_reg_target; 
                3'b100: output_pc <= 32'h8000_0004; // 异常处理程序入口
                default: output_pc <= 32'hffff_ffff; // 未知错误
            endcase
        end
    end

endmodule