library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is port(
-- inputs
  rst, clk, sendPC_memI,
  zero_neg_flag_enI, carry_flag_enI,
  flags_bakI, flags_restI, set_carryI,
  alu_carry_flag, alu_zero_flag, alu_neg_flag:  in  std_logic;

  sendPC_exI:  in  std_logic_vector(2 downto 0);

  instr_ctrl_bits:  in  std_logic_vector(5 downto 0);
--- 
-- outputs
  sendPC_memO,
  frez_fetch_dec_buf, flsh_fetch_dec_buf,
  unfrez_fetch_dec_buf,
  zero_neg_flag_enO, carry_flag_enO,
  flags_bakO, flags_restoreO, set_carryO,
  reg_write_back,
  -- data2 or next PC
  mem_input_mux_sel,
  port_read, port_write:  out  std_logic;

  -- pc+1 or alu res or mem res
  PC_mux_sel, 
  -- val=1, imm, data2 
  alu_mux_sel,
  --- mem res, alu res, port res
  write_back_mux_sel,
  -- alu res or stack pointer or INT
  mem_address_mux_sel:  out std_logic_vector(1 downto 0);

  -- not, pass_1, pass_2, sub, add, and
  alu_oper,
  -- no branch, branch zero, branch neg, branch carr, BRANCH ALWAYS
  sendPC_exO:  out  std_logic_vector(2 downto 0);

  -- mem_read_16, stk_read_16, mem_write_16, stk_write_16,
  -- mem_read_32, stk_read_32, mem_write_32, stk_write_32
  mem_oper:  out  std_logic_veunfrez_fetch_dec_bufctor(3 downto 0) );
---

end entity;

architecture arc_control_unit of control_unit is

-- flgs[0] -> Zero, [1] -> Neg, [2] -> Carry
signal ctrl_to_flags, flags_to_ctrl:      std_logic_vector(2 downto 0);
signal ctrl_to_flags_b, flags_b_to_ctrl:  std_logic_vector(2 downto 0);

constant SIGNALS_BITS: integer := 31;
signal out_vec:		std_logic_vector(SIGNALS_BITS-1 downto 0);

begin
  -- 1 bit
  (sendPC_memO,
  frez_fetch_dec_buf, flsh_fetch_dec_buf,
  unfrez_fetch_dec_buf
  zero_neg_flag_enO, carry_flag_enO,
  flags_bakO, flags_restoreO, set_carryO,
  reg_write_back, mem_input_mux_sel,
  port_read, port_write) <= out_vec(12 downto 0);
  -- 2 bits
  PC_mux_sel             <= out_vec(14 downto 13);
  alu_mux_sel            <= out_vec(16 downto 15);
  write_back_mux_sel     <= out_vec(18 downto 17);
  mem_address_mux_sel    <= out_vec(20 downto 19);
  -- 3 bits
  sendPC_exO             <= out_vec(23 downto 21);
  alu_oper               <= out_vec(26 downto 24);
  -- 4 bits
  mem_oper               <= out_vec(30 downto 27);
 
  -- flags[0] -> Zero, [1] -> Neg, [2] -> Carr
  flags_reg:  entity work.reg_N  generic map (3) port map (clk, rst, ctrl_to_flags, flags_to_ctrl);
  flags_bak:  entity work.reg_N  generic map (3) port map (clk, rst, ctrl_to_flags_b, flags_b_to_ctrl);

  process(rst, clk)
  begin
    if rst='1'  then
      out_vec  <= (others => '0');
      alu_oper <= (others => '0');
      PC_mux_sel   <= ("10");
 
    elsif rising_edge(clk) then
      if unsigned(sendPC_exI)>0 then
        -- TODO: check condition then unfreeze + sel PC 
      end if;
      if sendPC_memI='1' then
        -- TODO: unfreeze + sel PC 
      end if;
      if zero_neg_flag_enI='1' then
        ctrl_to_flags(0) <= alu_zero_flag;
        ctrl_to_flags(1) <= alu_neg_flag;
      end if;
      if carry_flag_enI='1' then
        ctrl_to_flags(2) <= alu_carry_flag;
      end if;
      if flags_bakI='1' then
        -- TODO: Backup flags
      end if;
      if flags_restI='1' then
        -- TODO: Restore flags
      end if;
      if set_carryI='1' then
         ctrl_to_flags(2) <= '1';       
      end if;

      -- NOW FILLING THE OUT VEC!!
      case instr_ctrl_bits is
      when "000000" =>  -- NOP
        out_vec <=  (others => '0');
      when "
	












