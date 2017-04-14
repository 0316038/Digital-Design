`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:18 10/16/2015 
// Design Name: 
// Module Name:    LAB3_0316038 
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
module LAB3_0316038(
    input clk,
    input reset,
    input btn_east,
    input btn_west,
    output [7:0] led
    );
	 
reg signed [3:0] num;       // -8~7
reg flag,flag2;				/*控制只+-一次*/ //設兩個-> if btn_east,btn_west同時按  
reg [19:0] delay,delay2;    //delay至少1000000個clk=0.02s  2^20=1048576
assign led=num;             //assign等號左邊要是reg
							//extended 4bit to 8bit
always @(posedge clk)begin
		if(reset)begin
			num<=0;
			flag<=0;
			flag2<=0;
			delay<=0;
			delay2<=0;
		end
		
		else begin
			
			if(btn_west&&flag==0)begin
				delay<=delay+1;
				//flag<=1'b1;
				if(delay==20'b11111111111111111111)begin
					if(num<7) begin num<=num+1; end
					else if(num>=7) begin num<=7; end
					flag<=1;
				end
			end
			if(btn_west==0) begin 
				flag<=0;
				delay<=0;
			end
			if(btn_east&&flag2==0)begin
				delay2<=delay2+1;
				if(delay2==20'b11111111111111111111)begin
					if(num>-8) begin num<=num-1; end
					else if(num<=-8) begin num<=-8; end
					flag2<=1;
				end
			end
			if(btn_east==0) begin
				flag2<=0;
				delay2<=0;
			end
		end
end

endmodule
