`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:51:36 12/01/2016 
// Design Name: 
// Module Name:    D_Reg 
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
module D_Reg(
    input [31:0] IR,
    input [31:0] PC4,
	input Clk,
	input En,
	input Reset,
    output [31:0] IR_D,
    output [31:0] PC4_D
    );
	
	reg [31:0] _IR, _PC4;
	assign IR_D = _IR;
	assign PC4_D = _PC4; 
	
	always @(posedge Clk)begin
		if (Reset) begin
			_IR <= 0;
			_PC4 <= 0;
        end
		else if (En)begin
			_IR <= IR;
			_PC4 <= PC4;
		end
	end 

endmodule
