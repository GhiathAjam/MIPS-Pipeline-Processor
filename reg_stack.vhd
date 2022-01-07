library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_stack is
    port (
        clk, rst: in std_logic;
        d: in  std_logic_vector(31 downto 0);
        q: out std_logic_vector(31 downto 0) );
end;

architecture arc_reg_stack of reg_stack is
begin
    process (clk, rst)
    begin
        if (rst = '1') then
            -- 2^20 -1
            q <= std_logic_vector(to_unsigned(1048575, 32));

        elsif falling_edge(clk) then
            q <= d;
        end if;
    end process;
end;