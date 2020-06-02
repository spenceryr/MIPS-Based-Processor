// Create Date:   2017.01.25
// Design Name:   TopLevel Test Bench
// Module Name:   TopLevel_tb.v
//  CSE141L
// This is NOT synthesizable; use for logic simulation only
// Verilog Test Fixture created for module: TopLevel

module simple_tb;	     // Lab 17

// To DUT Inputs
  bit START;
  bit CLK;

// From DUT Outputs
  logic DONE;		   // done flag

// Instantiate the Device Under Test (DUT)
  toplevel DUT (
	.CLK(CLK),
	.START(START),
	.DONE(DONE)
  );

initial begin
  START = 1;
// Initialize DUT's data memory

  #10ns for(int i=0; i<256; i++) begin
    DUT.dp.dm.core[i] = 8'h0;	     // clear data_mem

  end


// students may also pre_load desired constants into data_mem
  DUT.dp.dm.core[0] = 'd85;
  DUT.dp.dm.core[1] = 'd5;


  DUT.dp.dm.core[60] = 'd240;
  DUT.dp.dm.core[61] = 'd7;

  DUT.dp.dm.core[62] = 'd142;
  DUT.dp.dm.core[63] = 'd7;

  DUT.dp.dm.core[64] = 'd109;
  DUT.dp.dm.core[65] = 'd6;

  DUT.dp.dm.core[66] = 'd91;
  DUT.dp.dm.core[67] = 'd5;

  DUT.dp.dm.core[68] = 'd255;



// Initialize DUT's register file
  for(int j=0; j<4; j++)
    DUT.dp.rf.registers[j] = 8'b0;    // default -- clear it
// students may pre-load desired constants into the reg_file

// launch program in DUT
  #10ns START = 0;

// Wait for done flag, then display results
  wait (DONE);
  #10ns $display(DUT.dp.dm.core[5],
                  DUT.dp.dm.core[6],"_",
                  DUT.dp.dm.core[7],
                  DUT.dp.dm.core[8]);
  $display("DONE");

  #100ns $stop;
end

always begin   // clock period = 10 Verilog time units
  #5ns  CLK = 1;
  #5ns  CLK = 0;
end

endmodule
