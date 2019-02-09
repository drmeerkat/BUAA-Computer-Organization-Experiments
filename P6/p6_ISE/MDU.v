`timescale 1ns / 1ps
`define mult (ctrl == 4'b0000)
`define multu (ctrl == 4'b0001)
`define div (ctrl == 4'b0010)
`define divu (ctrl == 4'b0011)
`define marotr (ctrl == 4'b1000)
`define mfhi (MDU_ctrl == 4'b0100)
`define mflo (MDU_ctrl == 4'b0101)
`define mthi (MDU_ctrl == 4'b0110)
`define mtlo (MDU_ctrl == 4'b0111)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:03:54 12/15/2016 
// Design Name: 
// Module Name:    MDU 
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
module MDU(
    input [31:0] A,
    input [31:0] B,
	input [4:0] sa,
	input Reset,
	input Clk,
	input [3:0] MDU_ctrl,
	input start,//只要E级指令是4条即start
	output busy,
    output [31:0] HI,
    output [31:0] LO
    );
	
	wire [63:0] temp1,temp2,temp3,temp4,temp5;
	reg  [31:0] hi, lo, a, b, s;
	wire [31:0] temp5_hi, temp5_lo;
	reg [3:0] count, ctrl; //16
	reg _busy;
	
	assign {HI,LO} = {hi,lo};
	assign busy = _busy;
	
	assign temp1 = $signed(a)*$signed(b);
	assign temp2 = a*b;
	assign temp3 = {{$signed(a)%$signed(b)},{$signed(a)/$signed(b)}};
	assign temp4 = {(a%b),(a/b)};
	assign temp5_hi = {temp1[63:32],temp1[63:32]} >> s; 
	assign temp5_lo = {temp1[31:0],temp1[31:0]} >> s; 
	assign temp5 = {temp5_hi, temp5_lo}+{HI,LO};
	//sa? {temp1[31+sa:32],temp1[63:32+sa],temp1[sa-1:0],temp1[31:sa]}:temp1;
	
	always @ (posedge Clk)begin
		if (Reset)begin
			{hi,lo} <= 0;
			_busy <= 0;
			count <= 0;
		end
		
		else if (start)begin
			ctrl <= MDU_ctrl;
			_busy <= 1'b1;
			a <= A;
			b <= B;
			s <= sa;
		end
		
		else if (_busy) begin
			count <= count+1;
			if (((`mult||`multu||`marotr)&&count == 3)||((`div||`divu)&&count == 8))begin
				count <= 0;
				_busy <= 0;
				{hi,lo} <= `mult?   temp1:
						   `multu?  temp2:
						   `div?    temp3:
						   `divu?   temp4:
						   `marotr? temp5:
						   64'h66666666_66666666;
			end
		end
		
		else if (`mthi)
			hi <= A;
		else if (`mtlo)
			lo <= A;
	end

endmodule
