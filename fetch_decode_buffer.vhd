LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetch_decode_buffer IS
  PORT (
    PCn_I, PC_I, Inst_I : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clk, rst, flush, freeze, unfreeze : IN STD_LOGIC;

    PCn_O, PC_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    control_bits : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    rd, rs, rt : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    offset : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END;

ARCHITECTURE fetch_decode_buffer_a OF fetch_decode_buffer IS
BEGIN
  PROCESS IS
    VARIABLE isFrozen : BOOLEAN := false; -- Variable Not Signal to update Immediatly not at the end of process
  BEGIN

    wait on clk, rst, flush;

    IF rst = '1' THEN
      PCn_O <= (OTHERS => '0');
      PC_O <= (OTHERS => '0');
      control_bits <= (OTHERS => '0');
      rd <= (OTHERS => '0');
      rs <= (OTHERS => '0');
      rt <= (OTHERS => '0');
      offset <= (OTHERS => '0');
    ELSIF falling_edge(clk) THEN
      WAIT FOR 20 ps;

      IF freeze = '1' THEN
        isFrozen := true;
      ELSIF unfreeze = '1' THEN
        isFrozen := false;
      END IF;

      IF NOT isFrozen THEN -- If isFrozzen => latch the old out
        -- out = in
        PCn_O <= PCn_I;
        PC_O <= PC_I;
        rt <= Inst_I(3 DOWNTO 1);
        rs <= Inst_I(6 DOWNTO 4);
        rd <= Inst_I(9 DOWNTO 7);
        control_bits <= Inst_I(14 DOWNTO 10);
        -- bit 15 is dont't care
        offset <= Inst_I(31 DOWNTO 16);
      END IF;
    END IF;

  END PROCESS;
END;