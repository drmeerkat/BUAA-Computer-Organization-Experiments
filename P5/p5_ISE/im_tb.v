`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:11:31 11/17/2016
// Design Name:   im
// Module Name:   D:/ISE/project1/im_tb.v
// Project Name:  project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: im
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module im_tb;

	// Inputs
	reg [11:2] Addr;
	reg Clk;

	// Outputs
	wire [31:0] Out;

	// Instantiate the Unit Under Test (UUT)
	im uut (
		.Addr(Addr), 
		.Clk(Clk), 
		.Out(Out)
	);

	initial begin
		// Initialize Inputs
		Addr = 0;
		Clk = 0;
        
		// Add stimulus here

	end
	
	always begin
		#10 
		Clk = ~Clk;
		Addr = Addr + 1;
	end
	
      
endmodule

