module out_ram(
	    input clk,
	    input [2:0]address,
        input [31:0] data_in,
        input wren
	);

	reg [31:0] out_ram_block [0:7];

	always @(posedge clk) begin
        if(wren)
		    out_ram_block[address] <= data_in;
	end
endmodule