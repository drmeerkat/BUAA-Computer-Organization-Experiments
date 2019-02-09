`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:26:35 11/16/2016 
// Design Name: 
// Module Name:    ifu 
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
module ifu(
	input Clk,
	input Reset,
	input [31:0] BR,
    input [31:0] JR,
    input [31:0] J_JAL,
	input [31:0] JI,
	input [2:0] NPC_ctrl,
	input En,
	output [31:0] PC4,
	output [31:0] ins
    );
	
	wire [31:0] npc, im_addr;
	assign PC4 = im_addr + 4;
	
	PC_MUX _pc_mux(
    .BR(BR),
    .JR(JR),
    .J_JAL(J_JAL),
    .PC4(PC4),
	.JI(JI),
	.NPC_ctrl(NPC_ctrl),
    .NPC(npc)
    );

	
	pc _pc(
    .Clk(Clk),
    .Reset(Reset),
    .Addr(npc),
	.En(En),
    .Out(im_addr)
    );
	
	im _im(
    .Addr(im_addr[12:2]),
	.Clk(Clk),
    .Out(ins)
    );

endmodule
