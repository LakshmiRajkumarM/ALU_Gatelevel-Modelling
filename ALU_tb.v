`timescale 1ns/1ps
 module simulus;
   reg [3:0]a;
   reg [3:0]b;
   reg [1:0]sel;
   
   wire [3:0]y;
  
    // Instantiate the Unit Under Test (UUT)
  
   ALU uut(
     .y(y),
     .a(a),.sel(sel), 
      .b(b)); 
   initial 
      begin
        $dumpvars(1,simulus);
        // Apply inputs.
        a = 4'b0010;
        b = 4'b0001;
         sel=0; #100;
         sel=1; #100;
         sel=2; #100;
         sel=3; #100;
         sel=0; #100;
       $stop;
        end
   endmodule
       
