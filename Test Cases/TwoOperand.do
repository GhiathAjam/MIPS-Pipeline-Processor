
vsim work.integration(arc_integration)

view wave

add log -r /*

add wave -position insertpoint  sim:/integration/clk sim:/integration/rst sim:/integration/port_inp sim:/integration/port_outp
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 

run
run
force -freeze sim:/integration/rst 0 0

mem load -skip 0 -filltype value -filldata 0 -fillradix symbolic /integration/fetch/InstructionMemory/ram
mem load -filltype value -filldata 0000000011111111 -fillradix symbolic /integration/memory/mem_arr(0)
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /integration/memory/mem_arr(2)
mem load -filltype value -filldata 0000000101010000 -fillradix symbolic /integration/memory/mem_arr(4)
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/memory/mem_arr(6)
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/memory/mem_arr(8)
mem load -filltype value -filldata 0000000011111111 -fillradix symbolic /integration/fetch/InstructionMemory/ram(0) 
mem load -filltype value -filldata 0000000100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(2) 
mem load -filltype value -filldata 0000000101010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(4) 
mem load -filltype value -filldata 0000001000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(6) 
mem load -filltype value -filldata 0000001001010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(8) 
mem load -filltype value -filldata 0001100010000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(255) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(256) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(257) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(258) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(259) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(260) 
mem load -filltype value -filldata 0001100100000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(261) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(262) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(263) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(264) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(265) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(266) 
mem load -filltype value -filldata 0001100110000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(267) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(268) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(269) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(270) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(271) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(272) 
mem load -filltype value -filldata 0001101000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(273) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(274) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(275) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(276) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(277) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(278) 
mem load -filltype value -filldata 0010000111010000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(279) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(280) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(281) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(282) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(283) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(284) 
mem load -filltype value -filldata 0010011000011000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(285) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(286) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(287) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(288) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(289) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(290) 
mem load -filltype value -filldata 0010101101011000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(291) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(292) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(293) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(294) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(295) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(296) 
mem load -filltype value -filldata 0010111001111000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(297) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(298) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(299) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(300) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(301) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(302) 
mem load -filltype value -filldata 0010110100100000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(303) 
mem load -filltype value -filldata 1111111111111111 -fillradix symbolic /integration/fetch/InstructionMemory/ram(304) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(305) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(306) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(307) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(308) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(309) 
mem load -filltype value -filldata 0010010100010100 -fillradix symbolic /integration/fetch/InstructionMemory/ram(310) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(311) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(312) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(313) 
mem load -filltype value -filldata 0000000000000000 -fillradix symbolic /integration/fetch/InstructionMemory/ram(314) 
