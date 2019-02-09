`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:37:47 11/15/2016 
// Design Name: 
// Module Name:    grf 
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
module grf(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2,
    input Clk,
    input RegWr,
    input Reset,
	input [31:0] IR_W
    );
	reg [31:0] _reg[31:0];
	integer i;
	
	initial begin
		for (i = 0;i<32;i = i+1)begin
				_reg[i] <= 0;
			end
	end
	
	always@(posedge Clk)begin
		if (Reset)begin
			for (i = 0;i<32;i = i+1)begin
				_reg[i] <= 0;
			end
		end
		else if (RegWr)begin
			_reg[A3] <= WD;
			$display("$%d <= %h", A3, WD);
			$display("%h",IR_W);
		end
	end
	
	assign RD1 = A1 == 0? 0:
				 ((A1 === A3)&&RegWr)? WD:_reg[A1];
	assign RD2 = A2 == 0? 0:
				 ((A2 === A3)&&RegWr)? WD:_reg[A2];


endmodule
