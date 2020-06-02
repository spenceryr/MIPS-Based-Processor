//This file defines the parameters used in the alu
// CSE141L
package definitions;

// Instruction map
    const logic [2:0]kADD  = 3'b000;
    const logic [2:0]kSUB  = 3'b001;
    const logic [2:0]kSHR  = 3'b010;
    const logic [2:0]kSHL  = 3'b011;
    const logic [2:0]kAND  = 3'b100;
	const logic [2:0]kOR   = 3'b101;
	const logic [2:0]kXOR  = 3'b110;
    const logic [2:0]kPASS = 3'b111;

    const logic [2:0]REG_A = 3'b000;
    const logic [2:0]REG_B = 3'b001;
    const logic [2:0]REG_C = 3'b010;
    const logic [2:0]REG_D = 3'b011;
    const logic [2:0]REG_PC = 3'b100;

    const logic [4:0]cADDR  = 5'b00000; //000100000kADD
    const logic [4:0]cSUBR  = 5'b00001; //000100100kSUB
    const logic [4:0]cADDI  = 5'b0001?; //000101000kADD
    const logic [4:0]cSUBI  = 5'b0010?; //000101100kSUB
    const logic [4:0]cSHR   = 5'b0011?; //000101000kSHR
    const logic [4:0]cSHL   = 5'b0100?; //000101000kSHL
    const logic [4:0]cAND   = 5'b01010; //000100000kAND
    const logic [4:0]cOR    = 5'b01011; //000100000kOR
    const logic [4:0]cANDI  = 5'b0110?; //000101000kAND
    const logic [4:0]cXOR   = 5'b0111?; //000100000kXOR
    const logic [4:0]cBEQZ  = 5'b1000?; //010000000kPASS
    const logic [4:0]cBNEQZ = 5'b1001?; //100000000kPASS
    const logic [4:0]cJ     = 5'b1010?; //001000000kPASS
    const logic [4:0]cLOAD  = 5'b10110; //000110010kPASS
    const logic [4:0]cSTORE = 5'b10111; //000000001kPASS
    const logic [4:0]cMOV   = 5'b1100?; //000100000kPASS
    const logic [4:0]cCALL  = 5'b1101?; //001000000kPASS
    const logic [4:0]cRET   = 5'b1110?; //001000000kPASS
    const logic [4:0]cRSHL  = 5'b1111?; 
// enum names will appear in timing diagram
    typedef enum logic[2:0] {
        OP_ADD, OP_SUB, OP_RSH, OP_LSH, OP_AND,
        OP_OR, OP_XOR, OP_PASS} op_mne;

// note: kADD is of type logic[2:0] (3-bit binary)
//   ADD is of type enum -- equiv., but watch casting
//   see ALU.sv for how to handle this
endpackage // definitions
