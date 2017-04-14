`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:50 09/23/2015 
// Design Name: 
// Module Name:    Subtractor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Subtractor(A, B,/*C,*/ Cin, S, Cout, Cout1);
input [7:0] A, B;
input Cin;
output[8:0] S;
output Cout;
output Cout1;
wire [8:0] C;
wire [7:0] t;
wire [7:0] u;

B_2C C1(.B(B[0]), .C(C[0]), .Cin(1'b0),     .Cout(u[0]));
B_2C C2(.B(B[1]), .C(C[1]), .Cin(u[0]),  .Cout(u[1]));
B_2C C3(.B(B[2]), .C(C[2]), .Cin(u[1]),  .Cout(u[2]));
B_2C C4(.B(B[3]), .C(C[3]), .Cin(u[2]),  .Cout(u[3]));
B_2C C5(.B(B[4]), .C(C[4]), .Cin(u[3]),  .Cout(u[4]));
B_2C C6(.B(B[5]), .C(C[5]), .Cin(u[4]),  .Cout(u[5]));
B_2C C7(.B(B[6]), .C(C[6]), .Cin(u[5]),  .Cout(u[6]));
B_2C C8(.B(B[7]), .C(C[7]), .Cin(u[6]),  .Cout(u[7]));
B_2C C9(.B(B[7]), .C(C[8]), .Cin(u[7]),  .Cout(Cout1));

FA_1bit FA0(.A(A[0]), .B(C[0]), .Cin(0),    .S(S[0]), .Cout(t[0]));
FA_1bit FA1(.A(A[1]), .B(C[1]), .Cin(t[0]), .S(S[1]), .Cout(t[1]));
FA_1bit FA2(.A(A[2]), .B(C[2]), .Cin(t[1]), .S(S[2]), .Cout(t[2]));
FA_1bit FA3(.A(A[3]), .B(C[3]), .Cin(t[2]), .S(S[3]), .Cout(t[3]));
FA_1bit FA4(.A(A[4]), .B(C[4]), .Cin(t[3]), .S(S[4]), .Cout(t[4]));
FA_1bit FA5(.A(A[5]), .B(C[5]), .Cin(t[4]), .S(S[5]), .Cout(t[5]));
FA_1bit FA6(.A(A[6]), .B(C[6]), .Cin(t[5]), .S(S[6]), .Cout(t[6]));
FA_1bit FA7(.A(A[7]), .B(C[7]), .Cin(t[6]), .S(S[7]), .Cout(t[7]));
FA_1bit FA8(.A(A[7]), .B(C[8]), .Cin(t[7]), .S(S[8]), .Cout(Cout));
 
 
endmodule

// ----------------- A 1-bit full adder ----------------------------- 
module FA_1bit(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
assign S = Cin ^ A ^ B;
assign Cout = (A & B) | (Cin & B) | (Cin & A);
endmodule
// --------------complement------------------------------------------
module B_2C(B,C,Cin,Cout);
input B,Cin;
output C,Cout;
assign C=B^Cin;
assign Cout=(B^Cin)|Cin;
endmodule




