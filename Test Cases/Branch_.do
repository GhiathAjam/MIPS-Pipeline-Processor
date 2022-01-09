
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
mem load -filltype value -filldata 0000000000010000 -fillradix symbolic /integration/memory/mem_arr(0)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(1)
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integration/memory/mem_arr(2)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(3)
mem load -filltype value -filldata 0000010001010000 -fillradix symbolic /integration/memory/mem_arr(4)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(5)
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/memory/mem_arr(6)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(7)
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/memory/mem_arr(8)
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/memory/mem_arr(9)
mem load -filltype value -filldata 0000000000010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(0) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1) 
mem load -filltype value -filldata 0000010000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(2) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(3) 
mem load -filltype value -filldata 0000010001010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(4) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(5) 
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(6) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(7) 
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(8) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(9) 
mem load -filltype value -filldata 0010110000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(512) 
mem load -filltype value -filldata 0001010000001100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(513) 
mem load -filltype value -filldata 0111110000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(514) 
mem load -filltype value -filldata 0000100000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(592) 
mem load -filltype value -filldata 0010110000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(593) 
mem load -filltype value -filldata 0001010000000100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(594) 
mem load -filltype value -filldata 0111110000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(595) 
mem load -filltype value -filldata 0100100010000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(16) 
mem load -filltype value -filldata 0000000000110000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(17) 
mem load -filltype value -filldata 0100100100000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(18) 
mem load -filltype value -filldata 0000000001010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(19) 
mem load -filltype value -filldata 0100100110000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(20) 
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(21) 
mem load -filltype value -filldata 0100101000000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(22) 
mem load -filltype value -filldata 0000001100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(23) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(24) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(25) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(26) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(27) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(28) 
mem load -filltype value -filldata 0100000000001000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(29) 
mem load -filltype value -filldata 0110110000010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(30) 
mem load -filltype value -filldata 0001000010010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(31) 
mem load -filltype value -filldata 0010111010011010 -fillradix symbolic /integration/fetch/InstructionMemory/ram(48) 
mem load -filltype value -filldata 0110000000100000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(49) 
mem load -filltype value -filldata 0000100000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(50) 
mem load -filltype value -filldata 0110000000010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(80) 
mem load -filltype value -filldata 0110100000110000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(81) 
mem load -filltype value -filldata 0000111011010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(82) 
mem load -filltype value -filldata 0100101100000001 -fillradix symbolic /integration/fetch/InstructionMemory/ram(83) 
mem load -filltype value -filldata 0000011100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(84) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(85) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(86) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(87) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(88) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(89) 
mem load -filltype value -filldata 0110010001100000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(90) 
mem load -filltype value -filldata 0001000010010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(91) 
mem load -filltype value -filldata 0000100000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1792) 
mem load -filltype value -filldata 0100011100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1793) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1794) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1795) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1796) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1797) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1798) 
mem load -filltype value -filldata 0001001101100000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1799) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1800) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1801) 
mem load -filltype value -filldata 0010011100111100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(768) 
mem load -filltype value -filldata 0010010010010100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(769) 
mem load -filltype value -filldata 0111010000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(770) 
mem load -filltype value -filldata 0000100000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(771) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1280) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(1281) 

run
run
force -freeze sim:/integration/rst 0 0
