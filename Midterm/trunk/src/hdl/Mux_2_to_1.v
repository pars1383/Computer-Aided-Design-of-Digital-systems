module Mux_2_to_1 #(
    parameter K = 32
) (
    input sel,
    input [K-1:0] a,
    input [K-1:0] b,
    output [K-1:0] out
);
    assign out = (sel) ? b : a ;
endmodule