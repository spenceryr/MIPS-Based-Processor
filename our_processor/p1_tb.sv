// Create Date:   2017.01.25
// Design Name:   TopLevel Test Bench
// Module Name:   TopLevel_tb.v
//  CSE141L
// This is NOT synthesizable; use for logic simulation only
// Verilog Test Fixture created for module: TopLevel

module p1_tb;	     // Lab 17
  
  // program 1-specific variables
logic[11:1] d1_in[15];           // original messages
logic      p0, p8, p4, p2, p1;  // Hamming block parity bits
logic[15:0] d1_out[15];          // orig messages w/ parity inserted
logic[15:0] score1, case1;
  
  
logic clk   = 0,                 // clock source -- drives DUT input of same name
      reset = 1;	             // master reset -- drives DUT input of same name
wire  ack;
// Instantiate the Device Under Test (DUT)
  toplevel DUT (
	.CLK(clk),
	.START(reset),
	.DONE(ack)
  );

  
  
  
  
initial begin

  #10ns for(int i=0; i<256; i++) begin
    DUT.dp.dm.core[i] = 8'h0;	     // clear data_mem

  end
  
  // Initialize DUT's register file
  for(int j=0; j<4; j++)
    DUT.dp.rf.registers[j] = 8'b0;    // default -- clear it

  // preload memory with constants
  DUT.dp.dm.core[60] = 'd240;
  DUT.dp.dm.core[61] = 'd7;
  
  DUT.dp.dm.core[62] = 'd142;
  DUT.dp.dm.core[63] = 'd7;
  
  DUT.dp.dm.core[64] = 'd109;
  DUT.dp.dm.core[65] = 'd6;
  
  DUT.dp.dm.core[66] = 'd91;
  DUT.dp.dm.core[67] = 'd5;
  
  DUT.dp.dm.core[68] = 'd255;

  score1 = '0;
  case1  = '0;
// program 1
  for(int i=0;i<15;i++)	begin
    d1_in[i] = $random;        // create 15 messages
// copy 15 original messages into first 30 bytes of memory 
// rename "dm1" and/or "core" if you used different names for these
    DUT.dp.dm.core[2*i+1]  = {5'b0,d1_in[i][11:9]};
    DUT.dp.dm.core[2*i]    =       d1_in[i][ 8:1];
  end
  #10ns reset = 1'b1;
  #10ns reset   = 1'b0;          // pulse request to DUT
  wait(ack);                   // wait for ack from DUT
// generate parity for each message; display result and that of DUT
  $display("start program 1");
  $display();
  for(int i=0;i<15;i++) begin
    p8 = ^d1_in[i][11:5];
    p4 = (^d1_in[i][11:8])^(^d1_in[i][4:2]); 
    p2 = d1_in[i][11]^d1_in[i][10]^d1_in[i][7]^d1_in[i][6]^d1_in[i][4]^d1_in[i][3]^d1_in[i][1];
    p1 = d1_in[i][11]^d1_in[i][ 9]^d1_in[i][7]^d1_in[i][5]^d1_in[i][4]^d1_in[i][2]^d1_in[i][1];
    p0 = ^d1_in[i]^p8^p4^p2^p1;  // overall parity (16th bit)
// assemble output (data with parity embedded)
    $displayb ({d1_in[i][11:5],p8,d1_in[i][4:2],p4,d1_in[i][1],p2,p1,p0});
    $writeb  (DUT.dp.dm.core[31+2*i]);
    $displayb(DUT.dp.dm.core[30+2*i]);
    if({DUT.dp.dm.core[31+2*i],DUT.dp.dm.core[30+2*i]} == {d1_in[i][11:5],p8,d1_in[i][4:2],p4,d1_in[i][1],p2,p1,p0}) begin
      $display(" we have a match!");
      score1++;
    end
    else
      $display("erroneous output");   
    $display();
    case1++;
  end
  $display("program 1 score = %d out of %d",score1,case1);
end
always begin   // clock period = 10 Verilog time units
  #5ns  clk = 1;
  #5ns  clk = 0;
end
endmodule 
  /*
initial begin
  START = 1;
// Initialize DUT's data memory

  
  
  
// students may also pre_load desired constants into data_mem




  // program 2 constants
 // DUT.dp.dm.core[6] = 'd128;
 // DUT.dp.dm.core[7] = 'd252;
 // DUT.dp.dm.core[8] = 'd248;
  


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
*/




