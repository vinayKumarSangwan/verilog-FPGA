// 2x4 Decoder with dataflow modelling, 
// testbench included in the same file
// reference: J. Bhasker book

`timescale 1ns/1ns;

module decoder2x4_df (Z, A, B);
out [3:0] Z;
in A, B;
wire Abar, Bbar;

assign #1 Abar = ~A;
assign #1 Bbar = ~B;
assign #2 Z[0] = Abar & Bbar;
assign #2 Z[1] = Abar & B;
assign #2 Z[2] = A & Bbar;
assign #2 Z[3] = A & B;

endmodule;

module Top;             // Testbench, module defined without portlist
reg TA, TB;
wire [3:0] TZ;

decoder2x4_df DEC1 (.Z(TZ), .A(TA), .B(TB));      // decoder instant. with named association

initial
  begin: WAY1               // WAY1 label needed because of local declaration
  reg [2:0] P1;
  
  for (P1 = 0; P1 < 4; P1=P1+1)     // generate waveform on TA and TB: 00>>01>>10>>11
    begin
    {TA, TB} = P1;          // assignment to concatenated target
    #3 $display ("at time=%t, A,B = %b%b :::: Z = %b", $time, TA, TB, TZ);
    end
   end
endmodule
