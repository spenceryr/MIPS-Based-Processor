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
  input        SC_IN,             // shift in/carry in 
  output logic [7:0] OUT,		  // or:  output reg [7:0] OUT,
  output logic SC_OUT,			  // shift out/carry out
  output logic ZERO,              // zero out flag
  output logic BEVEN              // LSB of input B = 0
    );
	 
  op_mne op_mnemonic;			  // type enum: used for convenient waveform viewing
	
  always_comb begin
    {SC_OUT, OUT} = 0;            // default -- clear carry out and result out
// single instruction for both LSW & MSW
  case(OP)
    kADD : {SC_OUT, OUT} = {1'b0,INPUTA} + INPUTB + SC_IN;  // add w/ carry-in & out
    kLSH : {SC_OUT, OUT} = {INPUTA, SC_IN};  	            // shift left 
	kRSH : {OUT, SC_OUT} = {SC_IN, INPUTA};			        // shift right
//  kRSH : {OUT, SC_OUT} = (INPUTA << 1'b1) | SC_IN;
 	kXOR : begin 
 	         OUT    = INPUTA^INPUTB;  	     			   // exclusive OR
			 SC_OUT = 0;					   		       // clear carry out -- possible convenience
		   end
    kAND : begin                                           // bitwise AND
             OUT    = INPUTA & INPUTB;
			 SC_OUT = 0;
		   end
    kSUB : begin
	         OUT    = INPUTA + (~INPUTB) + SC_IN;	       // check me on this!
			 SC_OUT = 0;                                   // check me on this!
	       end
    default: {SC_OUT,OUT} = 0;						       // no-op, zero out
  endcase
// option 2 -- separate LSW and MSW instructions
//    case(OP)
//	  kADDL : {SC_OUT,OUT} = INPUTA + INPUTB ;    // LSW add operation
//	  kLSAL : {SC_OUT,OUT} = (INPUTA<<1) ;  	  // LSW shift instruction
//	  kADDU : begin
//	            OUT = INPUTA + INPUTB + SC_IN;    // MSW add operation
//                SC_OUT = 0;   
//              end
//	  kLSAU : begin
//	            OUT = (INPUTA<<1) + SC_IN;  	  // MSW shift instruction
//                SC_OUT = 0;
//               end
//      kXOR  : OUT = INPUTA ^ INPUTB;
//	  kBRNE : OUT = INPUTA - INPUTB;   // use in conjunction w/ instruction decode 
//  endcase
	case(OUT)
	  'b0     : ZERO = 1'b1;
	  default : ZERO = 1'b0;
	endcase
//$display("ALU Out %d \n",OUT);
    op_mnemonic = op_mne'(OP);					  // displays operation name in waveform viewer
  end											
  always_comb BEVEN = OUT[0];          			  // note [0] -- look at LSB only
//    OP == 3'b101; //!INPUTB[0];               
// always_comb	branch_enable = opcode[8:6]==3'b101? 1 : 0;  
endmodule



	   /*
			Left shift

            
			  input a = 10110011   sc_in = 1

              output = 01100111
			  sc_out =	1

							   */