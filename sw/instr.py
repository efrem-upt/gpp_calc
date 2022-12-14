from abc import ABC


class Instruction(ABC):
    registers = {
        "X": "0",
        "Y": "1"
    }

    def __init__(self, instr):
        self.instruction = instr

    def assemble(self):
        pass
