import sys
import io
from collections import defaultdict

USAGE = "Usage: python cith_assembler <in file> [optional:<out file>]"

LUT_NAMES = ["r1_lut", "r2_lut", "a1_lut", "a2_lut"]

LUT_OUTS = ["rel_lut_out1", "rel_lut_out2", "abs_lut_out1", "abs_lut_out2"]

LUT_STR = "LUT_16 #(.c0({}), .c1({}), .c2({}), .c3({}),\n\
         .c4({}), .c5({}), .c6({}), .c7({}),\n\
         .c8({}), .c9({}), .c10({}), .c11({}),\n\
         .c12({}), .c13({}), .c14({}), .c15({})) {} (.in(lut_in), .out({}));"

INSTRUCTIONS = {"addr": (0, ("r", "r"), 0), "subr": (0, ("r", "r"), 1), "addi": (1, ("r", "i3"), -1),
                "subi": (2, ("r", "i3"), -1), "shr": (3, ("r", "i3"), -1), "shl": (4, ("r", "i3"), -1),
                "and": (5, ("r", "r"), 0), "or": (5, ("r", "r"), 1), "andi": (6, ("r", "i3"), -1),
                "xor": (7, ("r", "r"), 0), "beqz": (8, ("i5",), -1), "bneqz": (9, ("i5",), -1),
                "jmp": (10, ("i5",), -1), "load": (11, ("r", "r"), 0), "store": (11, ("r", "r"), 1),
                "move": (12, ("r", "r"), 0), "call": (13, ("i5",), -1), "ret": (14, (), -1),
                "rshl": (15, ("r", "r"), 0)}

# LUT_VALS = {"calculate_parity": 0, "loop1": 1, "loop2": 3, "main": 5, "p3_main": 6, "bit_loop": 7,
#         "inc_anywhere_counter": 8, "after_pattern_match": 9, "after_byte_check": 10, "last_byte": 11,
#         "last_byte_bit_loop": 12, "after_last_pattern_check": 13, "p3_done": 14,
#
#         "main2": 16, "loop_parity": 17, "b_6": 14, "b_7": 10, "b_8": 18, "store_second": 16,
#         "b_4": 2, "calc_incorrect": 17, "loop_3_bits": 18, "loop_bits_3_end": 19, "loop_bits": 19,
#         "loop_bits_end": 20, "shift_msg_1": 21, "shift_msg_2": 22}

LINKS = {}

NEED_LINK = defaultdict(list)

REL_LUT = []

ABS_LUT = []

REGISTERS = {"$r1": 0, "$r2": 1, "$r3": 2, "$r4": 3}

FUNCTION = {"calculate_parity": 0}

# CONSTANTS = {}

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

class CithLinkError(Exception):
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

def instr_to_mc(instr, line, line_num):
    op_code = None
    args_struct = None
    f_code = None
    args = ""
    print(instr)
    if instr[0] in LINKS and instr[1] == ":":
        instr = instr[2:]
    elif instr[0] not in LINKS and instr[1] == ":":
        raise CithParseError("Invalid label", line, line_num)

    if instr[0] in INSTRUCTIONS:
        op_code, args_struct, f_code = INSTRUCTIONS[instr[0]]
        op_code = '{0:04b}'.format(op_code)
        instr = instr[1:]
    else:
        raise CithParseError("Invalid instruction \"{}\"".format(instr[0]), line, line_num)

    comma = False
    arg_num = 0
    if args_struct == ():
        args += "00000"

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
                raise CithParseError("Expected register but got {}".format(a), line, line_num)
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

def link_rel(l, ic):
    if l[-1] not in LINKS:
        NEED_LINK[l[-1]].append((ic, "rel"))
        return
    lic = LINKS[l[-1]]
    dist = lic - ic
    if dist not in REL_LUT:
        REL_LUT.append(dist)
        assert(len(REL_LUT) < 33)
    l[-1] = str(REL_LUT.index(dist))

def link_abs(l, ic):
    if l[-1] not in LINKS:
        NEED_LINK[l[-1]].append((ic, "abs"))
        return
    lic = LINKS[l[-1]]
    if lic not in ABS_LUT:
        ABS_LUT.append(lic)
        assert(len(ABS_LUT) < 33)
    l[-1] = str(ABS_LUT.index(lic))

def create_link(l, ic, instrs, line, i):
    try:
        int(l[0][0])
        raise CithParseError("Labels must not begin with a number", line, i)
    except ValueError:
        pass
    if l[1] != ":":
        raise CithParseError("Labels must be followed by a \":\"", line, i)
    if l[0] in LINKS:
        raise CithLinkError("Label {} already in use".format(l[0]), line, i)
    LINKS[l[0]] = ic
    if l[0] in NEED_LINK:
        for (nic, t) in NEED_LINK[l[0]]:
            if t == "abs":
                link_abs(instrs[nic-1][0], nic)
            else:
                link_rel(instrs[nic-1][0], nic)
        del NEED_LINK[l[0]]



def build_list(filename):
    machine_code = []
    instrs = []
    results = []
    ic = 0
    with open(filename, 'rb') as f:
        for i, line in enumerate(f, start=1):
            l = split_line(line.decode("ascii").lower())
            if (l != []):
                ic += 1
                if ":" in l:
                    create_link(l, ic, instrs, line.decode("ascii"), i)
                    if l[2:] == []:
                        ic -= 1
                        continue
                if "beqz" in l or "bneqz" in l:
                    link_rel(l, ic)
                elif "call" in l or "jmp" in l:
                    link_abs(l, ic)
                instrs.append((l, line.decode("ascii"), i))

    if NEED_LINK:
        raise CithLinkError("The following have no labels to branch/jump to: {}".format(list(NEED_LINK.keys())), "", 0)
    for l, line, i in instrs:
        results.append(instr_to_mc(l, line, i))

    return results


def main():
    if len(sys.argv) > 3 or len(sys.argv) < 2:
        print(USAGE)
    in_file = sys.argv[1]
    if len(sys.argv) == 3:
        out_file = sys.argv[2]
    else:
        out_file = None

    instrs = build_list(in_file)
    print(REL_LUT)
    print(ABS_LUT)

    luts = [REL_LUT[:16], REL_LUT[16:], ABS_LUT[:16], ABS_LUT[16:]]
    for l, lut_name, lut_out in zip(luts, LUT_NAMES, LUT_OUTS):
        l.extend([0] * (16-len(l)))
        l.append(lut_name)
        l.append(lut_out)

    if out_file:
        with open(out_file, 'w') as f:
            for i in instrs:
                f.write(i + "\n")
    else:
        for i in instrs:
            print(i)

    with open("lut_defs.txt", "w") as f:
        for lut in luts:
            f.write(LUT_STR.format(*lut) + "\n")


if __name__ == "__main__":
    main()
