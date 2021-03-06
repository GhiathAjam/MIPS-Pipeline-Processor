
vsim work.integration(arc_integration)

view wave

add log -r /*

add wave -position insertpoint  sim:/integration/clk sim:/integration/rst sim:/integration/port_inp sim:/integration/port_outp

add wave -position insertpoint  sim:/integration/decode_stage/registerFile/reg_ram
add wave -position insertpoint  sim:/integration/fetch/PC/q
add wave -position insertpoint  sim:/integration/memory/SP/q
add wave -position insertpoint  sim:/integration/memory/EIU/EPC_to_EIU
add wave -position insertpoint  sim:/integration/decode_stage/controlUnit/flags_reg/q


force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 

mem load -skip 0 -filltype value -filldata 0 -fillradix symbolic /integration/fetch/InstructionMemory/ram
mem load -filltype value -filldata 0000000010100000 -fillradix symbolic /integration/memory/mem_arr(0)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(1)
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /integration/memory/mem_arr(2)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(3)
mem load -filltype value -filldata 0000000101010000 -fillradix symbolic /integration/memory/mem_arr(4)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(5)
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/memory/mem_arr(6)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(7)
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/memory/mem_arr(8)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(9)
mem load -filltype value -filldata 0000000010100000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(0) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1) 
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(2) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(3) 
mem load -filltype value -filldata 0000000101010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(4) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(5) 
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(6) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(7) 
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(8) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(9) 
mem load -filltype value -filldata 0000100000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(160) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(161) 
mem load -filltype value -filldata 0000110010010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(162) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(163) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(164) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(165) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(166) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(167) 
mem load -filltype value -filldata 0001000010010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(168) 
mem load -filltype value -filldata 0001100010000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(169) 
mem load -filltype value -filldata 0001100100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(170) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(171) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(172) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(173) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(174) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(175) 
mem load -filltype value -filldata 0000110100100000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(176) 
mem load -filltype value -filldata 0001000010010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(177) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(178) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(179) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(180) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(181) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(182) 
mem load -filltype value -filldata 0001010000000010 -fillradix symbolic /integration/fetch/InstructionMemory/ram(183) 
mem load -filltype value -filldata 0001010000000100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(184) 
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(185) 
mem load -filltype value -filldata 0001010000000010 -fillradix symbolic /integration/fetch/InstructionMemory/ram(186) 

run
run
force -freeze sim:/integration/rst 0 0
