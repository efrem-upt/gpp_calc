from instr import Instruction


class NoArgument(Instruction):
    op_codes = {
        "TRX": "000000",
        "TRY": "000001",
        "NOP": "111111"
    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])

    def assemble(self):
        result = NoArgument.op_codes[self.instruction]
        result = result + '{0:010b}'.format(0)
        return result
