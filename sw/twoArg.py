from instr import Instruction


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
        "MOV": "010111"
    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])
        self.arg1 = arg_list[1]
        self.arg2 = int(arg_list[2])

    def assemble(self):
        result = TwoArguments.op_codes[self.instruction]
        result = result + Instruction.registers[self.arg1]
        result = result + '{0:09b}'.format(self.arg2)
        return result