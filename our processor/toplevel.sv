module toplevel (
    input CLK,
    input START,
    output DONE
);

logic RESET,
      HALT,
      CTRL_branch_rel_nz,
      CTRL_branch_rel_z,
      CTRL_branch_abs,
      CTRL_reg_write_en,
      CTRL_mem_to_reg,
      CTRL_alu_src,
      CTRL_alu_sc_in,
      CTRL_read_mem,
      CTRL_write_mem,
      fcode;
logic [2:0] CTRL_alu_op;
logic [3:0] opcode;

datapath dp (.*);


controlpath cp (.*);

endmodule