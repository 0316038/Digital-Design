`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:47 11/22/2015 
// Design Name: 
// Module Name:    lcd 
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
module lab9(
    input clk,
    input reset,
    input  button,
    output LCD_E,
    output LCD_RS,
    output LCD_RW,
    output [3:0]LCD_D
    );
	 
    wire btn_level, btn_pressed;
    reg prev_btn_level;
    reg [127:0] row_A, row_B;
    
	 reg [2:0] Q,Q_next;
	 reg [1:0] P,P_next;
	 reg [9:0] idx,jdx,init_counter;
	 reg reversed;
	 reg [31:0] acc;
	 reg [7:0] print_counter;
	 reg [9:0] print_addr;
	 
	 parameter target=35000000;
	 parameter S_INIT=3'b000,S_WAIT=3'b001,S_COUNT=3'b010,S_INCR=3'b011,S_OK=3'b100;
	 parameter T_INIT=2'b00,T_PRINT=2'b01,T_WAIT=2'b10,T_CLEAR=2'b11;
	 wire [7:0] A,B,C,D,E;
	 reg run;
	//declare a SRAM memory block
	reg sram[1021:0];
	wire we, en;
	reg data_out;
	reg data_in;
	wire [9:0] sram_addr;
	
	assign sram_addr=(Q==S_INIT)?init_counter[9:0]:((P==T_INIT)?jdx[9:0]:print_addr[9:0]);
	reg invalid;
	assign we=invalid;   // Write data into SRAM when invalid is high.
	assign en=1;
	
	assign A=(print_counter[7:4]>9)?print_counter[7:4]+55:print_counter[7:4]+48;
	assign B=(print_counter[3:0]>9)?print_counter[3:0]+55:print_counter[3:0]+48;
	assign C=print_addr[9:8]+48;
	assign D=(print_addr[7:4]>9)?print_addr[7:4]+55:print_addr[7:4]+48;
	assign E=(print_addr[3:0]>9)?print_addr[3:0]+55:print_addr[3:0]+48;
	
    LCD_module lcd0( 
      .clk(clk),
      .reset(reset),
      .row_A(row_A),
      .row_B(row_B),
      .LCD_E(LCD_E),
      .LCD_RS(LCD_RS),
      .LCD_RW(LCD_RW),
      .LCD_D(LCD_D)
    );
    
    debounce btn_db0(
      .clk(clk),
      .btn_input(button),
      .btn_output(btn_level)
   );
///SRAM/////////////////////////////////////////////////////////////////////////////    

	
	always @(posedge clk) begin // Write data into the SRAM block
		if (en && we) begin
			sram[sram_addr] <= data_in;
		end
	end
	always @(posedge clk) begin // Read data from the SRAM block
		if (en && we) // If data is being written into SRAM,
			data_out <= data_in; // forward the data to the read port
		else
			data_out <= sram[sram_addr]; // Send data to the read port
	end
/////////////////////////////////////////////////////////////////////////////////	 
   always @(posedge clk) begin
      if (reset)
        prev_btn_level <= 1;
      else
        prev_btn_level <= btn_level;
    end

    assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1 : 0;

//FSM/////////////////////////////////////////////////////////////////////////////

always@(posedge clk) begin
  if (btn_input == 0) begin
    counter <= 0;
    pressed <= 0;
  end else begin
    counter <= counter + 1;
    pressed <= (debounced_btn_state == 1)? 1 : 0;
  end
end
///FSM next-state logic//////////////////////////////////////////////////////////////
always@(*)begin
	case(Q)
		S_INIT:
			if(init_counter<1021)Q_next<=S_INIT;
			else Q_next<=S_WAIT;
		S_WAIT:
			if(data_out==0) Q_next<=S_INCR;
			else Q_next<=S_COUNT;
		S_COUNT:
			if(jdx<1021) Q_next<=S_COUNT;
			else Q_next<=S_INCR;
		S_INCR:
			if(idx!=1021)Q_next<=S_WAIT;
			else Q_next<=S_OK;
		S_OK:
			if(!reset)Q_next<=S_OK;
			else Q_next<=S_INIT;
	endcase
end
////Sieve Algorithm///////////////////////////////////////////////////////////////////////////////

always@(posedge clk)begin
	if(reset)begin
		invalid<=1;
		init_counter<=0;
	end
	else if(Q==S_INIT)begin
		data_in<=1;
		idx<=2;
		if(init_counter!=1021)begin
			init_counter<=init_counter+1;
		end
		else begin
			invalid<=0;
		end
	end
	else if(Q==S_WAIT)begin
		jdx = idx+idx;
		if(data_out!=0)invalid<=1;
	end
	else if(Q==S_COUNT)begin
		data_in<=0;
		jdx = jdx+idx;
		if(jdx==1021)invalid<=0;
	end
	else if(Q==S_INCR)begin
		idx<=idx+1;
	end
end
///////////////////////////////////////////////////////////////////////////
always @(posedge clk)begin
	if(reset)acc<=0;
	else if(Q==S_OK)acc<=acc+1;
	else if(P==T_CLEAR) acc<=0;
end
////////////////////////////////////////////////////////////////////////////
always@(posedge clk)begin
	if(reset) reversed=0;
	else if(btn_pressed) reversed=!reversed;
end
////FSM next-state logic/////////////////////////////////////////////////////
always@(*)begin
	case(P)
		T_INIT:
			if(data_out==0) P_next=T_INIT;
			else P_next=T_PRINT;
		T_PRINT:
			if(data_out==0) P_next=T_PRINT;
			else P_next=T_WAIT;
		T_WAIT:
			if(acc<target)P_next=T_WAIT;
			else P_next=T_CLEAR;
		T_CLEAR:
			P_next=T_PRINT;
	endcase
end
always@(posedge clk) begin
  // wait until the button is pressed continuously for 20 msec
  if (counter == DEBOUNCE_PERIOD && pressed == 0)
    debounced_btn_state <= 1;
  else
    debounced_btn_state <= (btn_input == 0)? 0 : btn_output;
end

////////////////////////////////////////////////////////////////////////////////////
always@(posedge clk)begin
	if(reset)
		run<=0;
	if(run==35000000)begin
		run<=0;
	end
	else begin
		run<=run+1;
	end
end
////////////////////////////////////////////////////////////////////////////////////
	always @(posedge clk)begin
	  if(reset)begin
	    print_addr<=0;
		 print_counter<=1;
		 row_A<=128'h0;
		 row_B<=128'h0;
	  end
	  if(P==T_INIT)begin
	    row_A<=128'h0;
	    if(data_out!=0)print_addr<=print_addr+1;
		 else begin
			if(run==target)begin
		    row_B <= {56'h5072696D652023,A,B,32'h20697320,C,D,E};
			print_addr<=print_addr+1;
			print_counter<=print_counter+1;
			end
		 end
	  end
	   if(P==T_PRINT)begin
	    if(data_out!=0)print_addr<=(reversed)?print_addr-1:print_addr+1;
		 else begin
			if(run==target)begin
		    row_A <= row_B;
		    row_B <= {56'h5072696D652023,A,B,32'h20697320,C,D,E};
			print_addr<=(reversed)?print_addr-1:print_addr+1;
			print_counter<=(reversed)?print_counter-1:print_counter+1;
			end
		 end
	  end
	end

endmodule
