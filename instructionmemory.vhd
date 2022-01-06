
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY instructionmemory IS
  PORT (
    address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END;
ARCHITECTURE instructionmemory_a OF instructionmemory IS
  TYPE ram_type IS ARRAY (0 TO 1023) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL ram : ram_type;
BEGIN
  instruction <= ram(to_integer(unsigned(address) + 1)) & ram(to_integer(unsigned(address)));
END;