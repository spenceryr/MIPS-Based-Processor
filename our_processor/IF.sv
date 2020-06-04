module IF(
  input Branch_abs,		      // jump to Target value
  input Branch_rel_z,		  // jump to Target + PC
  input Branch_rel_nz,
  input ALU_zero,			  // flag from ALU
  input [15:0] Target,		  // jump ... "how high?"
  input Init,				  // reset, start, etc
  input CLK,				  // PC can change on pos. edges only
  output logic[15:0] PC,		  // program counter
  output logic DONE
  );

  always_ff @(posedge CLK)	  // or just always; always_ff is a linting construct
	if(Init)
      PC <= 'd66;				  // for first program; want different value for 2nd or 3rd
	else if(PC == 'd300)
	  DONE <= '1;
	else if(Branch_abs)	      // unconditional absolute jump
	  PC <= Target;
	else if(Branch_rel_z && ALU_zero) // conditional relative jump
	  PC <= Target + PC;
   else if(Branch_rel_nz && ~ALU_zero)
      PC <= Target + PC;

	else
	  PC <= PC+'d1;		      // default increment (no need for ARM/MIPS +4 -- why?)

endmodule
