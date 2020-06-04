// Create Date:    15:50:22 10/02/2016
// Design Name:
// Module Name:    InstROM
// Project Name:   CSE141L
// Tool versions:
// Description: Verilog module -- instruction ROM template
//	 preprogrammed with instruction values (see case statement)
//
// Revision:
//
module InstROM #(parameter A=16, W=9) (
  input       [A-1:0] InstAddress,
  output logic[W-1:0] InstOut);

// alternative expression
//   need $readmemh or $readmemb to initialize all of the elements
  logic[W-1:0] inst_rom[2**(A)];

  always_comb begin
	InstOut = inst_rom[InstAddress];
  end


  initial begin		                  // load from external text file
  	$readmemb("our_processor\\all_programs.txt",inst_rom);
  end

endmodule
