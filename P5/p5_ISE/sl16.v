`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:50 11/16/2016 
// Design Name: 
// Module Name:    sl16 
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
module sl16(
    input [15:0] in,
    output [31:0] out
    );

	assign out = {in,{16{1'b0}}};
endmodule
