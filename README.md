# MIPS Pipelined Processor
<p align="center">
  <a style="text-decoration:none" >
    <img src="https://img.shields.io/badge/Parser Language-Python-blue" alt="Parser Badge" />
  </a>
  <a style="text-decoration:none" >
    <img src="https://img.shields.io/badge/Language-VHDL-blue" alt="Language Badge" />
  </a>
  <a style="text-decoration:none" >
    <img src="https://img.shields.io/badge/Simulation Tool-ModelSim-green" alt="Simulation Tool Badge" />
  </a>
</p>

This is a simple pipelined processor that serves as the project for the Computer Architecture course (CMP 3010) taught at Cairo University.

## Implemented Instructions
### ☝️ One Operand
```
NOP
HLT
SETC
NOT Rdst
INC Rdst
OUT Rdst
IN Rdst
```
### ✌️ Two Operands
```
MOV Rsrc, Rdst
ADD Rdst, Rsrc1, Rsrc2
SUB  Rdst, Rsrc1, Rsrc2
AND  Rdst, Rsrc1, Rsrc2
IADD Rdst, Rsrc2 ,Imm
```

### 💾 Memory
```
PUSH  Rdst
POP  Rdst
LDM  Rdst, Imm
LDD  Rdst, offset(Rsrc)
STD Rsrc1, offset(Rsrc2)
```

### 🦘 Jumps
```
JZ  Rdst
JN  Rdst
JC Rdst
JMP  Rdst
```

 - Data forwarding is missing
 - Two types of Exceptions are implemented (one related to stack memory and the other to data memory)
