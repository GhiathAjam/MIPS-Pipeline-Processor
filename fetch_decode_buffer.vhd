
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetch_decode_buffer IS
  PORT (
    PCn_I, PC_I, Inst_I : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clk, flush, freeze, unfreeze : IN STD_LOGIC;
    
    PCn_O, PC_O, Inst_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END;

ARCHITECTURE fetch_decode_buffer_a OF fetch_decode_buffer IS
BEGIN
  PROCESS (flush, freeze, unfreeze, clk)
  BEGIN
    IF flush = '1' THEN
      PCn_O <= (OTHERS => '0');
      PC_O <= (OTHERS => '0');
      Inst_O <= (OTHERS => '0');
    ELSIF rising_edge(clk) AND freeze = '0' THEN
      PCn_O <= (OTHERS => '0');
      PC_O <= (OTHERS => '0');
      Inst_O <= (OTHERS => '0');
    ELSIF rising_edge(clk) AND unfreeze = '1' THEN
      PCn_O <= PCn_I ;
      PC_O <= PC_I;
      Inst_O <= Inst_I;
    END IF;
  END PROCESS;
END;