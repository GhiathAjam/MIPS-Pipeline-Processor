LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY register32bit IS
    PORT (
        d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        clk, rst : IN STD_LOGIC;
        q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END;

ARCHITECTURE register32bit_a OF register32bit IS
BEGIN
    PROCESS
    BEGIN

        wait on clk, rst;

        IF (Rst = '1') THEN
            q <= (OTHERS => '0');
        ELSIF falling_edge (clk) THEN
            -- wait 
            wait for 10 ps;
            q <= d;
        END IF;
    END PROCESS;
END;