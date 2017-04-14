`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:18:55 10/07/2015 
// Design Name: 
// Module Name:    POSTFIX 
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
module POSTFIX(
		input CLK,
		input RESET,
		input OP_MODE, 
		input IN_VALID,
		input [3:0] IN,
		output reg [15:0] OUT,
		output reg OUT_VALID
    );
	reg flag=1'b0;
	reg [3:0] SIZE =0;
	reg [15:0] stack [7:0];
	always @(posedge CLK ,negedge RESET)
	begin
		if(!RESET) begin
			OUT_VALID <= 0;
			OUT <= 16'b0;
			SIZE <= 0;
			end
		else begin
			if(IN_VALID) begin
				flag <= 1'b1;
				if(OP_MODE==1'b1) begin
					if(IN==4'b0001) stack[SIZE-2] <= stack[SIZE-2]+stack[SIZE-1];
					else if(IN==4'b0010) stack[SIZE-2] <= stack[SIZE-2]-stack[SIZE-1];
					else if(IN==4'b0100) stack[SIZE-2] <= stack[SIZE-2]*stack[SIZE-1];
				SIZE<=SIZE-1;
				end
				else begin
					stack[SIZE] <= IN;
					SIZE<=SIZE+1;
				end	
			end
			else if(IN_VALID==1'b0 && flag==1)begin
				OUT_VALID <= 1'b1;
				OUT <= stack[0];
				flag <= 1'b0;
			end
			else if(OUT_VALID==1'b1) begin
				OUT_VALID <= 0;
				OUT <= 16'b0;
				SIZE <= 0;
			end
		end
	end//end always
	
	
	
endmodule
