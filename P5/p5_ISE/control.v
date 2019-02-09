`timescale 1ns / 1ps
`define addu (Op == 6'b000000&&Funct == 6'b100001)
`define add (Op == 6'b000000&&Funct == 6'b100000)
`define addi (Op == 6'b001000)
`define addiu (Op == 6'b001001)
`define subu (Op == 6'b000000&&Funct == 6'b100011)
`define sub (Op == 6'b000000&&Funct == 6'b100010)
`define AND (Op == 6'b000000&&Funct == 6'b100100)
`define OR (Op == 6'b000000&&Funct == 6'b100101)
`define XOR (Op == 6'b000000&&Funct == 6'b100110)
`define lui (Op == 6'b001111)
`define ori (Op == 6'b001101)
`define lw (Op == 6'b100011)
`define sw (Op == 6'b101011)
`define beq (Op == 6'b000100)
`define bne (Op == 6'b000101)
`define sltin (Op == 6'b001010)
`define sll (Op == 6'b000000&&Funct == 6'b000000&&ins != 32'b0)
`define srl (Op == 6'b000000&&Funct == 6'b000010)
`define jr (Op == 6'b000000)&&(Funct == 6'b001000)       
`define jal (Op == 6'b000011)

`define rs 25:21
`define rt 20:16
`define rd 15:11


module control(
	input [31:0] ins,
	input Eq,
	input Neq,
	input lz,
	input [1:0] stage, //00 for D,  01 for E  10 for M   11 for W
	input [31:0] ALUout,
	input [31:0] Shift,
	input [31:0] PC8,
	output reg [1:0] NPC_ctrl,
	output RegDst,
	output RegDst_2,
	output [1:0] grf_WDsrc,
	output RegWr,
	output EXT_ZS,
	output ALUsrc,
	output [2:0] ALUOp,
	output MemWr,
	output Cal_r,
	output Cal_i,
	output ld,
	output st,
	output beq,
	output j,
	output jal,
	output jr,
	output sl,
	output [31:0] WrData_M,
	output generated,
	output [4:0] WrReg,
	output [4:0] ReReg1,
	output [4:0] ReReg2
    );
	
	wire [5:0] Op, Funct;
	assign Op = ins[31:26];
	assign Funct = ins[5:0];
	
	assign Cal_r = `addu||`subu||`add||`sub||`AND||`OR||`XOR;    //rd
	assign Cal_i = `lui||`ori||`sltin||`addi||`addiu;//rt
	assign ld  = `lw;           //rt
	assign st  = `sw; 
	assign jr  = `jr;        //31
	assign jal = `jal;
	assign beq = `beq||`bne;
	assign sl = `sll||`srl;
	//00->D   01->E    10->M   11->W
	assign generated = (stage == 2'b10&&(Cal_r||Cal_i||jal||sl))||(stage == 2'b11&&(ld||Cal_r||Cal_i||jal||sl)); 
	assign ReReg1 = (stage == 2'b00&&beq)||(stage == 2'b01&&(Cal_r||`ori||ld||st||`sltin||`addi||`addiu))? ins[`rs]: stage == 2'b00&&jr? 5'h1f:0;
	assign ReReg2 = ((stage == 2'b00&&beq)||(stage == 2'b01&&(Cal_r||st||sl))||(stage == 2'b10&&(st)))? ins[`rt]:0;
	assign WrReg = (Cal_r||sl)? ins[`rd]:
				   (Cal_i||ld)? ins[`rt]:
				   5'h1f;
	assign WrData_M = `lui? Shift: 
					   jal? PC8: 
					   ALUout;
	
	reg [10:0] signal;
	assign {RegDst, RegDst_2, grf_WDsrc, RegWr, EXT_ZS, ALUsrc, ALUOp, MemWr} = signal;
	always @ * begin
		if ((Op == 6'b000100&&Eq == 1'b1)||(Op == 6'b000001&&ins[`rt] == 5'b10000&&lz)||(`bne&&Neq))
			NPC_ctrl = 2'b01;//beq bne
		else if (Funct == 6'b001000&&Op == 6'b000000)
			NPC_ctrl = 2'b10;//jr
		else if (Op == 6'b000011||Op == 6'b000010)
			NPC_ctrl = 2'b11;//jal_j
		else
			NPC_ctrl = 2'b00;//PC4
			
		case(Op)
		//R-Type
			6'b000000: begin
						case (Funct)
						//addu
							6'b100001: signal <= 11'b00001000000;
						//add 
							6'b100000: signal <= 11'b00001000000;
						//subu	
							6'b100011: signal <= 11'b00001000010;
						//sub 
							6'b100010: signal <= 11'b00001000010;
						//AND 
							6'b100100: signal <= 11'b00001001100;
						//OR 
						    6'b100101: signal <= 11'b00001000110;
						//XOR 
							6'b100110: signal <= 11'b00001001110;
						//sll 
						    6'b000000: begin
								if (ins != 32'b0)
									signal <= 11'b00001001000;
								else
									signal <= 11'b00000000000;
							end
						//srl
						    6'b000010: signal <= 11'b00001001010;
						//jr	
							6'b001000: signal <= 11'b00000000000;
							default: signal <= 11'b00000000000;
						endcase
					   end
		//addi 
			6'b001000: signal <= 11'b10001110000;
		//addiu
			6'b001001: signal <= 11'b10001110000;
		//ori	
			6'b001101: signal <= 11'b10001010110;
		//lw
			6'b100011: signal <= 11'b10011110000;
		//sw
			6'b101011: signal <= 11'b00000110001;
		//beq
			6'b000100: signal <= 11'b00000100100;
		//bne 
		    6'b000101: signal <= 11'b00000000000;
		//lui
			6'b001111: signal <= 11'b10101000000;
		//jal
			6'b000011: signal <= 11'b01111000000;
		//j
			6'b000010: signal <= 11'b00000000000;
		//sltin
			6'b001010: begin
			if (ALUout == 32'b1)
				signal <= 11'b10001110100;
			else 
				signal <= 11'b10000110100;
			end
		//bltzal
			6'b000001: signal <= 11'b01001000100;
		//including nop
			default: signal <= 11'b00000000000;
		endcase
	end

endmodule
