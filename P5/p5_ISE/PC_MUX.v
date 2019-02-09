`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:56 12/01/2016 
// Design Name: 
// Module Name:    PC_MUX 
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
module PC_MUX(
    input [31:0] BR,
    input [31:0] JR,
    input [31:0] J_JAL,
    input [31:0] PC4,
	input [1:0] NPC_ctrl,
    output [31:0] NPC
    );

	reg [31:0] npc;
	assign NPC = npc;
	
	always @(NPC_ctrl, PC4, BR, JR, J_JAL)
      case (NPC_ctrl)
         2'b01: npc <= BR;
         2'b10: npc <= JR;
         2'b11: npc <= J_JAL;
		 default npc <= PC4;
      endcase
endmodule
