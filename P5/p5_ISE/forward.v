`timescale 1ns / 1ps
`define WrData_M 2'b01 
`define WrData_W 2'b10
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:26 12/03/2016 
// Design Name: 
// Module Name:    forward 
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
module forward(
	input [4:0] WrReg_M,
	input RegWr_M,
	input generated_M,
	input [4:0] WrReg_W,
	input RegWr_W,
	input generated_W,
	input [4:0] ReReg1_E,
	input [4:0] ReReg2_E,
	input [4:0] ReReg1_D,
	input [4:0] ReReg2_D,
	input [4:0] ReReg2_M,
	
	
	
	output [1:0] ForwardRSD,
	output [1:0] ForwardRTD,
	output [1:0] ForwardRSE,
	output [1:0] ForwardRTE,
	output [1:0] ForwardRTM,
	output [1:0] ForwardRTE_ALUb
    );
	
	reg [1:0] _ForwardRSD, _ForwardRTD, _ForwardRSE, _ForwardRTE, _ForwardRTM, _ForwardRTE_ALUb;
	//reg [1:0] _ForwardRaF;
	assign ForwardRSD = _ForwardRSD;
	assign ForwardRTD = _ForwardRTD;
	assign ForwardRSE = _ForwardRSE;
	assign ForwardRTE = _ForwardRTE;
	assign ForwardRTM = _ForwardRTM;
	assign ForwardRTE_ALUb = _ForwardRTE_ALUb;
	
	//always @* begin
	//	if (5'b1f == WrReg_M && RegWr_M && generated_M)
	//		_ForwardRaF <= `WrData_M;
	//	else if (5'b1f == WrReg_W && RegWr_W && generated_W)
	//		_ForwardRaF <= `WrData_W;
	//end
	
	always @* begin
		if (ReReg1_D == WrReg_M && RegWr_M && generated_M && ReReg1_D)
			_ForwardRSD = `WrData_M;
		else if (ReReg1_D == WrReg_W && RegWr_W && generated_W && ReReg1_D)
			_ForwardRSD = `WrData_W;
		else
			_ForwardRSD = 2'b00;
		if (ReReg2_D == WrReg_M && RegWr_M && generated_M && ReReg2_D)
			_ForwardRTD = `WrData_M;
		else if (ReReg2_D == WrReg_W && RegWr_W && generated_W && ReReg2_D)
			_ForwardRTD = `WrData_W;
		else
			_ForwardRTD = 2'b00;	
	end
	
	always @* begin
		if (ReReg1_E == WrReg_M && RegWr_M && generated_M && ReReg1_E)
			_ForwardRSE = `WrData_M; 
		else if (ReReg1_E == WrReg_W && RegWr_W && generated_W && ReReg1_E)
			_ForwardRSE = `WrData_W;
		else
			_ForwardRSE = 2'b00;
		if (ReReg2_E == WrReg_M && RegWr_M && generated_M && ReReg2_E)
			_ForwardRTE = `WrData_M;
		else if (ReReg2_E == WrReg_W && RegWr_W && generated_W && ReReg2_E)
			_ForwardRTE = `WrData_W;
		else
			_ForwardRTE = 2'b00;
	end
	
	always @* begin
		if (ReReg2_M == WrReg_W && RegWr_W && generated_W && ReReg2_M)
			_ForwardRTM = `WrData_W; 
		else
			_ForwardRTM = 2'b00;
	end
	
	
	

endmodule
