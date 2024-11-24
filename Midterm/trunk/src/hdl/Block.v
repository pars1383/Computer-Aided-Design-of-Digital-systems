module Block #(
    parameter K = 32
)   (
    input clk, 
    input rst,
    input signed [K-1:0] in1,
    input signed [K-1:0] in2,
    input signed [K-1:0] in3,
    input signed [K-1:0] in4,
    input [K-1:0] co1,
    input [K-1:0] co2,
    input sel1,
    input sel2,
    input mode,
    output reg signed [K-1:0] out1,
    output reg signed [K-1:0] out2
 );


    wire signed [K-1:0] w1, w2, w3 , w5;
        
    reg signed [K-1:0] w4, w6, w41;

   
   
    Mux_2_to_1 mux1
    (
        .sel(sel1),
        .a(in1),
        .b(in2),
        .out(w1)
    );

    Mux_2_to_1 mux2
    (
        .sel(sel1),
        .a(32'd1),
        .b(in4),
        .out(w2)
    );


    Mux_2_to_1 mux3
    (
        .sel(sel2),
        .a(co1),
        .b(co2),
        .out(w3)
    );

    Mux_2_to_1 mux4
    (
        .sel(sel1),
        .a(32'd0),
        .b(in3),
        .out(w5)
    );


    always @(*) begin
        w6 = w1 * w2;
        out1 = w6;
        w41 = (w6 * w3);
        w4 = w41>>>10;
        if (mode == 0)
          out2 = w4 + w5;
        else 
            out2 = w5 - w4;
    end
endmodule