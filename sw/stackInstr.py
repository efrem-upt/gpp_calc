from instr import Instruction


class StackInstruction(Instruction):
    op_codes = {
        "PSH": "000100",
        "POP": "000101"
    }

    registers = {
        "X": "00",
        "Y": "01",
        "ACC": "10",
        "PC": "11"
    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])
        self.arg1 = arg_list[1]

    def assemble(self):
        result = StackInstruction.op_codes[self.instruction]
        result = result + StackInstruction.registers[self.arg1]
        result = result + '{0:08b}'.format(0)
        return result
