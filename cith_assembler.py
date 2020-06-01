import sys
import io

USAGE = "Usage: python cith_assembler <in file> [optional:<out file>]"

INSTRUCTIONS = {"addr": (0, ("r", "r"), 0), "subr": (0, ("r", "r"), 1), "addi": (1, ("r", "i3"), -1),
                "subi": (2, ("r", "i3"), -1), "shr": (3, ("r", "i3"), -1), "shl": (4, ("r", "i3"), -1),
                "and": (5, ("r", "r"), 0), "or": (5, ("r", "r"), 1), "andi": (6, ("r", "i3"), -1),
                "xor": (7, ("r", "r"), 0), "beqz": (8, ("l",), -1), "bneqz": (9, ("l",), -1),
                "jmp": (10, ("l",), -1), "load": (11, ("r", "r"), 0), "store": (11, ("r", "r"), 1),
                "move": (12, ("r", "r"), 0), "call": (13, ("i5",), -1), "ret": (14, ("i5",), -1)}

LUT_VALS = {"calculate_parity": 0, "loop1": 1, "loop2": 3, "main": 5, "p3_main": 6, "bit_loop": 7,
        "inc_anywhere_counter": 8, "after_pattern_match": 9, "after_byte_check": 10, "last_byte": 11,
        "last_byte_bit_loop": 12, "after_last_pattern_check": 13, "p3_done": 14}

REGISTERS = {"$r1": 0, "$r2": 1, "$r3": 2, "$r4": 3}

class CithError(Exception):
    def __str__(self):
        return "CITH exception"

class CithParseError(Exception):
    def __init__(self, message, line, line_num):
        self.message = message
        self.line = line
        self.line_num = line_num
    
    def __str__(self):
        return self.message + " ({}):".format(self.line_num) + "\n\t" + self.line


def split_line(line):
    line = line.replace(":", " : ").replace(",", " , ")
    for i, c in enumerate(line):
        if c == "#":
            line = line[:i]
            break
    return line.split()

def parse_line(instr, line, line_num):
    op_code = None
    args_struct = None
    f_code = None
    args = ""
    print(instr)
    if instr[0] in LUT_VALS and instr[1] == ":":
        instr = instr[2:]
    elif instr[0] not in LUT_VALS and instr[1] == ":":
        raise CithParseError("Invalid label", line, line_num)
    
    if instr[0] in INSTRUCTIONS:
        op_code, args_struct, f_code = INSTRUCTIONS[instr[0]]
        op_code = '{0:04b}'.format(op_code)
        instr = instr[1:]
    else:
        raise CithParseError("Invalid instruction \"{}\"".format(instr[0]), line, line_num)
    
    comma = False
    arg_num = 0
    for a in instr:
        if (comma and a != ","):
            raise CithParseError("Expected comma between args", line, line_num)
        elif (comma):
            comma = not comma
            continue
        
        arg_type = args_struct[arg_num]
        if arg_type == "r":
            if a in REGISTERS:
                args += '{0:02b}'.format(REGISTERS[a])
            else:
                CithParseError("Expected register but got {}".format(a), line, line_num)
        elif arg_type[0] == "i":
            i_size = int(arg_type[1])
            try:
                a = int(a)
            except ValueError:
                raise CithParseError("Expected integer but got {}".format(a), line, line_num)
            
            if a >= 0 and a < 2**i_size:
                args += ('{0:0' + str(i_size) + 'b}').format(a)
            else:
                raise CithParseError("Integer immediate out of bounds, expected between or equal to 0 and {}".format(2**i_size-1), line, line_num)
        elif arg_type == "l":
        	if a in LUT_VALS:
        		args += '{0:05b}'.format(LUT_VALS[a])
        	else:
        		raise CithParseError("Not a valid label value", line, line_num)
        
        arg_num += 1
        comma = not comma
        
    if not comma and instr:
        raise CithParseError("Expected arg after comma", line, line_num)
    
    if arg_num != len(args_struct):
        raise CithParseError("Expected {} args but got {}".format(len(args_struct), arg_num), line, line_num)
    
    result = op_code + args + (str(f_code) if f_code != -1 else "")
  
    assert len(result) == 9
    
    return result


def build_list(filename):
    instrs = []
    with open(filename, 'rb') as f:
        for i, line in enumerate(f, start=1):
            l = split_line(line.decode("ascii").lower())
            if (l != []):
                instrs.append(parse_line(l, line.decode("ascii"), i))

    return instrs


def main():
    if len(sys.argv) > 3 or len(sys.argv) < 2:
        print(USAGE)
    in_file = sys.argv[1]
    if len(sys.argv) == 3:
        out_file = sys.argv[2]
    else:
        out_file = None
    
    instrs = build_list(in_file)
    
    if out_file:
        with open(out_file, 'w') as f:
            for i in instrs:
                f.write(i + "\n")
    else:
        for i in instrs:
            print(i)


if __name__ == "__main__":
    main()
