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
    input [31:0] WD,
    input [31:0] Addr,
    input Reset,
    output [31:0] RD,
	input [31:0] IR_M
    );
	
	reg [31:0] ram[1023:0];
	integer i;
	initial begin
		for (i = 0;i<1024;i = i+1)begin
				ram[i] <= 0;
			end
	end
	
	assign RD = ram[Addr[11:2]];
	always @(posedge Clk)begin
		if (Reset)begin
			for (i = 0;i<1024;i = i+1)begin
				ram[i] <= 0;
			end
		end
		else if (MemWr) begin
			ram[Addr[11:2]] <= WD;
			$display("*%h <= %h",Addr,WD);
			$display("%h",IR_M);
		end
	end
	


endmodule
