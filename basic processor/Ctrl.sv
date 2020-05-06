// CSE141L
import definitions::*;
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[ 8:0] Instruction,	   // machine code
  input       ZERO,			   // ALU out[7:0] = 0
              BEVEN,		   // ALU out[0]   = 0
  output logic jump_en,
               branch_en
  );
// jump on right shift that generates a zero
always_comb
  if((Instruction[2:0] ==  kRSH) && ZERO)
    jump_en = 1;
  else
    jump_en = 0;

// branch every time ALU result LSB = 0 (even)
assign branch_en = BEVEN;

endmodule

   // ARM instructions sequence
   //				cmp r5, r4
   //				beq jump_label