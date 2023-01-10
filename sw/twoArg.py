from instr import Instruction


def twos_complement(val, nbits):
    """Compute the 2's complement of int value val"""
    if val < 0:
        val = (1 << nbits) + val
    else:
        if (val & (1 << (nbits - 1))) != 0:
            # If sign bit is set.
            # compute negative value.
            val = val - (1 << nbits)
    return val


class TwoArguments(Instruction):
    op_codes = {
        "LDR": "000010",
        "STR": "000011",
        "ADD": "001101",
        "SUB": "001110",
        "LSR": "001111",
        "LSL": "010000",
        "MUL": "010001",
        "DIV": "010010",
        "MOD": "010011",
        "CMP": "010100",
        "INC": "010101",
        "DEC": "010110",
        "MOV": "010111",
        "AND": "010111",
        "OR": "011000",
        "XOR": "011001",
        "NOT": "011010",
        "RSR": "011011",
        "RSL": "011100",
        "FCT": "011101"
    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])
        self.arg1 = arg_list[1]
        if int(arg_list[2]) > 255 or int(arg_list[2]) < -256:
            raise Exception("Arguments must be [-256, 255]")
        self.arg2 = twos_complement(int(arg_list[2]), 9)

    def assemble(self):
        result = TwoArguments.op_codes[self.instruction]
        result = result + Instruction.registers[self.arg1]
        result = result + '{0:09b}'.format(self.arg2)
        return result