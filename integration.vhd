library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity integration is port( 
  clk, rst:   in  std_logic;
  port_inp:   in  std_logic_vector(15 downto 0);
  port_outp:  out std_logic_vector(15 downto 0) );
end entity;

architecture arc_integration of integration
is

-- declare signals from fetch to fetch_decode_buffer

-- declare signals from fetch_decode_buffer to decode

-- declare signals from decode to decode_execute_buffer

-- declare signals from decode_execute_buffer to execute

-- declare signals from execute to execute_memory_buffer

-- declare signals from execute_memory_buffer to memory

-- declare signals from memory to memory_writeback_buffer

-- declare signals from memory_writeback_buffer to decode

begin

  -- TODO: fill with right variables
  fetch:                   entity work.fetch  port map();
  fetch_decode_buffer:     entity work.fetch_decode_bufffer port map();
  decode:                  entity work.decode  port map();
  decode_execute_buffer:   entity work.decode_execute_buffer  port map();
  execute:                 entity work.execute  port map();
  execute_memory_buffer:   entity work.execute_memory_buffer  port map();
  memory:                  entity work.memory  port map();
  memory_writeback_buffer: entity work.memory_writeback_buffer  port map();
  
end architecture;