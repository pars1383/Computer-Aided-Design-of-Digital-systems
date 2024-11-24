module registerN(
	input clk,
	input rst,
	input ld,
	input [2:0] par_in,
	output reg [2:0] par_out
);
	always @(posedge clk) begin
		if(rst)
			par_out <= 3'd0;
		else if(ld)
			par_out <= par_in;
	end
endmodule