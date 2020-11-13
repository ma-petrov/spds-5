module vocoder
#(
    parameter SIZE = 3;
    parameter WIDTH = 3
)
(
    input clk,
    input [WIDTH-1:0] data_in,
    output [WIDTH-1:0] data_out
);
    // Loval wires and registers
    reg [WIDTH-1:0] divide_buf [SIZE-1:0];
    
    
    reg cnt_2; // Counter from 0 to 1
	 reg [WIDTH-1:0] divide_buf_out;

    always @ (posedge clk) begin
        cnt_2 = ~cnt_2;
        if (cnt_2==1'b1)
            divide_buf_out <= divide_buf[SIZE-1];
            divide_buf <= {divide_buf[SIZE-2:0], data_in};
    end

	 assign data_out = divide_buf_out;

endmodule







module shift_reg
#(
    parameter SIZE = 8;
);
(
    input in, clk,
    output reg out
)
    reg [SIZE-1:0] data

    always @ (posedge clk)
    begin
        out <= data[SIZE-1];
        data <= {data[SIZE-2:0], in};
    end
endmodule


