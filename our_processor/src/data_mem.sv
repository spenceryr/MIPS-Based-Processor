// Create Date:    2017.01.25
// Design Name:
// Module Name:    DataRAM
// single address pointer for both read and write
// CSE141L
module data_mem(
  input              CLK,
  input [7:0]        DataAddress,
  input              ReadMem,
  input              WriteMem,
  input [7:0]        DataIn,
  output logic[7:0]  DataOut);

  logic [7:0] core[256];

  always_comb                     // reads are combinational
    if(ReadMem) begin
      DataOut = core[DataAddress];
	  //$display("Memory read M[%d] = %d",DataAddress,DataOut);
    end
    else
      DataOut = 'bZ;           // tristate, undriven

  always_ff @ (posedge CLK)		 // writes are sequential
	if(WriteMem) begin
      core[DataAddress] <= DataIn;
	  //$display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule
