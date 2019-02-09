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
    input Clk,            //ʱ���ź�
    input Reset,		  //��λ�ź�
    input [31:0] Addr,	  //�������һ��ָ���ַ
	input En,
    output reg [31:0] Out //�����ǰָ���ַ
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
