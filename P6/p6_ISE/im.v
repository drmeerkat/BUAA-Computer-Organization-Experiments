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
    input [12:2] Addr, //当前指令地址
	input Clk,
    output [31:0] Out  //当前指令
    );
	reg [31:0] _im[2047:0];
	reg [31:0] out;
	assign Out = out;
	wire [12:2] _Addr;
	assign _Addr = {{~Addr[12]},Addr[11:2]};
	initial begin 
		$readmemh ("code.txt",_im);
	end 

	always @(Addr) begin
		out = _im[_Addr];
		$display(" INS: %h",Out);
	end
	
	

endmodule
