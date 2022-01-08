
from os import environ
import sys
import re

print('')

if len(sys.argv) != 2:
  print(f'Usage: python {sys.argv[0]} PATH_TO_ASM_FILE')
  exit(0)

file = sys.argv[1]

file = open(file, 'rt')

print(f'Assembling {file.name} ....')

mem = {}

Rd = 15-9
R1 = 15-6
R2 = 15-3
T  = 15-0

curr = -1

outp = open(f'{file.name[:-3]}do', "wt")

outp.write('''
vsim work.integration(arc_integration)

view wave

add log -r /*

add wave -position insertpoint  \
sim:/integration/clk \
sim:/integration/rst \
sim:/integration/port_inp \
sim:/integration/port_outp
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 

run
run
force -freeze sim:/integration/rst 0 0

mem load -skip 0 -filltype value -filldata 0 -fillradix symbolic /integration/fetch/InstructionMemory/ram
''')

for line in file:
  if len(line) < 2 or line.startswith('#'):
    continue

  
  wrds = line.strip().replace(',', ' ').replace('(', ' ').replace(')', ' ').split(' ')
  # wrds = re.split(', | ', line)

  print(wrds)

  # print(line[0:5])
  if wrds[0] == '.ORG':
    curr = int(wrds[1], base=16)
    continue

## One Operand

  # NOP	00000
  # HLT	00001
  # SETC	00010
  # NOT Rdst	00011
  # INC Rdst	00100
  # OUT R2 00101
  # IN Rdst	00110

  elif wrds[0]=='SETC':
    mem[curr] = '0000100000000000'
    
  elif wrds[0]=='NOP':
    mem[curr] = '0000000000000000'

  elif wrds[0]=='HLT':
    mem[curr] = '0000010000000000'

  elif wrds[0]=='NOT':
    mem[curr] = '0000110000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]

  elif wrds[0]=='INC':
    mem[curr] = '0001000000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]

  elif wrds[0]=='OUT':
    mem[curr] = '0001010000000000'
    # R2
    r2 = bin(int(wrds[1][1]))[2:]
    r2 = '0'*(3-len(r2)) + r2
    mem[curr] = mem[curr][:R2] + r2 + mem[curr][R2+3:]

  elif wrds[0]=='IN':
    mem[curr] = '0001100000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]


################################################
## Two Operands

  # Mov Rd, R1	01000
  # Add Rd, R1, R2	01001
  # SUB Rd, R1, R2	01010
  # AND Rd, R1, R2	01011
  # iadd, Rd, R1, imm	01100

  elif wrds[0]=='IADD':
    mem[curr] = '0010110000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]
    # R1
    r1 = bin(int(wrds[2][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]

    curr += 1
    # Imm
    Imm = bin(int(wrds[3], base=16))[2:]
    Imm = '0'*(16-len(Imm)) + Imm
    mem[curr] = Imm

    # print(wrds[3], Imm)
    # print(mem[curr+1])

  elif wrds[0]=='AND':
    mem[curr] = '0010110000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]
    # R1
    r1 = bin(int(wrds[2][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]
    # R2
    r2 = bin(int(wrds[3][1]))[2:]
    r2 = '0'*(3-len(r2)) + r2
    mem[curr] = mem[curr][:R2] + r2 + mem[curr][R2+3:]

  elif wrds[0]=='SUB':
    mem[curr] = '0010100000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]
    # R1
    r1 = bin(int(wrds[2][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]
    # R2
    r2 = bin(int(wrds[3][1]))[2:]
    r2 = '0'*(3-len(r2)) + r2
    mem[curr] = mem[curr][:R2] + r2 + mem[curr][R2+3:]

  elif wrds[0]=='ADD':
    mem[curr] = '0010010000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]
    # R1
    r1 = bin(int(wrds[2][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]
    # R2
    r2 = bin(int(wrds[3][1]))[2:]
    r2 = '0'*(3-len(r2)) + r2
    mem[curr] = mem[curr][:R2] + r2 + mem[curr][R2+3:]

  elif wrds[0]=='MOV':
    mem[curr] = '0010000000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]
    # R1
    r1 = bin(int(wrds[2][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]


  ## Memory
  # push r2	10000
  # pop rd	10001
  # ldm rd, imm	10010
  # ld rd, R1+offset	10011
  # std r2, r1+offset	10100

  elif wrds[0]=='STD':
    mem[curr] = '0101000000000000'
    # R2
    r2 = bin(int(wrds[1][1]))[2:]
    r2 = '0'*(3-len(r2)) + r2
    mem[curr] = mem[curr][:R2] + r2 + mem[curr][R2+3:]
    # R1
    r1 = bin(int(wrds[2][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]




  ## NUMERIC VALUE
  else:
    mem[curr] = bin(int(wrds[0], base=16))[2:]
    mem[curr] = '0'*(16-len( mem[curr])) +  mem[curr]
    outp.write(f'mem load -filltype value -filldata {mem[curr]} -fillradix symbolic /integration/memory/mem_arr({curr})\n')

  # print(curr)
  # mem[curr] = '0'*(16-len(mem[curr])) + mem[curr]
  # print(f'Curr: {curr}, Mem: {mem[curr]}')

  curr += 1




for i in mem:
  outp.write(f'mem load -filltype value -filldata {mem[i]} -fillradix symbolic /integration/fetch/InstructionMemory/ram({i}) \n')
  # outp.write(f'{i}: {mem[i]}\n')
  