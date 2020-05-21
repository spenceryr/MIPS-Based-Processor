import definitions::*;
module datapath(
    input CLK,
          START,
          CTRL_branch_rel_nz,
          CTRL_branch_rel_z,
          CTRL_branch_abs,
          CTRL_reg_write_en,
          CTRL_mem_to_reg,
          CTRL_alu_src,
          CTRL_alu_sc_in,
          CTRL_read_mem,
          CTRL_write_mem,
    input [2:0] CTRL_alu_op,
    output [3:0] opcode,
    output DONE,
           fcode
);


logic [7:0] ALU_out, ALU_in_b;
logic [15:0] PC, PC_target;
logic ALU_zero, ALU_c_out, ALU_s_out;
logic F_ZERO, F_C_OUT, F_S_OUT;
logic [8:0] instr_out;
logic [7:0] reg_write_data;
logic [7:0] reg_a_out, reg_b_out;
logic [15:0] rel_lut_out, abs_lut_out;

assign opcode = instr_out[8:5];
assign fcode = instr_out[0];


ALU_FLAGS af (.IN_ALU_ZERO(ALU_zero),
              .IN_C_OUT(ALU_c_out),
              .IN_S_OUT(ALU_s_out),
              .CLK(CLK),
              .reset(START),
              .OUT_ALU_ZERO(F_ZERO),
              .OUT_C_OUT(F_C_OUT),
              .OUT_S_OUT(F_S_OUT));

REL_LUT r_lut (.in(instr_out[4:0]), .out(rel_lut_out));
ABS_LUT a_lut (.in(instr_out[4:0]), .out(abs_lut_out));

always_comb
    if (CTRL_branch_rel_nz | CTRL_branch_rel_z)
        PC_target = rel_lut_out;
    else
        PC_target = abs_lut_out;

IF infet (.Branch_abs(CTRL_branch_abs),	   
  .Branch_rel_z(CTRL_branch_rel_z),
  .Branch_rel_nz(CTRL_branch_rel_nz),
  .ALU_zero(F_ZERO),
  .Target(PC_target),
  .Init(START),
  .CLK(CLK),
  .PC(PC),
  .DONE(DONE));

InstROM ir (.InstAddress(PC), .InstOut(instr_out));


reg_file rf (.CLK(CLK),
				 .reset(START),
             .write_en(CTRL_reg_write_en),
             .raddrA(instr_out[4:3]),
             .raddrB(instr_out[2:1]),
             .waddr(instr_out[4:3]),
             .data_in(reg_write_data),
             .data_outA(reg_a_out),
             .data_outB(reg_b_out));

always_comb
    if (CTRL_alu_src)
        ALU_in_b = {5'd0, instr_out[2:0]};
    else
        ALU_in_b = reg_b_out;

ALU alu (.INPUTA(reg_a_out),
         .INPUTB(ALU_in_b),
         .OP(CTRL_alu_op),
         .C_IN(CTRL_alu_sc_in),
         .S_IN(F_S_OUT),
         .OUT(ALU_out),
         .C_OUT(ALU_c_out),
         .S_OUT(ALU_s_out),
         .ZERO(ALU_zero));
         
data_mem dm (.CLK(CLK),
             .DataAddress(reg_b_out),
             .ReadMem(CTRL_read_mem),
             .WriteMem(CTRL_write_mem),
             .DataIn(reg_a_out),
             .DataOut(mem_data_out));

always_comb
    if (CTRL_mem_to_reg)
        reg_write_data = mem_data_out;
    else
        reg_write_data = ALU_out;
  
  
endmodule
  
  
  