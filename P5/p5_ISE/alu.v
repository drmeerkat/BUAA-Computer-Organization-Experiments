`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:35:26 10/13/2016 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Out,
    input [2:0] ALUOp,
	input [4:0] sa
    );
	wire [31:0] temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8;
	reg [31:0] C;
	
	assign Out = C;
	assign temp1 = A+B;
	assign temp2 = A-B;
	assign temp3 = (A[31] > B[31])||((A[31] == B[31])&&(A < B));  // A < B signed
	assign temp4 = A|B;
	assign temp5 = B << sa;
	assign temp6 = B >> sa;
	assign temp7 = A&B;
	assign temp8 = A^B;
	
	
	always @(ALUOp, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8) 
      case (ALUOp)
         3'b000: C = temp1;
         3'b001: C = temp2;
         3'b010: C = temp3;
         3'b011: C = temp4;
		 3'b100: C = temp5;
		 3'b101: C = temp6;
		 3'b110: C = temp7;
		 3'b111: C = temp8;
      endcase
	
	
endmodule
