library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode_execute_buf is

port(
  -- the main clock
    clk, rst : IN std_logic;
-----------------------------------------------------------
  -- inputs concerning the register file
    d1_I, d2_I  : IN std_logic_vector(15 downto 0);
    rd_I : IN std_logic_vector(2 downto 0);
-----------------------------------------------------------------
  -- input concerning the Immediate value
    immediate_I : IN std_logic_vector(15 downto 0);
-----------------------------------------------------------------
  -- inputs concerning the control unit
    sendPC_memO_I,
    flsh_dec_exec_buf_I,
    zero_neg_flag_enO_I, carry_flag_enO_I,
    flags_bakO_I, flags_restoreO_I, set_carryO_I,
    reg_write_back_I,
    -- data2 or next PC
    mem_input_mux_sel_I,
    -- imm or data2 
    alu_mux_sel_I,
    port_read_I, port_write_I:  IN  std_logic;
------------------------------------------
    --- mem res, alu res, port res
    write_back_mux_sel_I,
    -- alu res or stack pointer or INT
    mem_address_mux_sel_I:  IN std_logic_vector(1 downto 0);
-------------------------------------------
    -- not, pass_1, pass_2, sub, add, and
    alu_oper_I,
    -- no branch, branch zero, branch neg, branch carr, BRANCH ALWAYS
    sendPC_exO_I,
    -- mem/stack | read/write | 16/32
    mem_oper_I:  IN  std_logic_vector(2 downto 0);
--------------------------------------------------------------
    PCnI, PCI:   IN  std_logic_vector(31 downto 0);
--------------------------------------------------------------
    -- outputs concerning the reg file
    d1_O, d2_O  : OUT std_logic_vector(15 downto 0);
    rd_O : OUT std_logic_vector(2 downto 0);
-----------------------------------------------------------------
    -- output concerning the Immediate value
    immediate_O : OUT std_logic_vector(15 downto 0);
-----------------------------------------------------------------
    -- outputs concerning the control unit
    sendPC_memO_O,
    zero_neg_flag_enO_O, carry_flag_enO_O,
    flags_bakO_O, flags_restoreO_O, set_carryO_O,
    reg_write_back_O,
    -- data2 or next PC
    mem_input_mux_sel_O,
    -- imm or data2 
    alu_mux_sel_O,
    port_read_O, port_write_O:  OUT  std_logic;
------------------------------------------
    --- mem res, alu res, port res
    write_back_mux_sel_O,
    -- alu res or stack pointer or INT
    mem_address_mux_sel_O:  OUT std_logic_vector(1 downto 0);
-------------------------------------------
    -- not, pass_1, pass_2, sub, add, and
    alu_oper_O,
    -- no branch, branch zero, branch neg, branch carr, BRANCH ALWAYS
    sendPC_exO_O,
    -- mem/stack | read/write | 16/32
    mem_oper_O:  OUT  std_logic_vector(2 downto 0);
--------------------------------------------------------------
    PCnO, PCO:   OUT  std_logic_vector(31 downto 0)
);

end entity;


architecture dec_ex_buf of decode_execute_buf is

constant SIGNALS_BITS:  integer := 75 +32 +32;
signal out_vec:    std_logic_vector(0 to SIGNALS_BITS-1);

begin
 -- 1 bit
  (sendPC_memO_O,
  zero_neg_flag_enO_O, carry_flag_enO_O,
  flags_bakO_O, flags_restoreO_O, set_carryO_O,
  reg_write_back_O,
  mem_input_mux_sel_O,
  alu_mux_sel_O,
  port_read_O, port_write_O) <= out_vec(0 to 10);

  -- 2 bits
  write_back_mux_sel_O     <= out_vec(11 to 12);
  mem_address_mux_sel_O    <= out_vec(13 to 14);

-- 3 bits
  sendPC_exO_O             <= out_vec(15 to 17);
  alu_oper_O               <= out_vec(18 to 20);
  mem_oper_O               <= out_vec(21 to 23);

-- reg file destination
  rd_O    <= out_vec(24 to 26);
-- reg file data read
  d1_O <= out_vec(27 to 42);
  d2_O <= out_vec(43 to 58);
-- the immediate value
  immediate_O <= out_vec(59 to 74);

-- PCs
  PCnO <= out_vec(75 to 106);
  PCO  <= out_vec(107 to 138);

  process (clk, flsh_dec_exec_buf_I, rst) is
  begin
    IF (flsh_dec_exec_buf_I = '1') or rst = '1' then
      out_vec <= (others => '0');  
    elsif (falling_edge(clk)) then
      out_vec(0 to 10) <= (sendPC_memO_I,
              zero_neg_flag_enO_I, carry_flag_enO_I,
              flags_bakO_I, flags_restoreO_I, set_carryO_I,
              reg_write_back_I,
              mem_input_mux_sel_I,
              alu_mux_sel_I,
              port_read_I, port_write_I);
    
      
      --out_vec(15 to 20) <=  ( PC_mux_sel_I, write_back_mux_sel_I, mem_address_mux_sel_I );
      out_vec(11 to 12) <= write_back_mux_sel_I ;
      out_vec(13 to 14) <= mem_address_mux_sel_I ;      


      --out_vec(21 to 29) <= ( sendPC_exO_I, alu_oper_I, mem_oper_I );
      out_vec(15 to 17) <= sendPC_exO_I;
      out_vec(18 to 20) <= alu_oper_I;
      out_vec(21 to 23) <= mem_oper_I;

      --out_vec(30 to 64) <= ( rd_I, d1_I, d2_I );
      out_vec(24 to 26) <= rd_I ;
      out_vec(27 to 42) <= d1_I ;
      out_vec(43 to 58) <= d2_I ;
      out_vec(59 to 74) <= immediate_I;

      out_vec(75 to 106)  <= PCnI;
      out_vec(107 to 138) <= PCI;

    END IF;


  end process;


end architecture;






