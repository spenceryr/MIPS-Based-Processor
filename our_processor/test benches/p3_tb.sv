// Create Date:   2017.01.25
// Design Name:   TopLevel Test Bench
// Module Name:   TopLevel_tb.v
//  CSE141L
// This is NOT synthesizable; use for logic simulation only
// Verilog Test Fixture created for module: TopLevel

module p3_tb;	     // Lab 17

logic clk   = 0,                 // clock source -- drives DUT input of same name
      reset = 1;	             // master reset -- drives DUT input of same name
wire  ack;		    	         // ack -- from DUT -- done w/ program


// program 3-specific variables
logic[  7:0] cto,		       // how many bytes hold the pattern? (32 max)
             cts,		       // how many patterns in the whole string? (253 max)
		     ctb;		       // how many patterns fit inside any byte? (160 max)
logic        ctp;		       // flags occurrence of patern in a given byte
logic[  4:0] pat;              // pattern to search for
logic[255:0] str2; 	           // message string
logic[  7:0] mat_str[32];      // message string parsed into bytes

// Instantiate the Device Under Test (DUT)
  toplevel DUT (
	.CLK(clk),
	.START(reset),
	.DONE(ack)
  );

initial begin

// Initialize DUT's data memory

  #10ns for(int i=0; i<256; i++) begin
    DUT.dp.dm.core[i] = 8'h0;	     // clear data_mem

  end


// students may also pre_load desired constants into data_mem



 // program 3 constants
 DUT.dp.dm.core[6] = 'd128;
 DUT.dp.dm.core[7] = 'd252;
 DUT.dp.dm.core[8] = 'd248;

// Initialize DUT's register file
  for(int j=0; j<4; j++)
    DUT.dp.rf.registers[j] = 8'b0;    // default -- clear it
// students may pre-load desired constants into the reg_file



// program 3
// pattern we are looking for; experiment w/ various values
  pat = 5'b0000;//5'b10101;//$random;
  str2 = 0;
  DUT.dp.dm.core[160] = {pat,3'b0};   // store in upper 5 bits

  // populate memory with random bits
  for(int i=0; i<32; i++) begin
    // search field; experiment w/ various vales
    mat_str[i] = ($random)>>12;//8'b01010101;// $random;
    DUT.dp.dm.core[128+i] = mat_str[i];
  end

  // put pattern in specific locations
  mat_str[0] =  8'b00000000;
  DUT.dp.dm.core[128] = mat_str[0];


  // create string of bits for test bench algorithm
  for(int i = 0; i<32; i++) begin
    str2 = (str2<<8)+mat_str[i];
  end


  ctb = 0;
  for(int j=0; j<32; j++) begin
    if(pat==mat_str[j][4:0]) ctb++;
    if(pat==mat_str[j][5:1]) ctb++;
    if(pat==mat_str[j][6:2]) ctb++;
    if(pat==mat_str[j][7:3]) ctb++;
  end
  cto = 0;
  for(int j=0; j<32; j++)
    if((pat==mat_str[j][4:0]) | (pat==mat_str[j][5:1]) |
       (pat==mat_str[j][6:2]) | (pat==mat_str[j][7:3])) cto ++;
  cts = 0;
  for(int j=0; j<252; j++) begin
    if(pat==str2[255:251]) cts++;
	str2 = str2<<1;
  end
  #10ns reset   = 1'b1;      // pulse request to DUT
  #10ns reset   = 1'b0;
  wait(ack);               // wait for ack from DUT
  $display();
  $display("start program 3");
  $display();
  $display("number of patterns w/o byte crossing    = %d %d",ctb,DUT.dp.dm.core[192]);   //160 max
  $display("number of bytes w/ at least one pattern = %d %d",cto,DUT.dp.dm.core[193]);   // 32 max
  $display("number of patterns w/ byte crossing     = %d %d",cts,DUT.dp.dm.core[194]);   //253 max
end

always begin   // clock period = 10 Verilog time units
  #5ns  clk = 1;
  #5ns  clk = 0;
end
endmodule
