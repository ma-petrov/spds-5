`timescale 1 ps/ 1 ps
module vocoder_2_test();

    reg [23:0] data_in;
    reg [23:0] data_out;
    reg clk, status;

    vocoder_2 vocoder_2 (
        .clk ( clk ),
        .data_in ( data_in ),
        .data_out ( data_out ),
        .status ( status )
    );

    initial begin
        clk = 0;
        data_in = 3'b000;
        #20;
        data_in = 3'b001;
        #20;
        data_in = 3'b010;
        #20;
        data_in = 3'b011;
        #20;
        data_in = 3'b101;
        #20;
        data_in = 3'b100;
        #20;
        data_in = 3'b011;
        #20;
        data_in = 3'b010;
        #20;
        data_in = 3'b001;
        #160;
    end

    always
        #10 clk = ~clk;

    

endmodule