// CSE141L  -- instruction ROM -- one approach
// no external file needed, but lots of 
// DW = machine code width (9 bits for class; 32 for ARM/MIPS)
// IW = program counter width, determines instruction memory depth
module InstROM #(parameter IW = 10, DW = 9)(
  input        [IW-1:0] InstAddress,	// address pointer
  output logic [DW-1:0] InstOut);

  logic [DW-1:0] inst_rom [2**IW];	    // automatically size to pointer width

  // load machine code program into instruction ROM
/* alternative version:  
  initial begin
	$readmemb("C:/Users/riyang liu/Desktop/CSE-141L-lab4/CSE-141L-master/binary9.txt",out);
  end
*/
// create the array
  initial begin
    inst_rom[ 0] = 0111_01_000;
    inst_rom[ 1] = 0111_01_000;
    inst_rom[ 2] = 0111_01_111;
    inst_rom[ 3] = 0000_11_110;
    inst_rom[ 4] = 0000_11_110;
    inst_rom[ 5] = 0101_11_000;
    inst_rom[ 6] = 0101_11_000;
    inst_rom[ 7] = 0101_11_111;
    inst_rom[ 8] = 0011_11_010;
    inst_rom[ 9] = 0011_11_011;
    inst_rom[10] = 0011_11_100;
    inst_rom[11] = 0011_01_100;
    inst_rom[12] = 0000_01_111;
    inst_rom[13] = 0000_01_001;
    inst_rom[14] = 0101_11_010;
    inst_rom[15] = 0101_11_100;
    inst_rom[16] = 1001_01_000;
    inst_rom[17] = 0011_01_100;
    inst_rom[18] = 0000_01_010;
    inst_rom[19] = 0110_11_010;
    inst_rom[20] = 0100_00_101;
    inst_rom[21] = 0000_00_011;
    inst_rom[22] = 0001_01_100;
    inst_rom[23] = 0010_01_101;
    inst_rom[24] = 0000_01_101;
    inst_rom[25] = 0000_10_101;
    inst_rom[26] = 1001_10_101;
    inst_rom[27] = 0100_00_101;
    inst_rom[28] = 0011_00_101;
    inst_rom[29] = 1001_00_101;
// ...
  end
// continuous combinational read output
// change the pointer (from program counter) ==> change the output
  assign InstOut = inst_rom[InstAddress];
endmodule