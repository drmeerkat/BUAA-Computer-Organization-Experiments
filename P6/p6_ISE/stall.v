`timescale 1ns / 1ps
`define rs 25:21
`define rt 20:16
`define rd 15:11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:31:54 12/02/2016 
// Design Name: 
// Module Name:    stall 
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
module stall(
	input [31:0] IR_D,
	input [31:0] IR_E,
	input [31:0] IR_M,
	input Cal_r_D,
	input Cal_i_D,
	input beq_D,
	input jr_D,
	input jal_D,
	input ld_D,
	input st_D,
	input sl_D,
	input md_D,
	input mt_D,
	input mf_D,
	input jalr_D,
	input jialc_D,
	input Cal_r_E,
	input Cal_i_E,
	input beq_E,
	input jr_E,
	input jal_E,
	input ld_E,
	input st_E,
	input sl_E,
	input md_E,
	input mt_E,
	input mf_E,
	input lui_E,
	input ld_M,
	input start,
	input busy,
	output stall
    );
	wire stall_b, stall_calr, stall_cali, stall_ld, stall_st, stall_jr,stall_jalr, stall_ji, stall_sl, stall_m, temp;
	
	assign temp = (stall_b || stall_calr || stall_cali || stall_ld || stall_st || stall_jr || stall_jalr || stall_sl || stall_m || stall_ji);
	assign stall = (temp === 1'bx)? 0:temp;
	
	assign stall_b = beq_D && ((Cal_r_E && (IR_D[`rs] == IR_E[`rd]||IR_D[`rt] == IR_E[`rd]))
					  ||(Cal_i_E && (IR_D[`rs] == IR_E[`rt]||IR_D[`rt] == IR_E[`rt]))
					  ||(ld_E && (IR_D[`rs] == IR_E[`rt]||IR_D[`rt] == IR_E[`rt]))
					  ||(sl_E && (IR_D[`rs] == IR_E[`rd]||IR_D[`rt] == IR_E[`rd]))
					  ||(ld_M && (IR_D[`rs] == IR_M[`rt]||IR_D[`rt] == IR_M[`rt]))
					  ||(mf_E && (IR_D[`rs] == IR_E[`rd]||IR_D[`rt] == IR_E[`rd])));
	assign stall_calr = Cal_r_D && ld_E && (IR_D[`rs] == IR_E[`rt]||IR_D[`rt] == IR_E[`rt]);
	assign stall_cali = Cal_i_D && ld_E && (IR_D[`rs] == IR_E[`rt]);// ||IR_D[`rt] == IR_E[`rt] unsure
	assign stall_ld = ld_D && ld_E && IR_D[`rs] == IR_E[`rt];
	assign stall_st = st_D && ld_E && IR_D[`rs] == IR_E[`rt];
	assign stall_sl = sl_D && ld_E && IR_D[`rt] == IR_E[`rt];
	assign stall_jr = jr_D && ((Cal_r_E && IR_D[`rs] == IR_E[`rd])
					  ||(Cal_i_E && IR_D[`rs] == IR_E[`rt])
					  ||(sl_E && IR_D[`rs] == IR_E[`rd])
					  ||(ld_E && IR_D[`rs] == IR_E[`rt])
					  ||(ld_M && IR_D[`rs] == IR_M[`rt])
					  ||(mf_E && IR_D[`rs] == IR_E[`rd]));
	assign stall_jalr = jalr_D && ((Cal_r_E && IR_D[`rs] == IR_E[`rd])
					  ||(Cal_i_E && IR_D[`rs] == IR_E[`rt])
					  ||(sl_E && IR_D[`rs] == IR_E[`rd])
					  ||(ld_E && IR_D[`rs] == IR_E[`rt])
					  ||(ld_M && IR_D[`rs] == IR_M[`rt])
					  ||(mf_E && IR_D[`rs] == IR_E[`rd]));
	assign stall_ji = jialc_D && ((Cal_r_E && IR_D[`rt] == IR_E[`rd])
					  ||(Cal_i_E && IR_D[`rt] == IR_E[`rt])
					  ||(sl_E && IR_D[`rt] == IR_E[`rd])
					  ||(ld_E && IR_D[`rt] == IR_E[`rt])
					  ||(ld_M && IR_D[`rt] == IR_M[`rt])
					  ||(mf_E && IR_D[`rt] == IR_E[`rd]));
	assign stall_m = ((busy||start)&&(md_D||mf_D||mt_D))
				      ||(md_D && ld_E && (IR_D[`rs] == IR_E[`rt]||IR_D[`rt] == IR_E[`rt]))
					  ||(mt_D && ld_E && (IR_D[`rs] == IR_E[`rt]));

endmodule
