library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg_N is
  generic(n: integer := 16);
  port( 
    clk, rst:  in  std_logic;
    d:  in  std_logic_vector(n-1 downto 0);
    q:  out std_logic_vector(n-1 downto 0));
end entity;

architecture arc_reg_N of reg_N
is
begin
  process (clk, rst)
  begin
    if rst = '1' then
      q <= (others=>'0');
    elsif rising_edge(clk) then
      q <= d;
    end if;
  end process;
end architecture;
