module neuron
#(
	SIZE = 8,
	ADDR_SIZE = 3
)
(
	input [SIZE-1:0] in,
	input [SIZE-1:0] set_weight,
	input [ADDR_SIZE-1:0] set_addr,
	input swr, clk,
	output reg out
);
	reg [7:0] weight [SIZE-1:0];

	always @ (posedge clk)
		if (swr==1)
			weight[set_addr] <= set_weight;

	reg [7:0] mul [SIZE-1:0];
	reg [7:0] sum;
	integer i;

	always @ (posedge clk) begin
		if (swr==0)
			for (i=0; i<SIZE; i=i+1)
				mul[i] <= weight[i] * in[i];
			sum <= mul[0]+mul[1]+mul[2]+mul[3]+mul[4]+mul[5]+mul[6]+mul[7];
			if (sum > 8'b10000000)
				out <= 1'b1;
			else
				out <= 1'b0;
	end
	
	initial begin
		weight[0] = 8'b11101010;
		weight[1] = 8'b00000110;
		weight[2] = 8'b00000001;
		weight[3] = 8'b00000010;
		weight[4] = 8'b00101010;
		weight[5] = 8'b00011111;
		weight[6] = 8'b00000001;
		weight[7] = 8'b00001010;
	end

endmodule
