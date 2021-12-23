library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is port(
-- inputs
  rst, clk, sendPC_exI, sendPC_memI,
  carry_zero_flag_enI, neg_flag_enI,
  flags_bakI, flags_restI, set_carryI,
  alu_carry_flag, alu_zero_flag, alu_neg_flag:  in  std_logic;
  instr_ctrl_bits:  in  std_logic_vector(5 downto 0);
--- 
-- outputs
  PC_mux, sendPC_exO, sendPC_memO,
  frez_fetch_dec_buf, flsh_fetch_dec_buf,
  alu_mux,
  carry_zero_flag_enO, neg_flag_enO,
  flags_bakO, flags_restoreO, set_carryO,
  reg_write_back, write_back_mux,
  mem_input_mux, mem_address_mux,
  mem_read_16, stk_read_16, mem_write_16, stk_write_16,
  mem_read_32, stk_read_32, mem_write_32, stk_write_32,
  port_read, port_write:  out  std_logic;
  alu_oper: out  std_logic_vector(2 downto 0) );
---

end entity;

  

  
  

