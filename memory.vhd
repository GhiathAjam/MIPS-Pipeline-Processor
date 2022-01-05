library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is port(
-- inputs
  rst, clk, sendPC_memI,
  flags_bakI, flags_restI,
  -- data2 or next PC
  mem_input_mux_sel,
  port_read, port_write:  in  std_logic;

  --- mem res, alu res, port res
  write_back_mux_sel,
  -- alu res or stack pointer or INT
  mem_address_mux_sel:  in  std_logic_vector(1 downto 0);

  -- mem/stack | read/write | 16/32
  mem_operI:  in  std_logic_vector(2 downto 0);

  -- port input
  port_inp,
  -- second Register data
  data2,
  -- alu res
  alu_res: in  std_logic_vector(15 downto 0);
  -- next Program Counter, current Program Counter
  PCN, PC:  in  std_logic_vector(31 downto 0);

--- 
-- outputs
  sendPC_memO: out std_logic;

  -- write back data
  wb_data,
  -- port output
  port_outp:  out std_logic_vector(15 downto 0);
  -- mem res to PC 
  mem_res32:  out std_logic_vector(31 downto 0) );
---

end entity;
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
architecture arc_memory of memory is

-- mem/stack | read/write | 16/32
signal mem_operO: std_logic_vector(2 downto 0);
-- mem address from EIU
signal mem_address, 
-- alias to port_outp
prt_outp, mem_res: std_logic_vector(15 downto 0);

signal mem_to_SP, SP_to_mem :  std_logic_vector(31 downto 0);

-- 2^20 --> to always be able to get 32 bits
type ram_type is array(0 TO 1048576) of std_logic_vector(15 downto 0);
signal mem_arr:     ram_type;

begin

  SP: entity work.reg_N  generic map (32) port map (clk, rst, mem_to_SP, SP_to_mem);

  EIU: entity work.EIU  port map (
    PC=>PC,
    clk=>clk,
    rst=>rst,
    SP=>SP_to_mem,
    alu_res=>alu_res,
    sendPC_memI=>sendPC_memI,
    sendPC_memO=>sendPC_memO,
    mem_operI=>mem_operI,
    mem_operO=>mem_operO,
    mem_address_mux_sel=>mem_address_mux_sel,
    mem_address=>mem_address);

  PRT: entity work.PRT port map (
    clk=>clk,
    rst=>rst,
    inp=>data2,
    port_inp=>port_inp,
    port_outp=>prt_outp,
    port_read=>port_read,
    port_write=>port_write);

  port_outp <= prt_outp;
  mem_res <= mem_arr(to_integer(unsigned(mem_address)));
  mem_res32 <= mem_arr(to_integer(unsigned(mem_address))) & mem_arr(to_integer(unsigned(mem_address))+1);

  process(clk) 
    begin
      if falling_edge(clk) then
        -- TODO: Writing data to address, if mem_write
      end if;
  end process;


  -- write back data
  with write_back_mux_sel select
    wb_data <=
      -- mem res
      mem_res  when "00",
      -- alu res
      alu_res               when "01",
      -- port or don't care
      prt_outp              when others;
  
end architecture;




