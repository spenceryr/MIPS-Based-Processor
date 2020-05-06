// priority encoder lookup table
// CSE141L
module LUT(
  input[5:0] addr,
//  output logic[15:0] Target
  output logic wr_mem,
  output logic alu_src,
  output logic br_cond,
  output logic read_me
  );

always_comb 
  casez(addr)		   //-16'd30;
	6'b00000?:   begin
       wr_mem  = 1'b0;
       alu_src = 1'b1;
       br_cond = 1'b1;
       read_me = 1'b0;
	end
    6'b00001?:	 
	begin
	end
	6'b0001??:	 
	6'b001???:
	6'b01????:
	6'b1?????:
	default: Target = 16'h0;
  endcase

endmodule