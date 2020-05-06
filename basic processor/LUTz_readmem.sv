module LUT(
  input[5:0] addr,
//  output logic[15:0] Target
  output logic wr_mem,
  output logic alu_src,
  output logic br_cond,
  output logic read_me
  );

  logic[3:0] internal_vector;
  logic[3:0] int_array[2**6];
  always_comb {wr_mem,alu_src,br_cond,read_me} = internal_vector; 

  initial begin
    $readmemb("machine_code.txt",int_array);

  always_comb
    internal_vector = int_array[addr];

  endmodule