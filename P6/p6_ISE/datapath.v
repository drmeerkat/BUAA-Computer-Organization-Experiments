`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:40:03 11/16/2016 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
	input Clk,
	input Reset
    );
	
	wire [31:0] Ins, gpf_RD1, gpf_RD2, sh_out, ext_out;
	wire [31:0] alu_d2, alu_out, dm_RD, PC4, gpf_WD;
	wire [4:0] A3, A3_0;
	wire Cal_r_D, Cal_i_D, ld_D, st_D, beq_D, j_D, jal_D, jr_D, sl_D, md_D, mf_D, mt_D, jalr_D, jialc_D;
	wire Cal_r_E, Cal_i_E, lE_E, st_E, beq_E, j_E, jal_E, jr_E, sl_E, md_E, mf_E, mt_E;
	wire Cal_r_M, Cal_i_M, lM_M, st_M, bMq_M, j_M, jal_M, jr_M;
	
	wire [31:0] BR, JR, J_JAL, JI;
	wire [2:0] NPC_ctrl_D;
	wire Eq, lz, Neq, Ltz, Lez, Gtz, Gez;
	wire [31:0] IR_D, PC4_D, PC8;
	wire EXT_ZS_D;
	wire [31:0] IR_E, PC4_E, RS_E, RT_E, SH_E, EXT_E;
	wire ALUsrc_E; 
	wire [4:0] ALUOp_E;
	wire [3:0] MDU_ctrl_E;
	wire start_E, busy_E, mdu_out_ctrl, Uout_ctrl;
    wire [31:0] HI, LO, mdu_out, Uout;
	wire [31:0] IR_M, PC4_M, AO_M, RT_M, SH_M; 
	wire [3:0] BE;
	wire MemWr_M;
	wire [31:0] IR_W, PC4_W, AO_W, DR_W, SH_W, DR_W_temp;
	wire [1:0] WDsrc_W;
	wire RegDst_W, RegDst_2_W, RegWr_W;
	
	wire [31:0] CMP_D1, CMP_D2, ALUsrcA, ALUsrcB, DM_DATA, WrData_M, RT_Msrc;
	wire [4:0] WrReg_M, WrReg_W, ReReg1_E, ReReg2_E, ReReg1_D, ReReg2_D, ReReg2_M;
	wire [1:0] ForwardRSD, ForwardRTD, ForwardRSE, ForwardRTE, ForwardRTM, ForwardRTE_ALUb,STAGE_D, STAGE_E, STAGE_M, STAGE_W;
	wire RegWr_M, generated_M, generated_W;
	
	
	assign STAGE_D = 2'b00;
	assign STAGE_E = 2'b01;
	assign STAGE_M = 2'b10;
	assign STAGE_W = 2'b11;
	
	
	//assign Op = Ins[31:26];
	//assign Funct = Ins[5:0];
	
//Hazard
	stall _stall(
	.IR_D(IR_D),
	.IR_E(IR_E),
	.IR_M(IR_M),
	.Cal_r_D(Cal_r_D),
	.Cal_i_D(Cal_i_D),
	.beq_D(beq_D),
	.jr_D(jr_D),
	.jal_D(jal_D),
	.ld_D(ld_D),
	.st_D(st_D),
	.md_D(md_D),
	.mt_D(mt_D),
	.mf_D(mf_D),
	.jalr_D(jalr_D),
	.jialc_D(jialc_D),
	.Cal_r_E(Cal_r_E),
	.Cal_i_E(Cal_i_E),
	.beq_E(beq_E),
	.jr_E(jr_E),
	.jal_E(jal_E),
	.ld_E(ld_E),
	.st_E(st_E),
	.sl_E(sl_E),
	.md_E(md_E),
	.mt_E(mt_E),
	.mf_E(mf_E),
	.busy(busy_E),
	.start(start_E),
	.sl_D(sl_D),
	.ld_M(ld_M),	
	.stall(stall)
    );
	
	forward _forward(
	.WrReg_M(WrReg_M),
	.RegWr_M(RegWr_M),
	.generated_M(generated_M),
	.WrReg_W(WrReg_W),
	.RegWr_W(RegWr_W),
	.generated_W(generated_W),
	.ReReg1_E(ReReg1_E),
	.ReReg2_E(ReReg2_E),
	.ReReg1_D(ReReg1_D),
	.ReReg2_D(ReReg2_D),
	.ReReg2_M(ReReg2_M),
	
	
	.ForwardRSD(ForwardRSD),
	.ForwardRTD(ForwardRTD),
	.ForwardRSE(ForwardRSE),
	.ForwardRTE(ForwardRTE),
	.ForwardRTM(ForwardRTM)
    );



	
//F 	
	ifu _ifu(
	.ins(Ins),
	.Clk(Clk),
	.Reset(Reset),
	.BR(BR),
    .JR(JR),
    .J_JAL(J_JAL),
	.JI(JI),
	.NPC_ctrl(NPC_ctrl_D),
	.PC4(PC4),
	.En(!stall)
    );



//D
	D_Reg d_reg(
    .IR(Ins),
    .PC4(PC4),
	.Clk(Clk),
    .IR_D(IR_D),
    .PC4_D(PC4_D),
	.En(!stall),
	.Reset(Reset)
	);
	
	controla D_control(
	.ins(IR_D),
	.stage(STAGE_D),
	.Eq(Eq),
	.Neq(Neq),
	.lz(lz),
	.Ltz(Ltz),
	.Lez(Lez),
	.Gtz(Gtz),
	.Gez(Gez),
    .NPC_ctrl(NPC_ctrl_D),
	.EXT_ZS(EXT_ZS_D),
	.Cal_r(Cal_r_D),
	.Cal_i(Cal_i_D),
	.ld(ld_D),
	.st(st_D),
	.sl(sl_D),
	.beq(beq_D),
	.jal(jal_D),
	.jr(jr_D),
	.jalr(jalr_D),
	.jialc(jialc_D),
	.md(md_D),
	.mt(mt_D),
	.mf(mf_D),
	.ReReg1(ReReg1_D),
	.ReReg2(ReReg2_D)
    );
	
	npc _npc(
    .PC4(PC4_D),            //当前指令地址
    .BrOffset(IR_D[15:0]),
    .JrOffset(CMP_D1),
    .JalOffset(IR_D[25:0]),
	.JiOffset(CMP_D2),
	.JI(JI),
	.BR(BR),
	.JR(JR),
	.J_JAL(J_JAL),
	.PC8(PC8)
    );
	
	mux4_32 MFRSD(		  //32位4选1
    .src(ForwardRSD),
    .d1(gpf_RD1),
    .d2(WrData_M),
	.d3(gpf_WD),	
    .out(CMP_D1)
    );
	
	mux4_32 MFRTD(		  //32位4选1
    .src(ForwardRTD),
    .d1(gpf_RD2),
    .d2(WrData_M),
	.d3(gpf_WD),	
    .out(CMP_D2)
    );
	
	CMP _cmp(
    .D1(CMP_D1),
    .D2(CMP_D2),
    .Eq(Eq),
	.Neq(Neq),
	.Ltz(Ltz),
	.Lez(Lez),
	.Gtz(Gtz),
	.Gez(Gez)
    );
	
	sl16 _sl16(
	.in(IR_D[15:0]),
	.out(sh_out)
	);

	grf _grf(
	.A1(IR_D[25:21]), 
	.A2(IR_D[20:16]), 
	.A3(A3), 
	.WD(gpf_WD), 
	.RD1(gpf_RD1), 
	.RD2(gpf_RD2), 
	.Clk(Clk), 
	.RegWr(RegWr_W), 
	.Reset(Reset),
	.IR_W(IR_W)
	);
	
	ext _ext(
    .ExtOp(EXT_ZS_D),
    .In(IR_D[15:0]),
    .Out(ext_out)
    );

	


//E	
	E_Reg e_reg(
    .IR(IR_D),
    .PC4(PC8),
    .RS(gpf_RD1),
    .RT(gpf_RD2),
    .SH(sh_out),
    .EXT(ext_out),
    .IR_E(IR_E),
    .PC4_E(PC4_E),
    .RS_E(RS_E),
    .RT_E(RT_E),
    .SH_E(SH_E),
    .EXT_E(EXT_E),
	.Clk(Clk),
	.Clr(stall),
	.Reset(Reset)
    );

	controla E_control(
	.ins(IR_E),
	.stage(STAGE_E),
	.ReReg1(ReReg1_E),
	.ReReg2(ReReg2_E),
	.ALUsrc(ALUsrc_E),
	.ALUOp(ALUOp_E),
	.Cal_r(Cal_r_E),
	.Cal_i(Cal_i_E),
	.ld(ld_E),
	.st(st_E),
	.sl(sl_E),
	.beq(beq_E),
	.jal(jal_E),
	.jr(jr_E),
	.md(md_E),
	.mt(mt_E),
	.mf(mf_E),
	.MDU_ctrl(MDU_ctrl_E),
	.start(start_E),
	.mdu_out_ctrl(mdu_out_ctrl),
    .Uout_ctrl(Uout_ctrl)
    );
	
	mux2_32 ALUsrc_mux(
    .src(ALUsrc_E),
    .d1(RT_Msrc),
    .d2(EXT_E),
    .out(ALUsrcB)
    );
	
	mux4_32 MFRSE(		  //32位4选1
    .src(ForwardRSE),
    .d1(RS_E),
    .d2(WrData_M),
	.d3(gpf_WD),
    .out(ALUsrcA)
    );
	
	
	mux4_32 MFRTE(		  //32位4选1,sw不是转发到alub
    .src(ForwardRTE),
    .d1(RT_E),
    .d2(WrData_M),
	.d3(gpf_WD),
    .out(RT_Msrc)
    );
	
	
	
	alu _alu (
	.A(ALUsrcA),
	.B(ALUsrcB),
	.Out(alu_out),
	.ALUOp(ALUOp_E),
	.sa(IR_E[10:6])
	);
	
	MDU _mdu(
    .A(ALUsrcA),
	.B(ALUsrcB),
	.sa(IR_E[10:6]),
	.Reset(Reset),
	.Clk(Clk),
	.MDU_ctrl(MDU_ctrl_E),
	.start(start_E),//只要E级指令是4条即start
	.busy(busy_E),
    .HI(HI),
    .LO(LO)
    );
	
	mux2_32 MDUout(		  //32位2选1
    .src(mdu_out_ctrl),
    .d1(HI),
    .d2(LO),
    .out(mdu_out)
    );
	
	mux2_32 AOMin(		  //32位2选1
    .src(Uout_ctrl),
    .d1(alu_out),
    .d2(mdu_out),
    .out(Uout)
    );
	
	
	

//M	
	M_Reg m_reg(
    .IR(IR_E),
    .PC4(PC4_E),
    .AO(Uout),
    .RT(RT_Msrc),
    .SH(SH_E),
    .IR_M(IR_M),
    .PC4_M(PC4_M),
    .AO_M(AO_M),
    .RT_M(RT_M),
    .SH_M(SH_M),
    .Clk(Clk),
	.Reset(Reset)
    );
	
	controla M_control(
	.ins(IR_M),
	.stage(STAGE_M),
	.ALUout(AO_M),
	.Shift(SH_M),
	.PC8(PC4_M),
	.WrData_M(WrData_M),
	.ReReg2(ReReg2_M),
	.WrReg(WrReg_M),//序号
	.RegWr(RegWr_M),//使能
	.generated(generated_M),
	.MemWr(MemWr_M),
	.Cal_r(Cal_r_M),
	.Cal_i(Cal_i_M),
	.ld(ld_M),
	.st(st_M),
	.beq(beq_M),
	.jal(jal_M),
	.jr(jr_M)
    );
	
	mux4_32 MFRTM(		  //32位4选1
    .src(ForwardRTM),
    .d1(RT_M),
    .d2(WrData_M),
	.d3(gpf_WD),
    .out(DM_DATA)
    );
	
	BE _BE(
    .Addr(AO_M[1:0]),
	.ins(IR_M),
    .BE(BE)
    );
	
	dm _dm (
	.Clk(Clk),
	.MemWr(MemWr_M),
	.WD(DM_DATA),
	.Addr(AO_M),
	.Reset(Reset),
	.RD(dm_RD),
	.IR_M(IR_M),
	.BE(BE)
	);




//W
	W_Reg w_reg(
    .IR(IR_M),
    .PC4(PC4_M),
    .AO(AO_M),
    .DR(dm_RD),
    .SH(SH_M),
    .Clk(Clk),
    .IR_W(IR_W),
    .PC4_W(PC4_W),
    .AO_W(AO_W),
    .DR_W(DR_W_temp),
    .SH_W(SH_W),
	.Reset(Reset)
    );
	
	BL _BL(
    .addr(AO_W),
	.ins(IR_W),
    .Din(DR_W_temp),
    .Dout(DR_W)
    );
	
	controla W_control(
	.ins(IR_W),
	.stage(STAGE_W),
	.RegDst(RegDst_W),
	.RegDst_2(RegDst_2_W),
	.grf_WDsrc(WDsrc_W),
	.WrReg(WrReg_W),
	.RegWr(RegWr_W),
	.generated(generated_W),
	.Cal_r(Cal_r_W),
	.Cal_i(Cal_i_W),
	.ld(ld_W),
	.st(st_W),
	.beq(beq_W),
	.j(j_W),
	.jal(jal_W),
	.jr(jr_W),
	.ALUout(AO_W)
    );
	
	mux2_5 A3src_mux(
	.d1(IR_W[15:11]),
	.d2(IR_W[20:16]),
	.src(RegDst_W),
	.out(A3_0)
	);
	
	mux2_5 A3src_mux2(
	.d1(A3_0),
	.d2(5'b11111),
	.src(RegDst_2_W),
	.out(A3)
	);
	
	
	mux4_32 WDsrc_mux(
	.d1(AO_W),
	.d2(DR_W),
	.d3(SH_W),
	.d4(PC4_W),
	.src(WDsrc_W),
	.out(gpf_WD)
	);
	
	
	
endmodule
