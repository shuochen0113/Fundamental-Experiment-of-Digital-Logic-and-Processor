module DataMem(
    input clk,
    input rst,
    input MemRead,
    input MemWrite,
    input [31:0] Address,
    input [31:0] Write_data,
    output [31:0] Read_data
);

    // 数据存储器地址 0x0000_0000~0x0000_07FF，共2048bit
    // 有效地址位为8bit，则总共有256个word的空间
	parameter RAM_SIZE      = 256;
	parameter RAM_SIZE_BIT  = 8;

	reg [31:0] RAM_data [RAM_SIZE - 1: 0];
	assign Read_data = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;

	integer i;
	always @(posedge clk or posedge rst)begin
		if (rst)begin
			for (i = 0; i < 16; i = i + 1)
                RAM_data[i] <= 32'h00000000;
		    RAM_data[16] <= 32'h00000014;
		    RAM_data[17] <= 32'h000041a8;
		    RAM_data[18] <= 32'h00003af2;
		    RAM_data[19] <= 32'h0000acda;
		    RAM_data[20] <= 32'h00000c2b;
		    RAM_data[21] <= 32'h0000b783;
		    RAM_data[22] <= 32'h0000dac9;
		    RAM_data[23] <= 32'h00008ed9;
		    RAM_data[24] <= 32'h000009ff;
		    RAM_data[25] <= 32'h00002f44;
		    RAM_data[26] <= 32'h0000044e;
		    RAM_data[27] <= 32'h00009899;
		    RAM_data[28] <= 32'h00003c56;
		    RAM_data[29] <= 32'h0000128d;
		    RAM_data[30] <= 32'h0000dbe3;
		    RAM_data[31] <= 32'h0000d4b4;
		    RAM_data[32] <= 32'h00003748;
		    RAM_data[33] <= 32'h00003918;
		    RAM_data[34] <= 32'h00004112;
		    RAM_data[35] <= 32'h0000c399;
		    RAM_data[36] <= 32'h00004955;
			for (i = 37; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;
		end
		else if (MemWrite) begin
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
		end
	end

endmodule