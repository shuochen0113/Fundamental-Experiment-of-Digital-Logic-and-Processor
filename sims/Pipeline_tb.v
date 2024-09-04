module Pipeline_tb();

    reg clk;
    reg rst;
    wire [3:0] ano;
    wire [7:0] leds;

    Pipeline uut (
        .clk(clk),
        .rst(rst),
        .ano(ano),
        .leds(leds)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
    end

endmodule