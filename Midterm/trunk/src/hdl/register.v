module register #(
	parameter K = 32
) 
(
	input clk,
	input rst,
	input ld,
	input [K-1:0] par_in,
	output reg [K-1 :0] par_out
);
	always @(posedge clk) begin
		if(rst)
			par_out <= 0;
		else if(ld)
			par_out <= par_in;
	end
endmodule