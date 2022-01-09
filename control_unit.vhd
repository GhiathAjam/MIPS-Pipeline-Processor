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

  instr_ctrl_bits:  in  std_logic_vector(4 downto 0);
--- 
-- outputs
  sendPC_memO,
  frez_fetch_dec_buf, flsh_fetch_dec_buf,
  flsh_dec_exec_buf,
  unfrez_fetch_dec_buf,
  zero_neg_flag_enO, carry_flag_enO,
  flags_bakO, flags_restoreO, set_carryO,
  reg_write_back,
  -- data2 or next PC
  mem_input_mux_sel,
  -- imm or data2 
  alu_mux_sel,
  port_read, port_write:  out  std_logic;

  -- pc+1 or alu res or mem res
  PC_mux_sel, 
  --- mem res, alu res, port res
  write_back_mux_sel,
  -- alu res or stack pointer or INT
  mem_address_mux_sel:  out std_logic_vector(1 downto 0);

  -- not, pass_1, pass_2, sub, add, and
  alu_oper,
  -- no branch, branch zero, branch neg, branch carr, BRANCH ALWAYS
  sendPC_exO,
  -- mem/stack | read/write | 16/32
  mem_oper:  out  std_logic_vector(2 downto 0);
  -- to make the fetch stage select between PCn and alu_res	
  alu_or_PCn, memEn, flsh_exec_mem_buf : out std_logic );
---

end entity;
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
architecture arc_control_unit of control_unit is

-- flgs[0] -> Zero, [1] -> Neg, [2] -> Carry
signal ctrl_to_flags, flags_to_ctrl:      std_logic_vector(2 downto 0);
signal ctrl_to_flags_b, flags_b_to_ctrl:  std_logic_vector(2 downto 0);

constant SIGNALS_BITS:  integer := 33;
-- signal out_vec:	

begin

  -- flags[0] -> Zero, [1] -> Neg, [2] -> Carry
  flags_reg:  entity work.reg_N  generic map (3) port map (clk, rst, ctrl_to_flags, flags_to_ctrl);
  flags_bak:  entity work.reg_N  generic map (3) port map (clk, rst, ctrl_to_flags_b, flags_b_to_ctrl);

  process(rst, clk)
    variable out_vec:	std_logic_vector(0 to SIGNALS_BITS-1);
  
  begin
  
    if rst='1'  then
      -- Sel PC from mem
      out_vec := "000000000000000010000000000000000";
      ctrl_to_flags <= flags_to_ctrl;
      ctrl_to_flags_b <= flags_b_to_ctrl;
      -- PC_mux_sel <= "00";
    elsif rising_edge(clk) then

      -- NOW FILLING THE OUT VEC!!
      case instr_ctrl_bits is
        when "00000" =>  -- NOP
          out_vec :=  (others => '0');
        when "00001" =>   -- HLT
          out_vec := "001100000000000000000000000000000";
        when "00010" =>   -- SETC
          out_vec := "000000000010000000000000000000000";
        when "00011" =>   -- NOT Rdst
          out_vec := "000000100001000000010000010100000";
        when "00100" =>   -- INC Rdst
          out_vec := "000000110001000000010000011000000";
        when "00101" =>   -- OUT Rdst
          out_vec := "000000000000000100000000000000000";
        when "00110" =>   -- IN Rdst
          out_vec := "000000000001001000100000000000000";
        when "01000" =>   -- Mov R, R
          out_vec := "000000000001000000010000000100000";
        when "01001" =>   -- Add R, R, R
          out_vec := "000000110001010000010000010000000";
        when "01010" =>   -- SUB R, R, R
          out_vec := "000000110001010000010000001100000";
        when "01011" =>   -- AND R, R, R
          out_vec := "000000100001010000010000000000000";
        when "01100" =>   -- iadd, r, r, imm
          out_vec := "000000110001000000010000010000000";
        when "10000" =>   -- push r
          out_vec := "000000000000000000000100000111000";
        when "10001" =>   -- pop r
          out_vec := "000000000001000000000100000010000";
        when "10010" =>   -- ldm r, imm
          out_vec := "000000000001000000010000001000000";
        when "10011" =>   -- ld r, R+offset
          out_vec := "000000000001000000000000010000010";
        when "10100" =>   -- std rs1, rs2+offset
          out_vec := "000000000000000000000000010001010";
        when "11000" =>   -- jz r
          out_vec := "000000000000000000000000100100000";
        when "11001" =>   -- jn r
          out_vec := "000000000000000000000001000100000";
        when "11010" =>   -- jc r
          out_vec := "000000000000000000000001100100000";
        when "11011" =>   -- jmp r
          out_vec := "000000000000000001000010000100000";
        when "11100" =>   -- call r
          out_vec := "001100000000100001000110000111100";
        when "11101" =>   -- ret
          out_vec := "011100000000000010000100000010100";
        when "11110" =>   -- INT index
          out_vec := "001100001000100010001000001000000";
        when "11111" =>   -- ret int
          out_vec := "011100000100000010000100000010100";
        when others =>
          out_vec := (others => '0');
      end case;
      
    -- FALLING EDGE STUFF, PC STUFF!
    elsif falling_edge(clk) then
      if unsigned(sendPC_exI)=4 then
        -- : unfreeze + sel PC 
        -- unfrez_fetch_dec_buf -> 5
        out_vec(5) := '1';
        -- alu or PCn
        out_vec(0) := '0';
        -- PC mux sel
        out_vec(16 to 17) := "01";
      elsif unsigned(sendPC_exI)>0 then
        -- : conditional -> assume not taken
        -- if condtions not met -> do NOTHING
        -- else flush the first two buffers and select the PC

        -- check the flags
        if flags_to_ctrl(0) = '1' and unsigned(sendPC_exI) = 1 then
          -- jump zero -> set ctrl_to_flags(0) to zero
          ctrl_to_flags(0) <= '0';
          -- flsh_dec_exec_buf <= '1';
          out_vec(4) := '1';
          -- flsh_fetch_dec_buf <= '1';
          out_vec(3) := '1';
          -- alu_or_PCn <= '0';
          out_vec(0) := '0';
          -- PC_mux_sel <= "01";
          out_vec(16 to 17) := "01";
        
        elsif flags_to_ctrl(1) = '1' and unsigned(sendPC_exI) = 2 then
          -- jump NEG -> set ctrl_to_flags(1) to zero
          ctrl_to_flags(1) <= '0';
          -- flsh_dec_exec_buf <= '1';
          out_vec(4) := '1';
          -- flsh_fetch_dec_buf <= '1';
          out_vec(3) := '1';
          -- alu_or_PCn <= '0';
          out_vec(0) := '0';
          -- PC_mux_sel <= "01";
          out_vec(16 to 17) := "01";

        elsif flags_to_ctrl(2) = '1' and unsigned(sendPC_exI) = 3 then
          -- jump zero -> set ctrl_to_flags(2) to zero
          ctrl_to_flags(2) <= '0';
          -- flsh_dec_exec_buf <= '1';
          out_vec(4) := '1';
          -- flsh_fetch_dec_buf <= '1';
          out_vec(3) := '1';
          -- alu_or_PCn <= '0';
          out_vec(0) := '0';
          -- PC_mux_sel <= "01";
          out_vec(16 to 17) := "01";
        end if;

      end if;

      if sendPC_memI='1' then
        -- : unfreeze + sel PC
        -- unfrez_fetch_dec_buf <= '1';
        out_vec(5) := '1';
        -- PC_mux_sel <= "10";
        out_vec(16 to 17) := "10";
        -- flush decode execute 
        out_vec(4) := '1';
        -- flush exec mem
        out_vec(32) := '1';
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

    
    end if;

    -- 1 bit
    (alu_or_PCn, sendPC_memO,
    frez_fetch_dec_buf, flsh_fetch_dec_buf,
    flsh_dec_exec_buf,
    unfrez_fetch_dec_buf,
    zero_neg_flag_enO, carry_flag_enO,
    flags_bakO, flags_restoreO, set_carryO,
    reg_write_back,
    mem_input_mux_sel,
    alu_mux_sel,
    port_read, port_write) <= out_vec(0 to 15);
    -- 2 bits
    PC_mux_sel             <= out_vec(16 to 17);
    write_back_mux_sel     <= out_vec(18 to 19);
    mem_address_mux_sel    <= out_vec(20 to 21);
    -- 3 bits
    sendPC_exO             <= out_vec(22 to 24);
    alu_oper               <= out_vec(25 to 27);
    mem_oper               <= out_vec(28 to 30);
    
    memEn     <=  out_vec(31);
    flsh_exec_mem_buf <= out_vec(32);

  end process;
end architecture;



