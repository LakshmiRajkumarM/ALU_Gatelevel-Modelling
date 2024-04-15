module ALU(input [3:0]a,
           input [3:0]b,
           input [1:0]sel,
           output [3:0]y);

  wire [3:0]sum;
  wire [3:0]diff;
  wire [3:0]AND;
  wire [3:0]OR;
  
  fulladd ALUadd(sum,c_out,a,b,c_in);
  fullsubtractor ALUdiff(diff,b_out,a,b,bin);
  and_gate ALUand(AND,a,b);
  or_gate ALUor(OR,a,b);
  mux4to1 ALUmux(sum,diff,AND,OR,sel,y);



  module fulladd(sum, c_out, a, b, c_in);

  output sum, c_out;
  input a, b, c_in;
  assign c_in=0;

  wire s1, c1, c2;

  xor (s1, a, b);
  and (c1, a, b);
  xor (sum, s1, c_in);
  and (c2, s1, c_in);
  xor (c_out, c2, c1);
endmodule



module halfadder4bit(sum, c_out, a, b, c_in);

output [3:0] sum;
output c_out;
input[3:0] a, b;
input c_in;
  assign c_in=0;

wire c1, c2, c3;

fulladd fa0(sum[0], c1, a[0], b[0], c_in);
fulladd fa1(sum[1], c2, a[1], b[1], c1);
fulladd fa2(sum[2], c3, a[2], b[2], c2);
fulladd fa3(sum[3], c_out, a[3], b[3], c3);
endmodule


module fullsubtractor(diff,b_out,a,b,bin);
output diff,b_out;
input a,b,bin;
  assign bin=0;
wire c,x,y,z;
not(c,a);
xor(diff,a,b,bin);
or(x,b,bin);
and(y,b,bin);
and(z,x,c);
or(b_out,z,y);
endmodule
module subtractor4bit(diff,bout,a,b,bin);
output [3:0]diff;
output bout;
input [3:0]a,b;
input bin;
  assign bin=0;
wire bo1,bo2,bo3;

  
fullsubtractor fs0(diff[0],bo1,a[0],b[0],bin);
fullsubtractor fs1(diff[1],bo2,a[1],b[1],bo1);
fullsubtractor fs2(diff[2],bo3,a[2],b[2],bo2);
fullsubtractor fs3(diff[3],bout,a[3],b[3],bo3);
endmodule


module and_gate(AND,a,b);
  
  input [3:0]a;
  input [3:0]b;
  output [3:0]AND;
  
  and(AND,a,b);
endmodule

module or_gate(output [3:0]OR, input [3:0]a,input [3:0]b);
  or(OR,a,b);

endmodule
  
  module mux4to1(input [3:0]sum,
               input [3:0]diff,
               input [3:0]AND,
               input [3:0]OR,
               input [1:0]sel,
                 output reg [3:0]y);
    always @ (sum or diff or AND or OR or sel)
      begin
        case(sel)
      2'b00: y<=sum;
      2'b01: y<=diff;
      2'b10: y<=AND;
      2'b11: y<=OR;
    endcase
  end
  endmodule

endmodule






