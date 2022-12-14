from tkinter import *
import re
from tkinter import filedialog, Tk
import os.path
from noArg import NoArgument
from arithmOneArg import ArithmeticOneArgument
from twoArg import TwoArguments
from stackInstr import StackInstruction
from oneArg import OneArgument

import sys

filename = "test"
fileexists = False
label = 0
program = []

classes = {
    1: NoArgument,
    2: ArithmeticOneArgument,
    3: TwoArguments
}


def asmtoint(args):
    if args[0] in StackInstruction.op_codes:
        instr = StackInstruction(args)
    elif args[0] in OneArgument.op_codes:
        instr = OneArgument(args)
    else:
        instr = classes[len(args)](args)
    return instr.assemble()


def decode(asm):
    try:
        instruction = asmtoint(asm)
        return str(instruction)
    except Exception as e:
        return str(e)


def openFile():
    global filename
    openfilename = filedialog.askopenfilename()
    if openfilename is not None:
        filename = openfilename
        asmfile = open(filename, "r")
        asmfile.seek(0)
        asmdata = asmfile.read()
        textArea.delete("1.0", "end - 1c")
        textArea.insert("1.0", asmdata)
        asmfile.close()
        filemenu.entryconfig(filemenu.index("Save"), state=NORMAL)
        frame.title("muCPU Assembler [" + filename + "]")
        frame.focus()


def saveFile():
    global filename
    asmdata = textArea.get("1.0", "end - 1c")
    asmfile = open(filename, "w")
    asmfile.seek(0)
    asmfile.truncate()
    asmfile.write(asmdata)
    asmfile.close()


def saveFileAs():
    global filename
    global fileexists
    saveasfilename = filedialog.asksaveasfilename()
    if saveasfilename is not None:
        filename = saveasfilename
        fileexists = True
        asmdata = textArea.get("1.0", "end - 1c")
        asmfile = open(filename, "w")
        asmfile.seek(0)
        asmfile.truncate()
        asmfile.write(asmdata)
        asmfile.close()
        filemenu.entryconfig(filemenu.index("Save"), state=NORMAL)
        frame.title("myCPU Assembler [" + filename + "]")
        frame.focus()


def exitApp():
    frame.destroy()
    sys.exit()


def get_instruction_list(asm):
    asm_split = re.split(" |, |\(|\)|:|\t", asm)
    args = []
    global label
    for i in range(len(asm_split)):
        if asm_split[i] != "":
            args.append(asm_split[i])
    print(args)
    if args[0] not in NoArgument.op_codes and args[0] not in OneArgument.op_codes and args[
        0] not in TwoArguments.op_codes and args[0] not in StackInstruction.op_codes and args[0] not in ['RET', 'JMP']:
        OneArgument.labels[args[0]] = label
        args = args[1:]
    if args[0] == 'RET':
        args = ['POP', 'PC']
    if args[0] == 'JMP':
        label = label + 2
        program.append(['PSH', 'PC'])
        program.append(['BRA', args[1]])
    else:
        label = label + 1
        program.append(args)


def compileASM():
    global filename
    global label
    global program
    label = 0
    cpu_out = ""
    program = []
    asm_in = textArea.get("1.0", END)
    asmlines = re.split("\n", asm_in)
    for i in range(len(asmlines)):
        if (asmlines[i] != ""):
            asmlines[i] = asmlines[i].upper()
            get_instruction_list(asmlines[i])
    for i in program:
        cpu_out += decode(i) + "\n"
    name, ext = os.path.splitext(filename)
    hexfilename = name + ".fic"
    hexfile = open(hexfilename, "w")
    hexfile.seek(0)
    hexfile.truncate()
    hexfile.write(cpu_out)
    hexfile.close()


Tk().withdraw()
frame = Toplevel()

scrollbar = Scrollbar(frame)
scrollbar.pack(side=RIGHT, fill=Y)
frame.title("myCPU Assembler [" + filename + "]")
textArea = Text(frame, height=30, width=100, padx=3, pady=3, yscrollcommand=scrollbar.set)
textArea.pack(side=RIGHT)
scrollbar.config(command=textArea.yview)

menubar = Menu(frame)
filemenu = Menu(menubar, tearoff=0)
filemenu.add_command(label="Open", command=openFile)
filemenu.add_command(label="Save", command=saveFile, state=DISABLED)
filemenu.add_command(label="Save as...", command=saveFileAs)
filemenu.add_command(label="Exit", command=exitApp)
menubar.add_cascade(label="File", menu=filemenu)
runmenu = Menu(menubar, tearoff=0)
runmenu.add_command(label="Compile", command=compileASM)
menubar.add_cascade(label="Run", menu=runmenu)
frame.config(menu=menubar)

frame.minsize(750, 450)
frame.maxsize(750, 450)
frame.mainloop()






