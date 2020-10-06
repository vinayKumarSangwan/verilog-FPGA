// This file has notes on syntax of verilog (mainly from J. Bhasker book) 
// Verilog is written in C

`timescale 1ns/100ps    // one unit time = 1ns, with 0.1ns precision (min time)

module TOP;             // module may have an empty port list

parameter size = 4;     // parameter datatype declaration
                        // all declarations must appear before their use
input [size:1] FA, FB;  // A and B both declared as 4 bit nets


FA_struct                       // instantiation of FA_struct UDP (user defined primitive)  
   FAd1 (.A(FA[1], .B(FB[1])), // instantiation using .port_name(wire_name) linking
                               // notice the comma ending the above statement
   FAd2 (FA[2], FB[2]);        // using positional association

initial                 // behavioural (sequential) modelling, can only assign reg datatype here
  begin: LABEL_NAME     // ': Label_name' are needed only when a local declaration is used i.e. decl inside initial
    reg [3:0] P1;
    for (P1 = 0; P1 < 8; P1 = P1+1)   // decimal no assign to 4 bit P1
      begin
      {A, B, C} = P1;   // Assignment to Concatenated target, 3 bits of P1 from right assignemed to A, B, C (C = LSB)
      # 5 $display ("ABC = %d%d%d", A, B, C, "time = %t", $time);
                        // $ is for system tasks
      end
  end
     
initial                 // there can be multiple initial or always blocks
                        // they all will be executed at 0 time concurrently
     $monitor ("time is = %t :::: A = %d", $time, A);
                        // no begin-end needed because only one statement is there
                        // $monitor executed if event occurs on variables in arguement list
                        
                 
