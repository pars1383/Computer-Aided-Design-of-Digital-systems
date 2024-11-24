module maclauren #(
    parameter K = 32
)   (
    input clk, 
    input rst,
    input start,
    input signed [7:0] X,
    input [2:0] N,
    output signed [K-1:0] Y,
    output ready,
    output valid,
    output overflow,
    output error
 );


    wire ld1,ld2,ld3,ld4,ld5,ld6,ld7,ld8,ld9 ,sel1, sel2, sel3, sel4, sel5, sel6, sel7,sel8, ldcnt1, ldcnt2, stalldone
         , opdone, loadN, ldshreg, dec;

    
      Datapath #(
        .K(K)
      ) datapath(
         .clk(clk), 
          .rst(rst),
          .sel1(sel1),
          .sel2(sel2),
          .sel3(sel3),
          .sel4(sel4),
          .sel5(sel5),
          .sel6(sel6),
          .sel7(sel7),
          .sel8(sel8),
          .ldcnt1(ldcnt1),
          .ldcnt2(ldcnt2),
          .ld1(ld1),
          .ld2(ld2),
          .ld3(ld3),
          .ld4(ld4),
          .ld5(ld5),
          .ld6(ld6),
          .ld7(ld7),
          .ld8(ld8),
          .ld9(ld9),
          .loadN(loadN),
          .ldshreg(ldshreg),
          .dec(dec),
          .X(X),
          .N(N),
          .Y(Y),
          .Ready(ready),
          .Valid(valid),
          .Overflow(overflow),
          .Error(error),
          .opdone(opdone),
          .stalldone(stalldone)
    );

    Controller #(
        .K(K)
    ) controller(
         .clk(clk), 
          .rst(rst),
          .start(start),
          .opdone(opdone),
          .stalldone(stalldone),
          .ldcnt1(ldcnt1),
          .ldcnt2(ldcnt2),
          .sel1(sel1),
          .sel2(sel2),
          .sel3(sel3),
          .sel4(sel4),
          .sel5(sel5),
          .sel6(sel6),
          .sel7(sel7),
          .sel8(sel8),
          .ld1(ld1),
          .ld2(ld2),
          .ld3(ld3),
          .ld4(ld4),
          .ld5(ld5),
          .ld6(ld6),
          .ld7(ld7),
          .ld8(ld8),
          .ld9(ld9),
          .loadN(loadN),
          .ldshreg(ldshreg),
          .dec(dec),
          .Valid(valid),
          .Ready(ready),
          .Error(error),
          .Overflow(overflow)
    );
    


endmodule