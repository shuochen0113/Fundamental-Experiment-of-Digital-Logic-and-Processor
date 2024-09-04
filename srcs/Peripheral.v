module Peripheral (
    input clk,
    input rst,
    input MemRead,
    input MemWrite,
    input [31:0] Address,
    input [31:0] Write_data,
    output reg [31:0] Read_data,
    output reg [3:0] ano,
    output reg [7:0] leds
    // TODO: Ìí¼ÓUART
);

    always @(*) begin
        case(Address)
            32'h4000_0010: Read_data <= MemRead? {20'b0, ano, leds} : 32'b0;
            default: Read_data <= 32'b0;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            ano <= 0;
            leds <= 0;
        end
        else if(MemWrite) begin
            case(Address)
                32'h4000_0010: begin
                    ano <= Write_data[11:8];
                    leds <= Write_data[7:0];
                end
                default: begin
                    ano <= ano;
                    leds <= leds;
                end
            endcase
        end
    end

endmodule