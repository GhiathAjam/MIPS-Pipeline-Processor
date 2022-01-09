
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
mem load -filltype value -filldata 0000001100000000 -fillradix symbolic /integration/memory/mem_arr(0)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(1)
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /integration/memory/mem_arr(2)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(3)
mem load -filltype value -filldata 0000000101010000 -fillradix symbolic /integration/memory/mem_arr(4)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(5)
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/memory/mem_arr(6)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(7)
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/memory/mem_arr(8)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(9)
mem load -filltype value -filldata 0000001100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(0) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1) 
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(2) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(3) 
mem load -filltype value -filldata 0000000101010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(4) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(5) 
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(6) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(7) 
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(8) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(9) 
mem load -filltype value -filldata 0001010000000010 -fillradix symbolic /integration/fetch/InstructionMemory/ram(256) 
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(257) 
mem load -filltype value -filldata 0001000010010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(336) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(337) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(338) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(339) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(340) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(341) 
mem load -filltype value -filldata 0001010000000010 -fillradix symbolic /integration/fetch/InstructionMemory/ram(342) 
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(343) 
mem load -filltype value -filldata 0001100100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(768) 
mem load -filltype value -filldata 0001100110000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(769) 
mem load -filltype value -filldata 0001101000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(770) 
mem load -filltype value -filldata 0100100010000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(771) 
mem load -filltype value -filldata 0000000000000101 -fillradix symbolic /integration/fetch/InstructionMemory/ram(772) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(773) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(774) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(775) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(776) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(777) 
mem load -filltype value -filldata 0100000000000010 -fillradix symbolic /integration/fetch/InstructionMemory/ram(778) 
mem load -filltype value -filldata 0100000000000100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(779) 
mem load -filltype value -filldata 0100010010000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(780) 
mem load -filltype value -filldata 0100010100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(781) 
mem load -filltype value -filldata 0001101010000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(782) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(783) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(784) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(785) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(786) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(787) 
mem load -filltype value -filldata 0101000001010101 -fillradix symbolic /integration/fetch/InstructionMemory/ram(788) 
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(789) 
mem load -filltype value -filldata 0101000001010011 -fillradix symbolic /integration/fetch/InstructionMemory/ram(790) 
mem load -filltype value -filldata 0000001000000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(791) 
mem load -filltype value -filldata 0100110111010001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(792) 
mem load -filltype value -filldata 0000001000000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(793) 
mem load -filltype value -filldata 0100111001010001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(794) 
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(795) 
mem load -filltype value -filldata 0100010110000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(796) 
mem load -filltype value -filldata 0010010010100110 -fillradix symbolic /integration/fetch/InstructionMemory/ram(797) 
mem load -filltype value -filldata 0100100100000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(798) 
mem load -filltype value -filldata 0000000000000101 -fillradix symbolic /integration/fetch/InstructionMemory/ram(799) 
mem load -filltype value -filldata 0100100110000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(800) 
mem load -filltype value -filldata 0000000000000110 -fillradix symbolic /integration/fetch/InstructionMemory/ram(801) 
mem load -filltype value -filldata 0100101000000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(802) 
mem load -filltype value -filldata 0000000000000111 -fillradix symbolic /integration/fetch/InstructionMemory/ram(803) 

run
run
force -freeze sim:/integration/rst 0 0
