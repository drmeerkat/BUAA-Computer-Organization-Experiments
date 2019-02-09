`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:04:13 11/15/2016 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input Clk,            //时钟信号
    input Reset,		  //复位信号
    input [31:0] Addr,	  //输入的下一条指令地址
	input En,
    output reg [31:0] Out //输出当前指令地址
    );
	initial begin
		Out = 32'h3000;
	end
	
    always @(posedge Clk)
      if (Reset) begin
         Out = 32'h3000;
      end 
	  else if (En) begin
         Out <= Addr;
      end


endmodule
