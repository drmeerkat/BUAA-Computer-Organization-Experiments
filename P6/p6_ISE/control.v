`timescale 1ns / 1ps
`define addu  (Op == 6'b000000&&Funct == 6'b100001)
`define add   (Op == 6'b000000&&Funct == 6'b100000)
`define addi  (Op == 6'b001000)
`define addiu (Op == 6'b001001)
`define subu  (Op == 6'b000000&&Funct == 6'b100011)
`define sub   (Op == 6'b000000&&Funct == 6'b100010)
`define AND   (Op == 6'b000000&&Funct == 6'b100100)
`define OR    (Op == 6'b000000&&Funct == 6'b100101)
`define XOR   (Op == 6'b000000&&Funct == 6'b100110)
`define lui   (Op == 6'b001111)
`define ori   (Op == 6'b001101)
`define lw    (Op == 6'b100011)
`define lh    (Op == 6'b100001)
`define lhu   (Op == 6'b100101)
`define lb    (Op == 6'b100000)
`define lbu   (Op == 6'b100100)
`define sw    (Op == 6'b101011)
`define sh    (Op == 6'b101001)
`define sb    (Op == 6'b101000)
`define beq   (Op == 6'b000100)
`define bne   (Op == 6'b000101)
`define sll   (Op == 6'b000000&&Funct == 6'b000000&&ins != 32'b0)
`define srl   (Op == 6'b000000&&Funct == 6'b000010)
`define jr    (Op == 6'b000000&&Funct == 6'b001000)     
`define jal   (Op == 6'b000011)
`define j     (Op == 6'b000010)

`define jalr  (Op == 6'b000000&&Funct == 6'b001001)
`define jialc (Op == 6'b111110)
`define sra   (Op == 6'b000000&&Funct == 6'b000011)
`define srav  (Op == 6'b000000&&Funct == 6'b000111)
`define sllv  (Op == 6'b000000&&Funct == 6'b000100)
`define srlv  (Op == 6'b000000&&Funct == 6'b000110)
`define slt   (Op == 6'b000000&&Funct == 6'b101010)
`define sltu  (Op == 6'b000000&&Funct == 6'b101011)
`define NOR   (Op == 6'b000000&&Funct == 6'b100111)
`define andi  (Op == 6'b001100)
`define xori  (Op == 6'b001110)
`define slti  (Op == 6'b001010)
`define sltiu (Op == 6'b001011)
`define bltz  (Op == 6'b000001&&ins[20:16] == 5'b00000)
`define blez  (Op == 6'b000110)
`define bgtz  (Op == 6'b000111)
`define bgez  (Op == 6'b000001&&ins[20:16] == 5'b00001)

`define mult   (Op == 6'b000000&&Funct == 6'b011000)
`define multu  (Op == 6'b000000&&Funct == 6'b011001)
`define div    (Op == 6'b000000&&Funct == 6'b011010)
`define divu   (Op == 6'b000000&&Funct == 6'b011011)
`define mfhi   (Op == 6'b000000&&Funct == 6'b010000)
`define mthi   (Op == 6'b000000&&Funct == 6'b010001)
`define mflo   (Op == 6'b000000&&Funct == 6'b010010)
`define mtlo   (Op == 6'b000000&&Funct == 6'b010011)
`define marotr (Op == 6'b011100)
`define swe    (Op == 6'b011111)

`define rs 25:21
`define rt 20:16
`define rd 15:11


module controla(
	input [31:0] ins,
	input Eq,
	input Neq,
	input lz,
	input Ltz,
	input Lez,
	input Gtz,
	input Gez,
	input [1:0] stage, //00 for D,  01 for E  10 for M   11 for W
	input [31:0] ALUout,
	input [31:0] Shift,
	input [31:0] PC8,
	output [3:0] MDU_ctrl,
	output start,
	output mdu_out_ctrl,
    output Uout_ctrl,
	output [2:0] NPC_ctrl,
	output RegDst,
	output RegDst_2,
	output [1:0] grf_WDsrc,
	output RegWr,
	output EXT_ZS,
	output ALUsrc,
	output [4:0] ALUOp,
	output MemWr,
	output Cal_r,
	output Cal_i,
	output ld,
	output st,
	output beq,
	output j,
	output jal,
	output jr,
	output jialc,
	output sl,
	output lui,
	output md,
	output mf,
	output mt,
	output jalr,
	output [31:0] WrData_M,
	output generated,
	output [4:0] WrReg,
	output [4:0] ReReg1,
	output [4:0] ReReg2
    );
	
	wire [5:0] Op, Funct;
	assign Op = ins[31:26];
	assign Funct = ins[5:0];
	
	assign Cal_r = `addu||`subu||`add||`sub||`AND||`OR||`XOR||`srav||`sllv||`srlv||`NOR||`slt||`sltu;//rd
	assign Cal_i = `ori||`slti||`addi||`addiu||`andi||`xori||`slti||`sltiu;//rt
	assign ld  = `lw||`lh||`lhu||`lb||`lbu;           //rt
	assign st  = `sw||`sh||`sb||`swe; 
	assign jr  = `jr;       
	assign jal = `jal;
	assign jalr = `jalr;
	assign jialc = `jialc;
	assign beq = `beq||`bne||`bltz||`blez||`bgtz||`bgez;
	assign sl = `sll||`srl||`sra;
	assign lui = `lui;
	assign md = `mult||`multu||`div||`divu||`marotr;
	assign mf = `mfhi||`mflo;
	assign mt = `mthi||`mtlo;
	//00->D   01->E    10->M   11->W
	assign generated = (stage == 2'b10&&(Cal_r||Cal_i||jal||jalr||sl||lui||mf||jialc))||(stage == 2'b11&&(ld||Cal_r||Cal_i||jal||jalr||sl||lui||mf||jialc)); 
	assign ReReg1 = (stage == 2'b00&&(jr||beq||jalr))||(stage == 2'b01&&(Cal_r||ld||st||Cal_i||mt||md))? ins[`rs]: stage == 2'b00&&jr? 5'h1f:0;
	assign ReReg2 = ((stage == 2'b00&&(beq||jialc))||(stage == 2'b01&&(Cal_r||st||sl||md))||(stage == 2'b10&&(st)))? ins[`rt]:0;
	assign WrReg = (Cal_r||sl||mf||jalr)? ins[`rd]:
				   (Cal_i||ld||lui)? ins[`rt]:
				   5'h1f;
	assign WrData_M =  lui? Shift: 
					   (jal||jalr||jialc)? PC8: 
					   ALUout;
	assign NPC_ctrl = ((`beq&&Eq)||(`bne&&Neq)||(`bltz&&Ltz)||(`blez&&Lez)||(`bgtz&&Gtz)||(`bgez&&Gez))? 3'b001
					 :(`jr||`jalr)? 3'b010
					 :(`jal||`j)? 3'b011
					 :(`jialc)? 3'b100
					 :3'b000;
	assign start = md;
	assign mdu_out_ctrl = `mflo;   //hi->0 lo->1
    assign Uout_ctrl = mf;         //alu->0 mf->1
	assign MDU_ctrl = (`mult)?   4'b0000:(`multu)? 4'b0001
					 :(`div)?    4'b0010:(`divu)?  4'b0011
					 :(`mfhi)?   4'b0100:(`mflo)?  4'b0101
					 :(`mthi)?   4'b0110:(`mtlo)?  4'b0111
					 :(`marotr)? 4'b1000:
					 4'b1001;         
	
	
	reg [12:0] signal;
	assign {RegDst, RegDst_2, grf_WDsrc, RegWr, EXT_ZS, ALUsrc, ALUOp, MemWr} = signal;
	always @ * begin
		case(Op)
		//R-Type
			6'b000000: begin
						case (Funct)
						//addu
							6'b100001: signal <= 13'b0000100_000000;
						//add 
							6'b100000: signal <= 13'b0000100_000000;
						//subu	
							6'b100011: signal <= 13'b0000100_000010;
						//sub 
							6'b100010: signal <= 13'b0000100_000010;
						//mfhi  
							6'b010000: signal <= 13'b0000100_000000;
						//mflo  
							6'b010010: signal <= 13'b0000100_000000;
						//AND 
							6'b100100: signal <= 13'b0000100_001100;
						//OR 
						    6'b100101: signal <= 13'b0000100_000110;
						//XOR 
							6'b100110: signal <= 13'b0000100_001110;
						//sll 
						    6'b000000: begin
								if (ins != 32'b0)
									signal <= 13'b0000100_001000;
								else
									signal <= 13'b0000000_000000;
							end
						//srl
						    6'b000010: signal <= 13'b0000100_001010;
						//jr	
							6'b001000: signal <= 13'b0000000_000000;
						//jalr 
							6'b001001: signal <= 13'b0011100_000000;
						//sra  
							6'b000011: signal <= 13'b0000100_010000;
						//srav  
							6'b000111: signal <= 13'b0000100_010010;
						//sllv  
							6'b000100: signal <= 13'b0000100_010100;
						//srlv  
							6'b000110: signal <= 13'b0000100_010110;
						//slt  
							6'b101010: signal <= 13'b0000100_000100;
						//sltu  
							6'b101011: signal <= 13'b0000100_011010;
						//NOR  
							6'b100111: signal <= 13'b0000100_011000;
							default: signal <= 13'b0000000_000000;
						endcase
					   end
		//addi 
			6'b001000: signal <= 13'b1000111_000000;
		//addiu
			6'b001001: signal <= 13'b1000111_000000;
		//ori	
			6'b001101: signal <= 13'b1000101_000110;
		//lw
			6'b100011: signal <= 13'b1001111_000000;
		//lh    
			6'b100001: signal <= 13'b1001111_000000;
		//lhu   
			6'b100101: signal <= 13'b1001111_000000;
		//lb    
			6'b100000: signal <= 13'b1001111_000000;
		//lbu   
			6'b100100: signal <= 13'b1001111_000000;
		//sw
			6'b101011: signal <= 13'b0000011_000001;
		//sh    
			6'b101001: signal <= 13'b0000011_000001;
		//sb    
			6'b101000: signal <= 13'b0000011_000001;	
		//beq
			6'b000100: signal <= 13'b0000010_000000;
		//bne 
		    6'b000101: signal <= 13'b0000000_000000;
		//lui
			6'b001111: signal <= 13'b1010100_000000;
		//jal
			6'b000011: signal <= 13'b0111100_000000;
		//j
			6'b000010: signal <= 13'b0000000_000000;
		//slti
			6'b001010: signal <= 13'b1000111_000100;
		//sltiu  
			6'b001011: signal <= 13'b1000111_011010;
		//ANDI  
			6'b001100: signal <= 13'b1000101_001100;
		//XORI  
			6'b001110: signal <= 13'b1000101_001110;
		//bltz && bgez  
			6'b000001: signal <= 13'b0000000_000000;
		//blez  
			6'b000110: signal <= 13'b0000000_000000;
		//bgtz  
			6'b000111: signal <= 13'b0000000_000000;
		//bltzal
			6'b000001: signal <= 13'b0100100_000100;
		//jialc 
			6'b111110: signal <= 13'b0111100_000000;
		//swe    
			6'b011111: signal <= 13'b0000011_011101;
		//including nop
			default: signal <= 13'b0000000_000000;
		endcase
	end

endmodule
