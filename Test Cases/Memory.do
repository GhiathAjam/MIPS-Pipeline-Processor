
vsim work.integration(arc_integration)

view wave

add log -r /*

add wave -position insertpoint  sim:/integration/clk sim:/integration/rst sim:/integration/port_inp sim:/integration/port_outp
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 

mem load -skip 0 -filltype value -filldata 0 -fillradix symbolic /integration/fetch/InstructionMemory/ram
mem load -filltype value -filldata 0000001100000000 -fillradix symbolic /integration/memory/mem_arr(0)
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /integration/memory/mem_arr(2)
mem load -filltype value -filldata 0000000101010000 -fillradix symbolic /integration/memory/mem_arr(4)
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/memory/mem_arr(6)
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/memory/mem_arr(8)
