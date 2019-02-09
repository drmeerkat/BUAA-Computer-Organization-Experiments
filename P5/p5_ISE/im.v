`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:32 10/12/2016 
// Design Name: 
// Module Name:    im 
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
module im(
    input [11:2] Addr, //当前指令地址
	input Clk,
    output [31:0] Out  //当前指令
    );
	reg [31:0] _im[1023:0];
	reg [31:0] out;
	assign Out = out;
	initial begin 
		$readmemh ("code.txt",_im);
	end 

	always @(Addr) begin
		out = _im[Addr];
		$display(" INS: %h",Out);
	end
	
	

endmodule
