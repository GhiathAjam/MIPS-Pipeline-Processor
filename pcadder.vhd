LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; -- include the overloaded +

ENTITY pcadder IS
  PORT (
    mux_res : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    pc : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    adder_res : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END;

ARCHITECTURE pcadder_a OF pcadder IS
BEGIN
  adder_res <= mux_res + pc;
END;