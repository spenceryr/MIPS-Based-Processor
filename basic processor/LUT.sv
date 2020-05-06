// CSE141L
// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
module LUT(
  input[1:0] addr,
  output logic[15:0] Target
  );

always_comb 
  case(addr)		   //-16'd30;
	2'b00:   Target = 16'hffff;//-1
	2'b01:	 Target = 16'h0f03;
	2'b10:	 Target = 16'h0003;
	default: Target = 16'h0;
  endcase

endmodule