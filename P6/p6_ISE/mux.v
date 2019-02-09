`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:00:21 11/18/2016 
// Design Name: 
// Module Name:    mux 
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
module mux2_5(        //5位2选1
    input [4:0] d1,   //输入数据
    input [4:0] d2,
    input src,		  //输出选择
    output [4:0] out  //输出
    );

	assign out = src?d2:d1;
endmodule

module mux4_32(		  //32位4选1
    input [1:0] src,
    input [31:0] d1,
    input [31:0] d2,
	input [31:0] d3,
	input [31:0] d4,	
    output reg [31:0] out
    );

	always @(src, d1, d2, d3, d4)
      case (src)
         2'b00: out = d1;
         2'b01: out = d2;
         2'b10: out = d3;
         2'b11: out = d4;
      endcase
endmodule

module mux2_32(		  //32位2选1
    input src,
    input [31:0] d1,
    input [31:0] d2,
    output [31:0] out
    );

	assign out = src?d2:d1;

endmodule


