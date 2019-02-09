`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:40:50 12/01/2016 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] D1,
    input [31:0] D2,
    output Eq,
	output Neq,
	output Ltz,
	output Lez,
	output Gtz,
	output Gez
    );
	
	assign Eq = (D1 == D2);
	assign Neq = (D1 != D2);
	assign Ltz = (D1[31]);
	assign Lez = (D1[31]||D1 == 32'b0);
	assign Gtz = (~D1[31]&&D1 != 32'b0);
	assign Gez = (~D1[31]);

endmodule
