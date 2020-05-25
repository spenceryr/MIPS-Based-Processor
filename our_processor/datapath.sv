import definitions::*;
module datapath(
    input CLK,
          START,
          CTRL_branch_rel_nz,
          CTRL_branch_rel_z,
          CTRL_branch_abs,
          CTRL_reg_write_en,
          CTRL_reg_sel,
          CTRL_lut_in,
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
logic [7:0] mem_data_out;
logic [7:0] reg_write_data;
logic [7:0] reg_a_in;
logic [7:0] reg_a_out, reg_b_out;
logic [15:0] rel_lut_out, abs_lut_out,
             rel_lut_out1, abs_lut_out1, rel_lut_out2, abs_lut_out2;
logic [3:0] lut_in;
logic lut_sel;

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

// rel LUTs
LUT_16 #(.c0(0), .c1(4), .c2(0), .c3(5),
         .c4(0), .c5(0), .c6(0), .c7(0),
         .c8(0), .c9(0), .c10(0), .c11(0),
         .c12(0), .c13(0), .c14(0), .c15(0)) r1_lut (.in(lut_in), .out(rel_lut_out1));
LUT_16 #(.c0(0), .c1(0), .c2(0), .c3(0),
         .c4(0), .c5(0), .c6(0), .c7(0),
         .c8(0), .c9(0), .c10(0), .c11(0),
         .c12(0), .c13(0), .c14(0), .c15(0)) r2_lut (.in(lut_in), .out(rel_lut_out2));
			
// abs LUTs
LUT_16 #(.c0(0), .c1(21), .c2(31), .c3(36),
         .c4(4), .c5(5), .c6(6), .c7(7),
         .c8(8), .c9(9), .c10(10), .c11(11),
         .c12(12), .c13(13), .c14(14), .c15(15)) a1_lut (.in(lut_in), .out(abs_lut_out1));
LUT_16 #(.c0(16), .c1(26), .c2(2), .c3(3),
         .c4(4), .c5(5), .c6(6), .c7(7),
         .c8(8), .c9(9), .c10(10), .c11(11),
         .c12(12), .c13(13), .c14(14), .c15(15)) a2_lut (.in(lut_in), .out(abs_lut_out2));

always_comb
    if (lut_sel) begin
        rel_lut_out = rel_lut_out2;
        abs_lut_out = abs_lut_out2;
    end
    else begin
        rel_lut_out = rel_lut_out1;
        abs_lut_out = abs_lut_out1;
    end

always_comb
    if (CTRL_lut_in)
        {lut_in, lut_sel} = reg_a_out[4:0];
    else
        {lut_in, lut_sel} = instr_out[4:0];


always_comb
    if (CTRL_branch_rel_nz | CTRL_branch_rel_z)
        PC_target = rel_lut_out;
    else if (CTRL_reg_sel & CTRL_reg_write_en)
        PC_target = 'd32; // TODO: REPLACE WITH PC LOCATION FOR FUNCTION
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

always_comb
    if (CTRL_reg_sel)
        reg_a_in = REG_PC;
    else
        reg_a_in = {1'b0, instr_out[4:3]};


reg_file rf (.CLK(CLK),
				 .reset(START),
             .write_en(CTRL_reg_write_en),
             .raddrA(reg_a_in),
             .raddrB({1'b0, instr_out[2:1]}),
             .waddr(reg_a_in),
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
    else if (CTRL_reg_sel & CTRL_reg_write_en)
        reg_write_data = {3'b0, instr_out[4:0]};
    else
        reg_write_data = ALU_out;


endmodule
