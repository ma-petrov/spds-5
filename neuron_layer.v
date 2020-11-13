module neuron_layer
#(
	SIZE = 32
)
(
	input [SIZE-1:0] in,
	input [7:0] set_weight,
	input [2:0] set_addr,
	input swr, clk,
	output out
);

	wire [SIZE-1:0] mid_out;

	genvar i;
	generate
		for (i=0; i<SIZE; i=i+1)
		begin : layer_generation
			neuron neuron_inst(
				.in (in),
				.set_weight (set_weight),
				.set_addr (set_addr),
				.swr (swr),
				.clk (clk),
				.out (mid_out[i])
			);
		end
	endgenerate
	
	r_neuron r_neuron_inst(
		.in (mid_out),
		.set_weight (set_weight),
		.set_addr (set_addr),
		.swr (swr),
		.clk (clk),
		.out (out)
	);

endmodule






module r_neuron
#(
	SIZE = 32,
	ADDR_SIZE = 5
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
			sum <= mul[0]+mul[1]+mul[2]+mul[3]+mul[4]+mul[5]+mul[6]+mul[7]+mul[8]+mul[9]+mul[10]+mul[11]+mul[12]+mul[13]+mul[14]+mul[15]+mul[16]+mul[17]+mul[18]+mul[19]+mul[20]+mul[21]+mul[22]+mul[23]+mul[24]+mul[25]+mul[26]+mul[27]+mul[28]+mul[29]+mul[30]+mul[31];
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
		weight[8] = 8'b00001010;
		weight[9] = 8'b00000110;
		weight[10] = 8'b00000001;
		weight[11] = 8'b00000010;
		weight[12] = 8'b00000010;
		weight[13] = 8'b00000011;
		weight[14] = 8'b00000001;
		weight[15] = 8'b00001110;
		weight[16] = 8'b00001010;
		weight[17] = 8'b00000110;
		weight[18] = 8'b00000001;
		weight[19] = 8'b00000011;
		weight[20] = 8'b00000011;
		weight[21] = 8'b00000001;
		weight[22] = 8'b00000001;
		weight[23] = 8'b00001011;
		weight[24] = 8'b00001010;
		weight[25] = 8'b00000110;
		weight[26] = 8'b00000001;
		weight[27] = 8'b00000011;
		weight[28] = 8'b00000011;
		weight[29] = 8'b00000001;
		weight[30] = 8'b00000001;
		weight[31] = 8'b00001011;
	end

endmodule
