`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:43:16 11/16/2015 
// Design Name: 
// Module Name:    lab6 
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
module lab6(
    input clk,
    input reset,
    input button,
    input rx,
    output tx,
    output [7:0] led
    );

localparam [2:0] S_IDLE = 3'b000, S_WAIT = 3'b001, S_SEND = 3'b010, S_INCR = 3'b011, S_BLOCK = 3'b100;
localparam MEM_SIZE = 96;

// declare system variables
wire btn_pressed;
reg [7:0] send_counter;
reg [1:0] Q, Q_next;
reg [7:0] data[0:MEM_SIZE-1];
wire [7:0] da[0:MEM_SIZE-1];

// declare UART signals
wire transmit;
wire received;
wire [7:0] rx_byte;
reg  [7:0] rx_temp;
wire [7:0] tx_byte;
wire is_receiving;
wire is_transmitting;
wire recv_error;
reg  [4:0] index;
reg flag1,flag2;

// declare my own variables
reg [7:0] matrix[0:15];
reg [7:0] matrix_2[0:31];
wire [7:0] outwire;
wire [7:0] outwire1;
wire [7:0] outwire2;
wire [7:0] outwire3;
reg [7:0] temp[0:15];
reg [19:0] sum[0:15];
integer idx;
reg [9:0]sel;

assign led = { 7'b0, btn_pressed };
assign tx_byte = data[send_counter];

debounce btn_db(
    .clk(clk),
    .btn_input(button),
	.reset(reset),
    .btn_output(btn_pressed)
    );

uart uart(
    .clk(clk),
    .rst(reset),
    .rx(rx),
    .tx(tx),
    .transmit(transmit),
    .tx_byte(tx_byte),
    .received(received),
    .rx_byte(rx_byte),
    .is_receiving(is_receiving),
    .is_transmitting(is_transmitting),
    .recv_error(recv_error)
    );


// ------------------------------------------------------------------------
// FSM of the "Matrix multiplexer" transmission controller

always @(posedge clk) begin
  if (reset) Q <= S_IDLE;
  else
  begin  
	flag1<=btn_pressed;
	flag2<=flag1;
	Q <= Q_next;
  end
end


always @(*) begin // FSM next-state logic
  case (Q)
    S_IDLE: // wait for button click
      if (!flag2&&flag1&&sel>=8) Q_next = S_WAIT;
      else Q_next = S_IDLE;
    S_WAIT: // wait for the transmission of current data byte begins
      if (is_transmitting == 1) Q_next = S_SEND;
      else Q_next = S_WAIT;
    S_SEND: // wait for the transmission of current data byte finishes
      if (is_transmitting == 0) Q_next = S_INCR; // transmit next character
      else Q_next = S_SEND;
    S_INCR:
      if (tx_byte == 8'h0) Q_next = S_IDLE; // string transmission ends
      else Q_next = S_WAIT;
  endcase
end

// FSM output logics
assign transmit = (Q == S_WAIT)? 1 : 0;

// FSM-controlled send_counter incrementing data path
always @(posedge clk) begin
  if (reset || (Q == S_IDLE))
    send_counter <= 0;
  else if (Q == S_INCR)
    send_counter <= send_counter + 1;
end

// End of the FSM "Matrix multiplexer" transmission controller
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// The following logic stores the UART input in a temporary buffer
// You must replace this code by your own code to store multiple
// bytes of data.
//
always @(posedge clk) begin
	if (reset)
	begin
		rx_temp = 8'b0;
		index <= 5'd0;
		sel <= 10'b0;
		
	end
	else if (received)
	begin

		if(index < 16) //insert matrix_1
			begin
			matrix[index]<=rx_byte;
			index<=index+1;
			end
		else if (index > 15 && index <32)
			begin
			matrix_2[index]<=rx_byte;
			index<=index+1;
			end
	end

	else if(sel==0)
	begin
		temp[0] <= outwire*matrix_2[16];
		temp[1] <= outwire1*matrix_2[20];
		temp[2] <= outwire2*matrix_2[24];
		temp[3] <= outwire3*matrix_2[28];
	
		temp[4] <= outwire*matrix_2[17];
		temp[5] <= outwire1*matrix_2[21];
		temp[6] <= outwire2*matrix_2[25];
		temp[7] <= outwire3*matrix_2[29];
		
		temp[8] <= outwire*matrix_2[18];
		temp[9] <= outwire1*matrix_2[22];
		temp[10] <= outwire2*matrix_2[26];
		temp[11] <= outwire3*matrix_2[30];
		
		temp[12] <= outwire*matrix_2[19];
		temp[13] <= outwire1*matrix_2[23];
		temp[14] <= outwire2*matrix_2[27];
		temp[15] <= outwire3*matrix_2[31];
		
		sel <= sel +1;
	end
	else if(sel==1)
	begin
		
		sum[0] = temp[0]+temp[1]+temp[2]+temp[3];
		sum[1] = temp[4]+temp[5]+temp[6]+temp[7];
		sum[2] = temp[8]+temp[9]+temp[10]+temp[11];
		sum[3] = temp[12]+temp[13]+temp[14]+temp[15];
		
		sel <= sel +1;
	end
	else if (sel==2)
	begin
		temp[0] <= outwire*matrix_2[16];
		temp[1] <= outwire1*matrix_2[20];
		temp[2] <= outwire2*matrix_2[24];
		temp[3] <= outwire3*matrix_2[28];
	
		temp[4] <= outwire*matrix_2[17];
		temp[5] <= outwire1*matrix_2[21];
		temp[6] <= outwire2*matrix_2[25];
		temp[7] <= outwire3*matrix_2[29];
		
		temp[8] <= outwire*matrix_2[18];
		temp[9] <= outwire1*matrix_2[22];
		temp[10] <= outwire2*matrix_2[26];
		temp[11] <= outwire3*matrix_2[30];
		
		temp[12] <= outwire*matrix_2[19];
		temp[13] <= outwire1*matrix_2[23];
		temp[14] <= outwire2*matrix_2[27];
		temp[15] <= outwire3*matrix_2[31];
		
		sel <= sel +1;	
	end
	else if (sel == 3)
	begin
		sum[4] = temp[0]+temp[1]+temp[2]+temp[3];
		sum[5] = temp[4]+temp[5]+temp[6]+temp[7];
		sum[6] = temp[8]+temp[9]+temp[10]+temp[11];
		sum[7] = temp[12]+temp[13]+temp[14]+temp[15];
		
		sel <= sel +1;
	end
	
	else if (sel == 4)
	begin
		temp[0] <= outwire*matrix_2[16];
		temp[1] <= outwire1*matrix_2[20];
		temp[2] <= outwire2*matrix_2[24];
		temp[3] <= outwire3*matrix_2[28];
	
		temp[4] <= outwire*matrix_2[17];
		temp[5] <= outwire1*matrix_2[21];
		temp[6] <= outwire2*matrix_2[25];
		temp[7] <= outwire3*matrix_2[29];
		
		temp[8] <= outwire*matrix_2[18];
		temp[9] <= outwire1*matrix_2[22];
		temp[10] <= outwire2*matrix_2[26];
		temp[11] <= outwire3*matrix_2[30];
		
		temp[12] <= outwire*matrix_2[19];
		temp[13] <= outwire1*matrix_2[23];
		temp[14] <= outwire2*matrix_2[27];
		temp[15] <= outwire3*matrix_2[31];
		
		sel <= sel +1;		
	end
	else if (sel == 5)
	begin
		sum[8] = temp[0]+temp[1]+temp[2]+temp[3];
		sum[9] = temp[4]+temp[5]+temp[6]+temp[7];
		sum[10] = temp[8]+temp[9]+temp[10]+temp[11];
		sum[11] = temp[12]+temp[13]+temp[14]+temp[15];
		
		sel <= sel +1;
	end
	else if (sel==6)
	begin
		temp[0] <= outwire*matrix_2[16];
		temp[1] <= outwire1*matrix_2[20];
		temp[2] <= outwire2*matrix_2[24];
		temp[3] <= outwire3*matrix_2[28];
	
		temp[4] <= outwire*matrix_2[17];
		temp[5] <= outwire1*matrix_2[21];
		temp[6] <= outwire2*matrix_2[25];
		temp[7] <= outwire3*matrix_2[29];
		
		temp[8] <= outwire*matrix_2[18];
		temp[9] <= outwire1*matrix_2[22];
		temp[10] <= outwire2*matrix_2[26];
		temp[11] <= outwire3*matrix_2[30];
		
		temp[12] <= outwire*matrix_2[19];
		temp[13] <= outwire1*matrix_2[23];
		temp[14] <= outwire2*matrix_2[27];
		temp[15] <= outwire3*matrix_2[31];
		
		sel <= sel +1;	
	end
	else if (sel == 7)
	begin
		sum[12] = temp[0]+temp[1]+temp[2]+temp[3];
		sum[13] = temp[4]+temp[5]+temp[6]+temp[7];
		sum[14] = temp[8]+temp[9]+temp[10]+temp[11];
		sum[15] = temp[12]+temp[13]+temp[14]+temp[15];
		
		sel <= sel +1;
	end
	
end

multiplexer lab6(.fri({matrix[12],matrix[8],matrix[4],matrix[0]}),.select(sel),.day(outwire));
multiplexer lab5(.fri({matrix[13],matrix[9],matrix[5],matrix[1]}),.select(sel),.day(outwire1));
multiplexer lab4(.fri({matrix[14],matrix[10],matrix[6],matrix[2]}),.select(sel),.day(outwire2));
multiplexer lab3(.fri({matrix[15],matrix[11],matrix[7],matrix[3]}),.select(sel),.day(outwire3));

asciiQQ aa(.a(sum[0]),.b(da[4]),.c(da[3]),.d(da[2]),.e(da[1]),.f(da[0]));
asciiQQ bb(.a(sum[1]),.b(da[10]),.c(da[9]),.d(da[8]),.e(da[7]),.f(da[6]));
asciiQQ cc(.a(sum[2]),.b(da[16]),.c(da[15]),.d(da[14]),.e(da[13]),.f(da[12]));
asciiQQ dd(.a(sum[3]),.b(da[22]),.c(da[21]),.d(da[20]),.e(da[19]),.f(da[18]));
asciiQQ ee(.a(sum[4]),.b(da[28]),.c(da[27]),.d(da[26]),.e(da[25]),.f(da[24]));
asciiQQ ff(.a(sum[5]),.b(da[34]),.c(da[33]),.d(da[32]),.e(da[31]),.f(da[30]));
asciiQQ gg(.a(sum[6]),.b(da[40]),.c(da[39]),.d(da[38]),.e(da[37]),.f(da[36]));
asciiQQ hh(.a(sum[7]),.b(da[46]),.c(da[45]),.d(da[44]),.e(da[43]),.f(da[42]));
asciiQQ ii(.a(sum[8]),.b(da[52]),.c(da[51]),.d(da[50]),.e(da[49]),.f(da[48]));
asciiQQ jj(.a(sum[9]),.b(da[58]),.c(da[57]),.d(da[56]),.e(da[55]),.f(da[54]));
asciiQQ kk(.a(sum[10]),.b(da[64]),.c(da[63]),.d(da[62]),.e(da[61]),.f(da[60]));
asciiQQ ll(.a(sum[11]),.b(da[70]),.c(da[69]),.d(da[68]),.e(da[67]),.f(da[66]));
asciiQQ mm(.a(sum[12]),.b(da[76]),.c(da[75]),.d(da[74]),.e(da[73]),.f(da[72]));
asciiQQ nn(.a(sum[13]),.b(da[82]),.c(da[81]),.d(da[80]),.e(da[79]),.f(da[78]));
asciiQQ oo(.a(sum[14]),.b(da[88]),.c(da[87]),.d(da[86]),.e(da[85]),.f(da[84]));
asciiQQ pp(.a(sum[15]),.b(da[94]),.c(da[93]),.d(da[92]),.e(da[91]),.f(da[90]));

integer i;
always
begin

	for(i = 0; i < 96;i = i+1)
	begin
	if(i==5||i==11||i==17||i==29||i==35||i==41||i==53||i==59||i==65||i==77||i==83||i==89)  data[i]=32;
	else if(i==23||i==47||i==71)data[i]=13;
	else	data[i]=da[i];
	end
end

// ------------------------------------------------------------------------
 
endmodule

module multiplexer (input [31:0]fri,input [3:0]select,output [7:0]day);
	
	assign day = (select==0)?fri[7:0]:(select==2)?fri[15:8]:(select==4)?fri[23:16]:(select==6)?fri[31:24]:0;

endmodule

module asciiQQ  (input [19:0]a,output [7:0]b,output [7:0]c,output [7:0]d,output [7:0]e,output [7:0]f);

	assign b = (a[3:0]<=9)? (a[3:0]+48):(a[3:0]+55);
	assign c = (a[7:4]<=9)? (a[7:4]+48):(a[7:4]+55);
	assign d = (a[11:8]<=9)? (a[11:8]+48):(a[11:8]+55);
	assign e = (a[15:12]<=9)? (a[15:12]+48):(a[15:12]+55);
	assign f = (a[19:16]<=9)? (a[19:16]+48):(a[19:16]+55);

endmodule 

