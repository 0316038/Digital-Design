`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:34 11/26/2015 
// Design Name: 
// Module Name:    lab08 
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
module lab8(
	 input clk,
	 input reset,
    input ROT_A,
    input ROT_B,
	 output reg[7:0]led
    );
	
wire rot_event,rot_right;
integer bright;
integer j;

Rotation_direction r1(
    .CLK(clk),
    .ROT_A(ROT_A),
    .ROT_B(ROT_B),
    .rotary_event(rot_event),
    .rotary_right(rot_right)
    );
	
always @(posedge clk)begin
	if(reset)begin
		bright<=0;
	end
	else begin
		if(rot_event==1)begin
			if(rot_right==1)begin       //right:increase brightness
				if(bright<100) bright<=bright+1;
			end
			else if(rot_right==0)begin  //left:decrease brightness
				if(bright>0) bright<=bright-1;
			end
		end
	end
end

always @(posedge clk)begin
	if(reset)begin
		led<=8'b00000000;
		j<=0;
	end
	else begin
		if(j<=100)begin
			j<=j+1;
		end
		else begin
			j<=0;
		end
		
		if(j>=0 && j<=bright)begin
			led<=8'b11111111;
		end
		else begin
			led<=8'b00000000;
		end
	end
end
endmodule
