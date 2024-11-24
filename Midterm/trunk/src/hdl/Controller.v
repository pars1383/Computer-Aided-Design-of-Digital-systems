module Controller #(
    parameter K = 32
)  (
    input clk,
    input rst,
    input start,
    input opdone,
    input stalldone,
    output reg ldcnt1,
    output reg ldcnt2,
    output reg sel1,
    output reg sel2,
    output reg sel3,
    output reg sel4,
    output reg sel5,
    output reg sel6,
    output reg sel7,
    output reg sel8,
    output reg ld1,
    output reg ld2,
    output reg ld3,
    output reg ld4,
    output reg ld5,
    output reg ld6,
    output reg ld7,
    output reg ld8,
    output reg ld9,
    output reg loadN,
    output reg ldshreg,
    output reg dec,
    output reg Valid,
    output reg Ready,
    output reg Error,
    output reg Overflow
);
    parameter Idle = 4'd0 , strt = 4'd1 ,load = 4'd2, s1 = 4'd3 , s2 = 4'd4 , s3 = 4'd5 ,
              s4 = 4'd6 , s5 = 4'd7 , s6 = 4'd8 , s7 = 4'd9 , s8 = 4'd10 ,
              s9 = 4'd11 , s10 = 4'd12 , s11 = 4'd13, s12 = 4'd14;

    reg [3:0] ps , ns;

    always @(*) begin
        ns = Idle;
        case (ps)
            Idle : ns = (start) ? strt : Idle;
            strt : ns = load;
            load : ns = s1;
            s1 : ns = (opdone) ? s5 : s2;
            s2 : ns = (opdone) ? s6 : s3; 
            s3 : ns = (opdone) ? s7 : s4; 
            s4 : ns = (opdone) ? s8 : s9; 
            s5 : ns = (rst) ? Idle : s5;
            s6 : ns = (rst) ? Idle : s6; 
            s7 : ns = (rst) ? Idle : s7;
            s8 : ns = (rst) ? Idle : s8;
            s9 : ns = s10;
            s10 : ns = (opdone) ? s11 : s10;
            s11 : ns = (stalldone) ? s12 : s11;
            s12 : ns = s1;
        endcase
    end

    always @(ps) begin
        {sel1, sel2, sel3, sel4, sel5, sel6, sel7, ldcnt1, ldcnt2, ld1,
         ld2, ld3, ld4, ld5, ld6, ld7, ld8, ld9, Valid, Ready, Overflow, Error, loadN, sel8, ldshreg, dec} = 26'd0;
        case (ps)
            strt : begin   Ready = 1'b1; loadN = 1'b1;  end

            load : begin ld1 = 1'b1;ldshreg = 1'b1; ldcnt1 = 1'b1; Ready = 1'b1; ld2 = 1'b1; end
            
            s1 : begin  dec = 1'b1; ldshreg = 1'b1;sel1 = 1'b0; ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1 ; Valid = 1'b0; Ready = 1'b1; end
            
            s2 : begin dec = 1'b1; ldshreg = 1'b1; sel1 = 1'b0; sel2 = 1'b1 ; sel3 = 1'b0 ; ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1;
                        ld4 = 1'b1; ld5 = 1'b1;  Valid = 1'b0; Ready = 1'b1; end

            s3 : begin dec = 1'b1; ldshreg = 1'b1; sel1 = 1'b0; sel2 = 1'b1 ; sel3 = 1'b0 ; sel4 = 1'b1 ; sel5 = 1'b0 ; ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1;
                        ld4 = 1'b1; ld5 = 1'b1; ld6 = 1'b1; ld7 = 1'b1;  Valid = 1'b0; Ready = 1'b1;  end

            s4 : begin dec = 1'b1; ldshreg = 1'b1; sel1 = 1'b0; sel2 = 1'b1 ; sel3 = 1'b0 ; sel4 = 1'b1 ; sel5 = 1'b0 ; sel6 = 1'b1 ; sel7 = 1'b0 ;
                        ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1; ld4 = 1'b1; ld5 = 1'b1; ld6 = 1'b1; ld7 = 1'b1; ld8 = 1'b1;
                        ld9 = 1'b1; Valid = 1'b0; Ready = 1'b1; end

            s5 : begin  ldshreg = 1'b1; sel1 = 1'b0; ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1 ; Valid = 1'b1; Ready = 1'b1;  end

            s6 : begin ldshreg = 1'b1; sel1 = 1'b0; sel2 = 1'b1 ; sel3 = 1'b0 ; ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1;
                        ld4 = 1'b1; ld5 = 1'b1;  Valid = 1'b1; Ready = 1'b1; end

            s7 : begin ldshreg = 1'b1; sel1 = 1'b0; sel2 = 1'b1 ; sel3 = 1'b0 ; sel4 = 1'b1 ; sel5 = 1'b0 ; ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1;
                        ld4 = 1'b1; ld5 = 1'b1; ld6 = 1'b1; ld7 = 1'b1;  Valid = 1'b1; Ready = 1'b1;  end

            s8 : begin ldshreg = 1'b1; sel1 = 1'b0; sel2 = 1'b1 ; sel3 = 1'b0 ; sel4 = 1'b1 ; sel5 = 1'b0 ; sel6 = 1'b1 ; sel7 = 1'b0 ;
                        ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1; ld4 = 1'b1; ld5 = 1'b1; ld6 = 1'b1; ld7 = 1'b1; ld8 = 1'b1;
                        ld9 = 1'b1; Valid = 1'b1; Ready = 1'b1; end   
                    
            s9 : begin ld1 = 1'b0;sel8 = 1'b1 ;Ready = 1'b0; Valid = 1'b0; ldshreg = 1'b0; sel1 = 1'b1; end 

            s10 : begin dec = 1'b1; ldshreg = 1'b1; sel1 = 1'b1; sel2 = 1'b1 ; sel3 = 1'b1 ; sel4 = 1'b1 ; sel5 = 1'b1 ; sel6 = 1'b1 ; sel7 = 1'b1 ;
                        ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1; ld4 = 1'b1; ld5 = 1'b1; ld6 = 1'b1; ld7 = 1'b1; ld8 = 1'b1;
                        ld9 = 1'b1; Valid = 1'b0; Ready = 1'b0; ldcnt2 = 1'b1; sel8 = 1'b1; end       

            s11 : begin ldcnt1 = 1'b1; ldshreg = 1'b1; sel1 = 1'b1; sel2 = 1'b1 ; sel3 = 1'b1 ; sel4 = 1'b1 ; sel5 = 1'b1 ; sel6 = 1'b1 ; sel7 = 1'b1 ;
                        ld1 = 1'b1 ; ld2 = 1'b1 ; ld3 = 1'b1; ld4 = 1'b1; ld5 = 1'b1; ld6 = 1'b1; ld7 = 1'b1; ld8 = 1'b1;
                        ld9 = 1'b1; Valid = 1'b1; Ready = 1'b0; sel8 = 1'b1; end  

            s12 : begin ldshreg = 1'b1; Valid = 1'b0; Ready = 1'b0; sel8 = 1'b0; ld1 = 1'b1;
                         ldcnt1 = 1'b1; ld2 = 1'b1;  end  
            default: 
                {sel1, sel2, sel3, sel4, sel5, sel6, sel7, ldcnt1, ldcnt2, ld1,
                    ld2, ld3, ld4, ld5, ld6, ld7, ld8, ld9, Valid, Ready, Overflow, Error, loadN , sel8, ldshreg, dec } = 26'd0;
        endcase
    end
    
    always @(posedge clk) begin
        if(rst)
            ps <= Idle;
        else
            ps <= ns;
    end


endmodule