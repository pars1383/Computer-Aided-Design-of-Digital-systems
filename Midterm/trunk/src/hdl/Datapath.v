module Datapath #(
    parameter K = 32
)   (
    input clk, 
    input rst,
    input sel1,
    input sel2,
    input sel3,
    input sel4,
    input sel5,
    input sel6,
    input sel7,
    input sel8,
    input ldcnt1,
    input ldcnt2,
    input ld1,
    input ld2,
    input ld3,
    input ld4,
    input ld5,
    input ld6,
    input ld7,
    input ld8,
    input ld9,
    input loadN,
    input ldshreg,
    input dec,
    input signed [7:0] X,
    input [2:0] N,
    output signed [K-1:0] Y,
    output Ready,
    output Valid,
    output Overflow,
    output Error,
    output opdone,
    output stalldone
 );


    wire signed [K-1:0] inx , outx, outx1, outx2, outx3, outx4, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16;
    wire [1:0] remaindern;
    wire [2:0] outN , inN;

     Mux_2_to_1 muxin
    (
        .sel(sel8),
        .a(outx),
        .b(outx4),
        .out(inx)
    );

    
      register #(
        .K(K)
    ) regX1(
        .clk(clk),
        .rst(rst),
        .ld(ld1),
        .par_in({{24{X[7]}}, X}),
        .par_out(outx)
    );

      register #(
        .K(K)
    ) regX2(
        .clk(clk),
        .rst(rst),
        .ld(ldshreg),
        .par_in(inx),
        .par_out(outx1)
    );

      register #(
        .K(K)
    ) regX3(
        .clk(clk),
        .rst(rst),
        .ld(ldshreg),
        .par_in(outx1),
        .par_out(outx2)
    );

      register #(
        .K(K)
    ) regX4(
        .clk(clk),
        .rst(rst),
        .ld(ldshreg),
        .par_in(outx2),
        .par_out(outx3)
    );

    register #(
        .K(K)
    ) regX5(
        .clk(clk),
        .rst(rst),
        .ld(ldshreg),
        .par_in(outx3),
        .par_out(outx4)
    );



     registerN  regN(
        .clk(clk),
        .rst(rst),
        .ld(loadN),
        .par_in(inN),
        .par_out(outN)
    );
    

    Block #(
    .K(K)
)   MAC1(
     .clk(clk), 
     .rst(rst),
     .in1(outx),
     .in2(w14),
     .in3(w16),
     .in4(inx),
     .co1({21'd0 , 1'b1 , 10'd0}), // 1
     .co2({ 22'd0 ,10'b0011001100}),   // 1/5
     .sel1(sel1),
     .sel2(sel1),
     .mode(1'b0),
     .out1(w1),
     .out2(w3)
 );

  register #(
        .K(K)
  ) multreg1(
        .clk(clk),
        .rst(rst),
        .ld(ld2),
        .par_in(w1),
        .par_out(w2)
    );

      register #(
        .K(K)
      ) resreg1(
        .clk(clk),
        .rst(rst),
        .ld(ld3),
        .par_in(w3),
        .par_out(w4)
    );

 Block #(
    .K(K)
)   MAC2(
     .clk(clk), 
     .rst(rst),
     .in1(w2),
     .in2(w2),
     .in3(w4),
     .in4(outx1),
     .co1({ 22'd0 ,1'b1 , 9'd0}),   // 1/2
     .co2({ 22'd0 ,10'b0010101010}),   // 1/6 
     .sel1(sel2),
     .sel2(sel3),
     .mode(1'b1),
     .out1(w5),
     .out2(w7)
 );

   register #(
        .K(K)
   ) multreg2(
        .clk(clk),
        .rst(rst),
        .ld(ld4),
        .par_in(w5),
        .par_out(w6)
    );

      register #(
        .K(K)
      ) resreg2(
        .clk(clk),
        .rst(rst),
        .ld(ld5),
        .par_in(w7),
        .par_out(w8)
    );


 Block #(
    .K(K)
)   MAC3(
     .clk(clk), 
     .rst(rst),
     .in1(w6),
     .in2(w6),
     .in3(w8),
     .in4(outx2),
     .co1({ 22'd0 ,10'b0101010101}),   // 1/3
     .co2({ 22'd0 ,10'b0010010010}),   // 1/7
     .sel1(sel4),
     .sel2(sel5),
     .mode(1'b0),
     .out1(w9),
     .out2(w11)
 );

   register #(
        .K(K)
   ) multreg3(
        .clk(clk),
        .rst(rst),
        .ld(ld6),
        .par_in(w9),
        .par_out(w10)
    );


      register #(
        .K(K)
      ) resreg3(
        .clk(clk),
        .rst(rst),
        .ld(ld7),
        .par_in(w11),
        .par_out(w12)
    );


 Block #(
    .K(K)
)   MAC4(
     .clk(clk), 
     .rst(rst),
     .in1(w10),
     .in2(w10),
     .in3(w12),
     .in4(outx3),
     .co1({ 22'd0 ,2'b01 , 8'd0}),  // 1/4
     .co2({ 22'd0 ,3'b001 , 7'd0}),  // 1/8
     .sel1(sel6),
     .sel2(sel7),
     .mode(1'b1),
     .out1(w13),
     .out2(w15)
 );


 

  register #(
        .K(K)
  ) multreg4(
        .clk(clk),
        .rst(rst),
        .ld(ld8),
        .par_in(w13),
        .par_out(w14)
    );

      register #(
        .K(K)
      ) resreg4(
        .clk(clk),
        .rst(rst),
        .ld(ld9),
        .par_in(w15),
        .par_out(w16)
    );

    Mux_4_to_1 mux
    (
        .sel(remaindern),
        .a(w4),
        .b(w8),
        .c(w12),
        .d(w16),
        .out(Y)
    );

   down_counter_3bit downcounter(
        .clk(clk),
        .rst(rst),
        .data(outN),
        .ldcnt(ldcnt1),    
        .dec(dec),
        .carry(opdone)
    );

    up_counter_2bit upcounter(
        .clk(clk),
        .rst(rst),
        .ldcnt(ldcnt2),  
        .data(2'd0),
        .carry(stalldone)
    );

    assign remaindern = outN%4;
    assign inN = N-1;

endmodule