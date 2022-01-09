
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

add wave -position insertpoint  \
sim:/integration/decode_stage/registerFile/reg_ram
add wave -position insertpoint  \
sim:/integration/fetch/PC/q
add wave -position insertpoint  \
sim:/integration/memory/SP/q
add wave -position insertpoint  \
sim:/integration/memory/EIU/EPC_to_EIU
add wave -position insertpoint  \
sim:/integration/decode_stage/controlUnit/flags_reg/q


force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 

mem load -skip 0 -filltype value -filldata 0 -fillradix symbolic /integration/fetch/InstructionMemory/ram
''')

for line in file:
  if len(line) < 3 or line.startswith('#'):
    continue

  
  wrds = line.strip().replace(',', ' ').replace('(', ' ').replace(')', ' ').upper().split(' ')
  # wrds = re.split(', | ', line)

  wrds = list(filter(len, wrds))

  print(wrds)

  if not len(wrds):
    continue

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
    # R1
    mem[curr] = mem[curr][:R1] + rd + mem[curr][R1+3:]

  elif wrds[0]=='INC':
    mem[curr] = '0001000000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]
    # R1
    mem[curr] = mem[curr][:R1] + rd + mem[curr][R1+3:]

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
    mem[curr] = '0011000000000001'
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
  # ldd rd, offset R1	10011
  # std r2, offset R1	10100

  elif wrds[0]=='PUSH':
    mem[curr] = '0100000000000000'
    # R2
    r2 = bin(int(wrds[1][1]))[2:]
    r2 = '0'*(3-len(r2)) + r2
    mem[curr] = mem[curr][:R2] + r2 + mem[curr][R2+3:]

  elif wrds[0]=='POP':
    mem[curr] = '0100010000000000'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]

  elif wrds[0]=='LDM':
    mem[curr] = '0100100000000001'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]

    curr +=1
    # Imm
    Imm = bin(int(wrds[2], base=16))[2:]
    Imm = '0'*(16-len(Imm)) + Imm
    mem[curr] = Imm

  elif wrds[0]=='LDD':
    mem[curr] = '0100110000000001'
    # Rd
    rd = bin(int(wrds[1][1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]
    # R1
    r1 = bin(int(wrds[3][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]

    curr +=1
    # Imm
    Imm = bin(int(wrds[2], base=16))[2:]
    Imm = '0'*(16-len(Imm)) + Imm
    mem[curr] = Imm

  elif wrds[0]=='STD':
    mem[curr] = '0101000000000001'
    # R2
    r2 = bin(int(wrds[1][1]))[2:]
    r2 = '0'*(3-len(r2)) + r2
    mem[curr] = mem[curr][:R2] + r2 + mem[curr][R2+3:]
    # R1
    r1 = bin(int(wrds[3][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]

    curr +=1
    # Imm
    Imm = bin(int(wrds[2], base=16))[2:]
    Imm = '0'*(16-len(Imm)) + Imm
    mem[curr] = Imm


  ## Branch
  # jz r1	-> 11000
  # jn r1	-> 11001
  # jc r1	-> 11010
  # jmp r1	-> 11011
  # call r1 ->	11100
  # ret	-> 11101
  # INT index [idx put into 3 bits of Rd]	-> 11110
  # RTI	-> 11111

  elif wrds[0]=='JZ':
    mem[curr] = '0110000000000000'
    # R1
    r1 = bin(int(wrds[1][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]

  elif wrds[0]=='JN':
    mem[curr] = '0110010000000000'
    # R1
    r1 = bin(int(wrds[1][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]

  elif wrds[0]=='JC':
    mem[curr] = '0110100000000000'
    # R1
    r1 = bin(int(wrds[1][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]

  elif wrds[0]=='JMP':
    mem[curr] = '0110110000000000'
    # R1
    r1 = bin(int(wrds[1][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]

  elif wrds[0]=='CALL':
    mem[curr] = '0111000000000000'
    # R1
    r1 = bin(int(wrds[1][1]))[2:]
    r1 = '0'*(3-len(r1)) + r1
    mem[curr] = mem[curr][:R1] + r1 + mem[curr][R1+3:]

  elif wrds[0]=='RET':
    mem[curr] = '0111010000000000'

  elif wrds[0]=='INT':
    mem[curr] = '0111100000000000'
    # Rd -> Idx
    rd = bin(int(wrds[1]))[2:]
    rd = '0'*(3-len(rd)) + rd
    mem[curr] = mem[curr][:Rd] + rd + mem[curr][Rd+3:]

  elif wrds[0]=='RTI':
    mem[curr] = '0111110000000000'


  ## NUMERIC VALUE
  else:

    # if len(wrds[0]) <= 2: # One Word

    mem[curr] = bin(int(wrds[0], base=16))[2:]
    mem[curr] = '0'*(16-len( mem[curr])) +  mem[curr]
    outp.write(f'mem load -filltype value -filldata {mem[curr]} -fillradix symbolic /integration/memory/mem_arr({curr})\n')
    
    curr += 1
    mem[curr] = '0'*16
    outp.write(f'mem load -filltype value -filldata {mem[curr]} -fillradix symbolic /integration/memory/mem_arr({curr})\n')

    # else  # TWO WORDS
      # mem[curr] = bin(int(wrds[0][]))

    # outp.write(f'mem load -filltype value -filldata {mem[curr]} -fillradix symbolic /integration/memory/mem_arr({curr})\n')
    


  # print(curr)
  # mem[curr] = '0'*(16-len(mem[curr])) + mem[curr]
  # print(f'Curr: {curr}, Mem: {mem[curr]}')

  curr += 1




for i in mem:
  outp.write(f'mem load -filltype value -filldata {mem[i]} -fillradix symbolic /integration/fetch/InstructionMemory/ram({i}) \n')
  # outp.write(f'{i}: {mem[i]}\n')
  


outp.write('''
run
run
force -freeze sim:/integration/rst 0 0
'''
 )