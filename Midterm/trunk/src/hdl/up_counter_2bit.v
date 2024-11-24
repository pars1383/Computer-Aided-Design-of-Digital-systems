module up_counter_2bit(
   clk,
   rst,
   ldcnt,    //load signal
   data,
   carry
);

  //------------Input Ports-------------- 
  input clk, rst , ldcnt;
  input [1:0] data;
 //----------Output Ports--------------
  output carry;

  reg [1:0] out;
 
  //-------------Code Starts Here-------
  always @(posedge clk)
  begin
    if (rst)// active high reset
      out <= 2'b0;
    else if (ldcnt)   // Load data
      out <= data;
    else
      out <= out + 1'b1;
   
      
  end
  
  assign carry = (out == 2'b11) ? 1'b1 : 1'b0;
endmodule