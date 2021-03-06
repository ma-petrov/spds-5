module vocoder_2
#(
    parameter SIZE = 8;
    parameter WIDTH = 3
)
(
    input clk,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);
    reg status;
	 
	 voc_unit voc_unit_1 (
        .clk ( clk ),
		  .data_in ( data_in ),
		  .data_out ( data_out ),
		  .status ( status )
	 );


endmodule






module voc_unit
#(
    parameter SIZE = 8;
    parameter WIDTH = 3
)
(
    input clk,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,
    output reg status

);
    reg [WIDTH-1:0] data [SIZE-1:0];
    reg [2:0] counter;
    integer i;

    always @ (posedge clk)
    begin
        if (counter < 4'b1000)
            counter <= counter + 1;
        else
        begin
            counter <= 0;
            status <= ~status;
        end
    end

    // writing data to unit
    always @ (posedge clk)
    begin
        if (status == 1'b0 & counter[0] == 1'b0)
        begin
            for (i = 0; i < WIDTH; i = i + 1)
            begin
                data[{1'b0, counter[2:1]}][i] <= data_in[i];
                data[{1'b1, counter[2:1]}][i] <= data_in[i];
            end
        end
    end

    // reading data from unit
    always @ (posedge clk)
    begin
        if (status == 1'b1)
            for (i = 0; i < WIDTH; i = i + 1)
                data_out[i] <= data[counter[2:0]][i];
    end

endmodule

