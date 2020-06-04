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

  logic p1_start = 0, p2_start = 0, p3_start = 0;

  always_ff @(posedge CLK)	  // or just always; always_ff is a linting construct
	if(Init) begin
      DONE <= '0;
      if (~p1_start) begin
        PC <= 'd66;
        p1_start <= '1;
      end
      else if (~p2_start) begin
        PC <= 'd299;
        p2_start <= '1;
      end
      else begin
        PC <= 'd609;
        p3_start <= '1;
      end
  end
	else if((PC == 'd299 & ~p2_start) | (PC == 'd609 & ~p3_start) | (PC == 'd772))
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
