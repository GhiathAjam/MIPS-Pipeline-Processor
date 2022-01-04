LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux3x1 IS
  PORT (
    adder_res, alu_res, mem_res : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    sel : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    hlt : IN STD_LOGIC;
    new_pc : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END;
ARCHITECTURE mux3x1_a OF mux3x1 IS
BEGIN
  PROCESS (adder_res, alu_res, mem_res, sel, hlt)
  BEGIN
    IF (hlt /='1') THEN -- hlt = '0', 'x', 'l', 'h', ...
      CASE sel IS
        WHEN "00" => new_pc <= adder_res;
        WHEN "01" => new_pc <= alu_res;
        WHEN OTHERS => new_pc <= mem_res; -- '10', '11', 'xx', ...
      END CASE;
    END IF;
    -- hlt = '1' latch the old value of the pc
  END PROCESS;
END;