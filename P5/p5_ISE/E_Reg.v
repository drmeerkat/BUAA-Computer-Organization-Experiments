`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:09 12/01/2016 
// Design Name: 
// Module Name:    E_Reg 
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
module E_Reg(
    input [31:0] IR,
    input [31:0] PC4,
    input [31:0] RS,
    input [31:0] RT,
    input [31:0] SH,
    input [31:0] EXT,
	input Clk,
	input Clr,
	input Reset,
    output [31:0] IR_E,
    output [31:0] PC4_E,
    output [31:0] RS_E,
    output [31:0] RT_E,
    output [31:0] SH_E,
    output [31:0] EXT_E
    );

    reg [31:0] _IR, _PC4, _RS, _RT, _SH, _EXT;
	assign IR_E = _IR;
	assign PC4_E = _PC4;
	assign RS_E = _RS;
	assign RT_E = _RT;
	assign SH_E = _SH;
	assign EXT_E = _EXT;
	
	always @ (posedge Clk)begin
		if(Clr||Reset)begin
			_IR <= 0;
			_PC4 <= 0;
			_RS <= 0;
			_RT <= 0;
			_SH <= 0;
			_EXT <= 0;
		end
		else begin
			_IR <= IR;
			_PC4 <= PC4;
			_RS <= RS;
			_RT <= RT;
			_SH <= SH;
			_EXT <= EXT;
		end
	end

endmodule
