`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:12:53 11/16/2016 
// Design Name: 
// Module Name:    dm 
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
module dm(
    input Clk,
    input MemWr,
	input [31:0] IR_M,
    input [31:0] WD,
    input [31:0] Addr,
    input Reset,
	input [3:0] BE,
    output [31:0] RD
    );
	
	reg [31:0] ram[2047:0];
	integer i;
	initial begin
		for (i = 0;i<2048;i = i+1)begin
				ram[i] <= 0;
			end
	end
	
	assign RD = ram[Addr[12:2]];
	always @(posedge Clk)begin
		if (Reset)begin
			for (i = 0;i<2048;i = i+1)
				ram[i] <= 0;
		end
		else if (MemWr) begin
			if (BE == 4'b1000||BE == 4'b0100||BE == 4'b0010||BE == 4'b0001)begin
				ram[Addr[12:2]] <= (Addr[1:0] == 0)? {RD[31:8],WD[7:0]}:
								   (Addr[1:0] == 1)? {RD[31:16],WD[7:0],RD[7:0]}:
								   (Addr[1:0] == 2)? {RD[31:24],WD[7:0],RD[15:0]}:
								   {WD[7:0],RD[23:0]};
				$display("*%h <= %h",Addr,WD[7:0]);
			end
			else if (BE == 4'b1100||BE == 4'b0011) begin
				ram[Addr[12:2]] <= (Addr[1] == 0)? {RD[31:16],WD[15:0]}:
								   {WD[15:0],RD[15:0]};
				$display("*%h <= %h",Addr,WD[15:0]);
			end
			else if (BE == 4'b1111) begin
				ram[Addr[12:2]] <= WD;
				$display("*%h <= %h",Addr,WD);
			end
		
		end
	
	end
	


endmodule
