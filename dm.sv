// Create Date:    2017.05.05
// Latest rev:     2019.04.13
// Created by:     J Eldon
// Design Name:    CSE141L
// Module Name:    dm  (Data Memory)

// Generic data memory design for CSE141L projects
// width = 8 bits (per assignment spec.)
// depth = 2**W (default value of W = 8)
module dm #(parameter AW=8)(
  input              clk,                // clock
  input    [AW-1:0]  MemAdr,  		     // address pointer
  input              ReadEn,			 // read enable	(may be tied high)
  input              WriteEn,			 // write enable
  input       [7:0]  DatIn, 			 // data to store (write into memory)
  output logic[7:0]  DatOut);			 //	data to load (read from memory)

  logic [7:0] core [2**AW]; 	     	 // create array of 2**AW elements (default = 256)

// optional initialization of memory, e.g. seeding with constants
//  initial 
//    $readmemh("dataram_init.list", my_memory);

// read from memory, e.g. on load instruction
  always_comb							 // reads are immediate/combinational
    if(ReadEn) begin
      DatOut = core[MemAdr];
// optional diagnostic print statement:
//	  $display("Memory read M[%d] = %d",DataAddress,DataOut);
    end else 
      DatOut = 8'bZ;			         // z denotes high-impedance/undriven

// write to memory, e.g. on store instruction
  always_ff @ (posedge clk)	             // writes are clocked / sequential
    if(WriteEn) begin
      core[MemAdr] <= DatIn;
//	  $display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule
