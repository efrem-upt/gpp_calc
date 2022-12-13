from instr import Instruction


class OneArgument(Instruction):
    op_codes = {
        "BRZ": "000110",
        "BRN": "000111",
        "BRC": "001000",
        "BRO": "001001",
        "BRA": "001010"
    }

    labels = {

    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])
        self.arg1 = arg_list[1]

    def assemble(self):
        result = OneArgument.op_codes[self.instruction]
        result = result + '{0:010b}'.format(int(OneArgument.labels[self.arg1]))
        return result
