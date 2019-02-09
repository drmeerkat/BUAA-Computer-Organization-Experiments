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
    input [4:0] ALUOp,
	input [4:0] sa
    );
	wire [63:0] _temp9;
	wire [31:0] temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,temp14,temp15;
	reg [31:0] C;
	
	assign Out = C;
	assign temp1 = A+B;
	assign temp2 = A-B;
	assign temp3 = ($signed(A) < $signed(B));  // A < B signed  A[31] > B[31])||((A[31] == B[31])&&(A < B)
	assign temp4 = A|B;
	assign temp5 = B << sa;
	assign temp6 = B >> sa;
	assign temp7 = A&B;
	assign temp8 = A^B;
	assign temp9 = {{31{B[31]}},B}>>sa;
	assign temp10 = {{31{B[31]}},B}>>A[4:0];
	assign temp11 = B<<A[4:0];
	assign temp12 = B>>A[4:0];
	assign temp13 = ~(A|B);
	assign temp14 = A < B;
	assign temp15 = A + {{7{B[31]}},B[31:7]};
	
	
	always @*
      case (ALUOp)
         5'b00000: C = temp1;
         5'b00001: C = temp2;
         5'b00010: C = temp3;
         5'b00011: C = temp4;
		 5'b00100: C = temp5;
		 5'b00101: C = temp6;
		 5'b00110: C = temp7;
		 5'b00111: C = temp8;
         5'b01000: C = temp9;
         5'b01001: C = temp10;
         5'b01010: C = temp11;
         5'b01011: C = temp12;
		 5'b01100: C = temp13;
		 5'b01101: C = temp14;
		 5'b01110: C = temp15;
      endcase
	
	
endmodule
