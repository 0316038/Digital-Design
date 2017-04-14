`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:35 11/24/2015 
// Design Name: 
// Module Name:    shift_0316038 
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
module shift_0316038(input clk, input rst, output [7:0] led);
	wire [7:0] in0, in1, in2, in3, in4, in5, in6, in7;
   reg [7:0] data0[0:31];
	reg [7:0] data1[0:31];
	reg [7:0] data2[0:31];
	reg [7:0] data3[0:31];
	reg [7:0] data4[0:31];
	reg [7:0] data5[0:31];
	reg [7:0] data6[0:31];
	reg [7:0] data7[0:31];
   wire data_available;
	
	integer shift;
	reg [6:0]count;
	wire [31:0] temp_sum ; 
	reg [31:0] reg_sum;
	reg flag;
	
	assign led[0]=reg_sum[0];
	assign led[1]=reg_sum[1];
	assign led[2]=reg_sum[2];
	assign led[3]=reg_sum[3];
	assign led[4]=reg_sum[4];
	assign led[5]=reg_sum[5];
	assign led[6]=reg_sum[6];
	assign led[7]=reg_sum[7];
   assign data_available = flag; // you must modify this in your code
	
	reg [7:0] line0,line1,line2,line3,line4,line5,line6,line7; 
	//§âregªº­Èµ¹wire
	assign in0=line0;
	assign in1=line1;
	assign in2=line2;
	assign in3=line3;
	assign in4=line4;
	assign in5=line5;
	assign in6=line6;
	assign in7=line7;
	
	//adder tree
	adder_tree add (
		.clk(clk),
		.rst(rst),
		.in_valid(data_available),
		.in0(in0),
		.in1(in1),
		.in2(in2),
		.in3(in3),
		.in4(in4),
		.in5(in5),
		.in6(in6),
		.in7(in7),
		.sum(temp_sum)
	);

  always @(posedge clk,posedge rst)
    if (rst) begin
      `include "data.dat"
		 //Âk¹s
		 line0<=0;
		 line1<=0;
		 line2<=0;
		 line3<=0;
		 line4<=0;
		 line5<=0;
		 line6<=0;
		 line7<=0;
		 count<=0;
		 flag<=0;
		 reg_sum<=0;
		 
    end
	 else begin
		if(count<=31)begin
			line0<=data0[31];
			line1<=data1[31];
			line2<=data2[31];
			line3<=data3[31];
			line4<=data4[31];
			line5<=data5[31];
			line6<=data6[31];
			line7<=data7[31];
			//shift
			for(shift=31;shift>0;shift=shift-1)begin
				data0[shift]<=data0[shift-1];
				data1[shift]<=data1[shift-1];
				data2[shift]<=data2[shift-1];
				data3[shift]<=data3[shift-1];
				data4[shift]<=data4[shift-1];
				data5[shift]<=data5[shift-1];
				data6[shift]<=data6[shift-1];
				data7[shift]<=data7[shift-1];
			end
			count <= count+1;
			flag<=1;
			//Normalizer
		end
		else if(count==33)begin
			reg_sum <= (temp_sum+128)>>8;
		end
		else begin
			count<=count+1;
			flag<=0;
		end
	 end

endmodule
