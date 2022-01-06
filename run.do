vsim work.integration(arc_integration)

view wave

add wave -position insertpoint  \
sim:/integration/clk \
sim:/integration/rst \
sim:/integration/port_inp \
sim:/integration/port_outp
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0

# all instruction memory is NOP
mem load -skip 0 -filltype value -filldata 0 -fillradix symbolic /integration/fetch/InstructionMemory/ram

# set port 5
force -freeze sim:/integration/port_inp X\"5\" 0

# IN R6 _ instr 2
mem load -filltype value -filldata 0001101100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(2)

# add r5, r6, r6 _ instr 13
mem load -filltype value -filldata 0010011011101100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(13)

# sub r5, r6, r6 _ instr 14
mem load -filltype value -filldata 0010101011101100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(14)

# iadd r5, r6, imm _ instr 15
mem load -filltype value -filldata 0011001011101100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(15)
mem load -filltype value -filldata 0000000000001100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(15)



# data memory, 00 -> reset addresss
mem load -filltype value -filldata 00 -fillradix symbolic /integration/memory/mem_arr(0)
mem load -filltype value -filldata 00 -fillradix symbolic /integration/memory/mem_arr(1)
mem load -filltype value -filldata 00 -fillradix symbolic /integration/memory/mem_arr(2)
mem load -filltype value -filldata 00 -fillradix symbolic /integration/memory/mem_arr(3)

run
run
force -freeze sim:/integration/rst 0 0

