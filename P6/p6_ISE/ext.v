`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:05:29 11/16/2016 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input ExtOp,
    input [15:0] In,
    output [31:0] Out
    );
	//extop = 0-> zero_ext    1->sign_ext
	assign Out = ExtOp?{{16{In[15]}},In}:{{16{1'b0}},In};
	

endmodule
