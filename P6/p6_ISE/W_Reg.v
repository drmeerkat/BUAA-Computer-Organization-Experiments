`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:06 12/01/2016 
// Design Name: 
// Module Name:    W_Reg 
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
module W_Reg(
    input [31:0] IR,
    input [31:0] PC4,
    input [31:0] AO,
    input [31:0] DR,
    input [31:0] SH,
    output [31:0] IR_W,
    output [31:0] PC4_W,
    output [31:0] AO_W,
    output [31:0] DR_W,
    output [31:0] SH_W,
    input Clk,
	input Reset
    );

	reg [31:0] _IR, _PC4, _AO, _DR, _SH;
	assign IR_W = _IR;
	assign PC4_W = _PC4;
	assign AO_W = _AO;
	assign DR_W = _DR;
	assign SH_W = _SH;
	
	always @ (posedge Clk)begin
		if (Reset)begin
			_DR <= 0;
			_IR <= 0;
			_PC4 <= 0;
			_AO <= 0;
			_SH <= 0;
		end
		else begin
			_DR <= DR;
			_IR <= IR;
			_PC4 <= PC4;
			_AO <= AO;
			_SH <= SH;
		end
	end
endmodule
