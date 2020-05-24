import definitions::*;
module controlpath (
    input [3:0] opcode,
    input DONE,
          fcode,
    output logic CTRL_branch_rel_nz, //
                 CTRL_branch_rel_z, //
                 CTRL_branch_abs, //
                 CTRL_reg_write_en, //
                 CTRL_reg_sel,
                 CTRL_lut_in,
                 CTRL_mem_to_reg, //
                 CTRL_alu_src, //
                 CTRL_alu_sc_in, //
                 CTRL_read_mem, //
                 CTRL_write_mem, //
    output logic [2:0] CTRL_alu_op
);

always_comb
    if (DONE)
        CTRL_mem_to_reg = 1'b0;
    else
        casez({opcode, fcode})
        cLOAD  : CTRL_mem_to_reg = 1'b1;
        default: CTRL_mem_to_reg = 1'b0;
        endcase

always_comb
    if (DONE)
        CTRL_reg_sel = 1'b0;
    else
        casez({opcode, fcode})
        cCALL, cRET: CTRL_reg_sel = 1'b1;
        default    : CTRL_reg_sel = 1'b0;
        endcase

always_comb
    if (DONE)
        CTRL_lut_in = 1'b0;
    else
        casez({opcode, fcode})
        cRET   : CTRL_lut_in = 1'b1;
        default: CTRL_lut_in = 1'b0;
        endcase

always_comb
    if (DONE)
        {CTRL_branch_rel_nz, CTRL_branch_rel_z, CTRL_branch_abs} = 3'b0;
    else
        casez({opcode, fcode})
        cBEQZ          : {CTRL_branch_rel_nz, CTRL_branch_rel_z, CTRL_branch_abs} = {1'b0, 1'b1, 1'b0};
        cBNEQZ         : {CTRL_branch_rel_nz, CTRL_branch_rel_z, CTRL_branch_abs} = {1'b1, 1'b0, 1'b0};
        cJ, cCALL, cRET: {CTRL_branch_rel_nz, CTRL_branch_rel_z, CTRL_branch_abs} = {1'b0, 1'b0, 1'b1};
        default        : {CTRL_branch_rel_nz, CTRL_branch_rel_z, CTRL_branch_abs} = 3'b0;
endcase

always_comb
    if (DONE)
        {CTRL_read_mem, CTRL_write_mem} = {1'b0, 1'b0};
    else
        casez({opcode, fcode})
        cLOAD  : {CTRL_read_mem, CTRL_write_mem} = {1'b1, 1'b0};
        cSTORE : {CTRL_read_mem, CTRL_write_mem} = {1'b0, 1'b1};
        default: {CTRL_read_mem, CTRL_write_mem} = {1'b0, 1'b0};
endcase

always_comb
    if (DONE)
        CTRL_reg_write_en = 1'b0;
    else
        casez({opcode, fcode})
        cADDR, cSUBR, cADDI, cSUBI,
        cSHR, cSHL, cAND, cOR,
        cANDI, cXOR, cLOAD, cMOV,
        cCALL                   : CTRL_reg_write_en = 1'b1;
        default                 : CTRL_reg_write_en = 1'b0;
endcase

always_comb
    if (DONE)
        CTRL_alu_src = 1'b0;
    else
        casez({opcode, fcode})
        cADDI, cSUBI, cSHR, cSHL, cANDI: CTRL_alu_src = 1'b1;
        default                        : CTRL_alu_src = 1'b0;
endcase

always_comb
    if (DONE)
        CTRL_alu_sc_in = 1'b0;
    else
        casez({opcode, fcode})
        cSUBR, cSUBI: CTRL_alu_sc_in = 1'b1;
        default: CTRL_alu_sc_in = 1'b0;
endcase

always_comb
    if (DONE)
        CTRL_alu_op = kPASS;
    else
        casez({opcode, fcode})
        cADDR, cADDI: CTRL_alu_op = kADD;
        cSUBR, cSUBI: CTRL_alu_op = kSUB;
        cSHR: CTRL_alu_op = kSHR;
        cSHL: CTRL_alu_op = kSHL;
        cAND, cANDI: CTRL_alu_op = kAND;
        cOR: CTRL_alu_op = kOR;
        cXOR: CTRL_alu_op = kXOR;
        default CTRL_alu_op = kPASS;
endcase

endmodule
