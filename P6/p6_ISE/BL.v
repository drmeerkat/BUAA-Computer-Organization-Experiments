`timescale 1ns / 1ps
`define lw  (ins[31:26] == 6'b100011)
`define lh  (ins[31:26] == 6'b100001)
`define lhu (ins[31:26] == 6'b100101)
`define lb  (ins[31:26] == 6'b100000)
`define lbu (ins[31:26] == 6'b100100)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:54:39 12/15/2016 
// Design Name: 
// Module Name:    BL 
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
module BL(
    input [31:0] addr,
	input [31:0] ins,
    input [31:0] Din,
    output [31:0] Dout
    );
	
	reg [31:0] dout;
	assign Dout = dout;
	
	always @* begin
		if (`lh)
			dout <= (addr[1])?{{16{Din[31]}},Din[31:16]}:{{16{Din[15]}},Din[15:0]};
		else if (`lhu)
			dout <= (addr[1])?{{16{1'b0}},Din[31:16]}:{{16{1'b0}},Din[15:0]};
		else if (`lb)
			dout <= (addr[1:0] == 0)? {{24{Din[7]}},Din[7:0]}:
					(addr[1:0] == 1)? {{24{Din[15]}},Din[15:8]}:
					(addr[1:0] == 2)? {{24{Din[23]}},Din[23:16]}:
					{{24{Din[31]}},Din[31:24]};
		else if (`lbu)
			dout <= (addr[1:0] == 0)? {{24{1'b0}},Din[7:0]}:
					(addr[1:0] == 1)? {{24{1'b0}},Din[15:8]}:
					(addr[1:0] == 2)? {{24{1'b0}},Din[23:16]}:
					{{24{1'b0}},Din[31:24]};
		else
			dout <= Din;  
		//default lw	
	end
	


endmodule
