`timescale 1ns / 1ps
`define sw  (ins[31:26] == 6'b101011)
`define sh  (ins[31:26] == 6'b101001)
`define sb  (ins[31:26] == 6'b101000)
`define swe (ins[31:26] == 6'b011111)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:30:19 12/15/2016 
// Design Name: 
// Module Name:    BE 
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
module BE(
    input [1:0] Addr,
	input [31:0] ins,
    output [3:0] BE
    );
	reg [3:0] be;
	assign BE = be;
	
	always @* begin
		if (`sw||`swe)
			be <= 4'b1111;
		else if (`sh)
			be <= Addr[1]? 4'b1100:4'b0011;
		else if (`sb)
			be <= (Addr == 2'b00)? 4'b0001:
				  (Addr == 2'b01)? 4'b0010:
				  (Addr == 2'b10)? 4'b0100:
				  (Addr == 2'b11)? 4'b1000:
				  4'b0000;
	end
	
	
endmodule
