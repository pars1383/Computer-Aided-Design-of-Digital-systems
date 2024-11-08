module Mux_2_to_1 
#(parameter WIDTH = 16)
(
    input sel,
    input [WIDTH -1 :0] a,
    input [WIDTH - 1:0] b,
    output [WIDTH - 1:0] out
);
    assign out = (sel) ? b:a ;
endmodule