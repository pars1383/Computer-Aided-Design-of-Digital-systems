module Mux_4_to_1 #(
    parameter K = 32
) (
    input [1:0] sel,
    input [K-1:0] a,
    input [K-1:0] b,
    input [K-1:0] c,
    input [K-1:0] d,
    output [K-1:0] out
);
    assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);
endmodule