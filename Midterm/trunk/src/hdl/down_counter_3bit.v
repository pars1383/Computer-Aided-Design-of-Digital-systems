module down_counter_3bit(
   clk,
   rst,
   data,
   ldcnt,
   dec,    //load signal
   carry
);

 //------------Input Ports-------------- 
  input clk, rst , ldcnt, dec;
  input [2:0] data;
 //----------Output Ports--------------
  output carry;
 
  reg [2:0] out;
  //-------------Code Starts Here-------
  always @(posedge clk)
  begin
    if (rst)// active high reset
      out <= 3'b0;
    else if (ldcnt) // Load data
      out <= data;
    else if (dec) 
      out <= out - 1'b1;

    
    

  end
  
  assign carry = (out == 3'b000) ? 1'b1 : 1'b0;
endmodule