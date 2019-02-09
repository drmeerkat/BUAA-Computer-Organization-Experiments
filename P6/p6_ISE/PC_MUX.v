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
	input [31:0] JI,
	input [2:0] NPC_ctrl,
    output [31:0] NPC
    );

	reg [31:0] npc;
	assign NPC = npc;
	
	always @*
      case (NPC_ctrl)
         3'b001: npc <= BR;
         3'b010: npc <= JR;
         3'b011: npc <= J_JAL;
		 3'b100: npc <= JI;
		 default npc <= PC4;
      endcase
endmodule
