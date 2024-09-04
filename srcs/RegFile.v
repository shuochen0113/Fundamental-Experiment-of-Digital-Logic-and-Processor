module RegFile(
    input clk,
    input rst,
    input RegWrite,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    
    output [31:0] read_data1,
    output [31:0] read_data2
);
    
    // 不需要定义RF_data[0]的原因是0号寄存器始终为0
    reg [31:0] RF_data [31:1];

    assign read_data1 = (read_reg1 == 5'b00000)? 32'h0: RF_data[read_reg1];
    assign read_data2 = (read_reg2 == 5'b00000)? 32'h0: RF_data[read_reg2];

    integer i;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            for (i=1; i<32; i=i+1) begin
                RF_data[i] <= 32'h0;
            end
        end
        else if (RegWrite && (write_reg != 5'b00000)) begin
                RF_data[write_reg] <= write_data;
        end
    end
            

endmodule