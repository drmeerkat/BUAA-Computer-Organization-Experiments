`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:00:33 11/16/2016 
// Design Name: 
// Module Name:    npc 
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
module npc(
    input [31:0] PC4,            //当前指令地址
    input [15:0] BrOffset,
    input [31:0] JrOffset,
    input [25:0] JalOffset,
	input [31:0] JiOffset,
	output [31:0] JI,
	output [31:0] BR,
	output [31:0] JR,
	output [31:0] J_JAL,
	output [31:0] PC8
    );
	wire [31:0] PC;
	assign PC = PC4 - 4;
	
	assign BR = PC4 + {{14{BrOffset[15]}}, BrOffset, 2'b00};
	assign JR = JrOffset;
	assign J_JAL = {PC[31:28], JalOffset, 2'b00};
	assign PC8 = PC4+4;
	assign JI = JiOffset + {{16{BrOffset[15]}}, BrOffset};
	
	
endmodule
