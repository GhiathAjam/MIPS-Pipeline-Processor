library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- content is :
--  1- Write-Back data
--  2- Destination Register
--  3- Write-Back Signal

entity memory_writeback_buffer is port(
-- input
  rst, clk,
  reg_write_backI:  in  std_logic;
  rdI:              in  std_logic_vector(2 downto 0);
  wb_dataI:         in  std_logic_vector(15 downto 0);
---
-- output
  reg_write_backO:  out std_logic;
  rdO:              out std_logic_vector(2 downto 0);
  wb_dataO:         out std_logic_vector(15 downto 0) );
---

end entity;
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
architecture arc_memory_writeback_buffer of memory_writeback_buffer is
begin
  process(rst, clk)
  begin
    if rst='1' then
      rdO <= "000";
      reg_write_backO <= '0';
      wb_dataO <= (others => '0');

    elsif falling_edge(clk) then
      rdO <= rdI;
      reg_write_backO <= reg_write_backI;
      wb_dataO <= wb_dataI;
  
    end if;
  end process;
end architecture;


