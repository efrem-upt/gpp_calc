from twoArg import TwoArguments


class ArithmeticOneArgument:
    def __init__(self, arg_list):
        self.instr = TwoArguments([arg_list[0], arg_list[1], 0])

    def assemble(self):
        return self.instr.assemble()
