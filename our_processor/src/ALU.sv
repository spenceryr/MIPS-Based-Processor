// Create Date:    2016.10.15
// Module Name:    ALU
// Project Name:   CSE141L
//
// Revision 2018.01.27
// Additional Comments:
//   combinational (unclocked) ALU
import definitions::*;			  // includes package "definitions"
module ALU(
  input [ 7:0] INPUTA,      	  // data inputs
               INPUTB,
  input [ 2:0] OP,				  // ALU opcode, part of microcode
  input        C_IN,             // shift in/carry in
  input        S_IN,
  output logic [7:0] OUT,		  // or:  output reg [7:0] OUT,
  output logic C_OUT,			  // shift out/carry out
  output logic S_OUT,
  output logic ZERO              // zero out flag
    );

  op_mne op_mnemonic;			  // type enum: used for convenient waveform viewing

  logic SH_1;

  always_comb
    case(INPUTB)
      'b1:     SH_1 = 'b1;
      default: SH_1 = 'b0;
    endcase

  always_comb begin
    {C_OUT, OUT} = 'b0;            // default -- clear carry out and result out
// single instruction for both LSW & MSW
    case(OP)
    kADD : {S_OUT, C_OUT, OUT} = {1'b0, {1'b0,INPUTA} + INPUTB + C_IN};  // add w/ carry-in & out
    kSUB : {S_OUT, C_OUT, OUT} = {1'b0, 1'b0, INPUTA + (~INPUTB) + C_IN};
    kSHL :  if (SH_1)
                {C_OUT, S_OUT, OUT} = {1'b0, INPUTA[7], INPUTA[6:0], S_IN};
            else
                {C_OUT, S_OUT, OUT} = {1'b0, 1'b0, INPUTA << INPUTB};
    kSHR :  if (SH_1)
                {C_OUT, S_OUT, OUT} = {1'b0, INPUTA[0], S_IN, INPUTA[7:1]};
            else
                {C_OUT, S_OUT, OUT} = {1'b0, 1'b0, INPUTA >> INPUTB};
    kXOR : {S_OUT, C_OUT, OUT} = {1'b0, 1'b0, INPUTA^INPUTB};
    kAND : {S_OUT, C_OUT, OUT} = {1'b0, 1'b0, INPUTA&INPUTB};
    kOR  : {S_OUT, C_OUT, OUT} = {1'b0, 1'b0, INPUTA|INPUTB};
    kPASS : {S_OUT, C_OUT, OUT} = {1'b0, 1'b0, INPUTB};
    default: {S_OUT, C_OUT,OUT} = 'b0;						       // no-op, zero out
    endcase

    case(OUT)
      'b0     : ZERO = 1'b1;
      default : ZERO = 1'b0;
    endcase
	 op_mnemonic = op_mne'(OP);					  // displays operation name in waveform viewer
    //$display("%t %s %d %d = %d \n", $time, op_mnemonic, INPUTA, INPUTB, OUT);

  end        			  // note [0] -- look at LSB only
//    OP == 3'b101; //!INPUTB[0];
// always_comb	branch_enable = opcode[8:6]==3'b101? 1 : 0;
endmodule
