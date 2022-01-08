
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY instructionmemory IS
  PORT (
    address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END;
ARCHITECTURE instructionmemory_a OF instructionmemory IS

-- 2^20 --> to always be able to get 32 bits
-- cant 2^20 -> license error --> do 2^14
type ram_type is array(0 TO 16384) of std_logic_vector(15 downto 0);
signal ram:     ram_type;

BEGIN
  instruction <= ram(to_integer(unsigned(address) + 1)) & ram(to_integer(unsigned(address)));
END;