// Create Date:   2017.01.25
// Design Name:   TopLevel Test Bench
// Module Name:   TopLevel_tb.v
//  CSE141L
// This is NOT synthesizable; use for logic simulation only
// Verilog Test Fixture created for module: TopLevel

module p2_tb;	     // Lab 17

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

  DUT.dp.dm.core[64] = 'd70;
  DUT.dp.dm.core[65] = 'd153; // 4 198
  DUT.dp.dm.core[66] = 'd217;
  DUT.dp.dm.core[67] = 'd252; // 7 229
  DUT.dp.dm.core[68] = 'd236;
  DUT.dp.dm.core[69] = 'd49; // 129 15
  DUT.dp.dm.core[70] = 'd176;
  DUT.dp.dm.core[71] = 'd92; // 2 232
  DUT.dp.dm.core[72] = 'd219;
  DUT.dp.dm.core[73] = 'd55; // 0, 189
  DUT.dp.dm.core[74] = 'd42;
  DUT.dp.dm.core[75] = 'd73;
  DUT.dp.dm.core[76] = 'd23;
  DUT.dp.dm.core[77] = 'd32;
  DUT.dp.dm.core[78] = 'd127;
  DUT.dp.dm.core[79] = 'd242;
  DUT.dp.dm.core[80] = 'd58;
  DUT.dp.dm.core[81] = 'd194;
  DUT.dp.dm.core[82] = 'd39;
  DUT.dp.dm.core[83] = 'd1;
  DUT.dp.dm.core[84] = 'd244;
  DUT.dp.dm.core[85] = 'd93;
  DUT.dp.dm.core[86] = 'd166;
  DUT.dp.dm.core[87] = 'd73;
  DUT.dp.dm.core[88] = 'd164;
  DUT.dp.dm.core[89] = 'd48;
  DUT.dp.dm.core[90] = 'd144;
  DUT.dp.dm.core[91] = 'd109;
  DUT.dp.dm.core[92] = 'd52;
  DUT.dp.dm.core[93] = 'd183;

  DUT.dp.dm.core[203] = 'd64;
  DUT.dp.dm.core[204] = 'd94;
  DUT.dp.dm.core[205] = 'd0;
  DUT.dp.dm.core[206] = 'd0;
  DUT.dp.dm.core[207] = 'd0;
  DUT.dp.dm.core[208] = 'd0;
  DUT.dp.dm.core[209] = 'd0;
  DUT.dp.dm.core[210] = 'd0;


  // program 2 constants
 // DUT.dp.dm.core[6] = 'd128;
 // DUT.dp.dm.core[7] = 'd252;
 // DUT.dp.dm.core[8] = 'd248;


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

  #100us $stop;
end

always begin   // clock period = 10 Verilog time units
  #5ns  CLK = 1;
  #5ns  CLK = 0;
end

endmodule
