library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PRT is port( 
  clk, rst, port_read, port_write:   in  std_logic;
  inner_port_inp,  outer_port_inp:   in  std_logic_vector(15 downto 0);
  inner_port_outp, outer_port_outp:  out std_logic_vector(15 downto 0) );
end entity;

architecture arc_PRT of PRT
is

begin

  process (clk, rst)
  begin
    if rst = '1' then
      outer_port_outp <= (others=>'0');
      -- inner_port_outp <= (others=>'0');
    elsif falling_edge(clk) then
      if port_write='1' then
        outer_port_outp <= inner_port_inp;
      end if;
    end if;
  end process;

  inner_port_outp <= outer_port_inp;

end architecture;