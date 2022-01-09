library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is port(
-- inputs
  rst, clk, sendPC_memI,
  flags_bakI, flags_restI,
  -- data2 or next PC
  mem_input_mux_sel,
  port_read, port_write,
  memEn:           in  std_logic;

  --- mem res, alu res, port res
  write_back_mux_sel,
  -- alu res or stack pointer or INT
  mem_address_mux_sel:  in  std_logic_vector(1 downto 0);

  -- R destination, has idx of interrupt 
  Rd,
  -- mem/stack | read/write | 16/32
  mem_operI:  in  std_logic_vector(2 downto 0);

  -- port input
  outer_port_inp,
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
  outer_port_outp:  out std_logic_vector(15 downto 0);
  -- mem res to PC 
  mem_res32:  out std_logic_vector(31 downto 0);
  -- exc flg
  Exf:  out std_logic
  );
---

end entity;
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
architecture arc_memory of memory is

-- mem/stack | read/write | 16/32
signal mem_operO: std_logic_vector(2 downto 0);
 
-- alias to port_outp
signal inner_port_outp, mem_res: std_logic_vector(15 downto 0);

-- mem address from EIU
signal mem_address: std_logic_vector(19 downto 0);

-- SP
signal mem_to_SP, SP_to_mem:  std_logic_vector(31 downto 0);

-- 2^20 --> to always be able to get 32 bits
type ram_type is array(0 TO 1048576) of std_logic_vector(15 downto 0);
signal mem_arr:     ram_type;

signal mem_mux : std_logic_vector(31 downto 0);

signal Exf_t:  std_logic;

begin

  -- UPDATES on Falling edge
  SP: entity work.reg_stack port map (clk, rst, mem_to_SP, SP_to_mem);

  EIU: entity work.EIU  port map (
    PC=>PC,
    clk=>clk,
    rst=>rst,
    SP=>SP_to_mem,
    alu_res=>alu_res,
    sendPC_memI=>sendPC_memI,
    sendPC_memO=>sendPC_memO,
    Rd=>Rd,
    mem_operI=>mem_operI,
    mem_operO=>mem_operO,
    mem_address_mux_sel=>mem_address_mux_sel,
    mem_address=>mem_address,
    memEn=>memEn,
    Exf=>Exf_t);

  PRT: entity work.PRT port map (
    clk=>clk,
    rst=>rst,
    inner_port_inp=>data2,
    outer_port_inp=>outer_port_inp,
    inner_port_outp=>inner_port_outp,
    outer_port_outp=>outer_port_outp,
    port_read=>port_read,
    port_write=>port_write);


  Exf <= Exf_t;

  mem_mux   <= "0000000000000000" & data2    when mem_input_mux_sel='0'
        else   PCN;

  mem_res   <= mem_arr(to_integer(unsigned(mem_address)));
  mem_res32 <= mem_arr(to_integer(unsigned(mem_address)+1)) & mem_arr(to_integer(unsigned(mem_address)));

  process(clk, rst) 
    begin
      if rst='1' or Exf_t='1' then
        mem_to_SP <= SP_to_mem;

      elsif falling_edge(clk) then

        -- UPDATING STACK POINTER
        -- SP will accept on next rising edge
        -- stack read 16
        if mem_operI="100" then
          mem_to_SP <= std_logic_vector(unsigned(SP_to_mem) + 1);
        -- stack read 32
        elsif mem_operI="101" then
          mem_to_SP <= std_logic_vector(unsigned(SP_to_mem) + 2);
        -- stack write 16
        elsif mem_operI="110" then
          mem_to_SP <= std_logic_vector(unsigned(SP_to_mem) - 1);
        -- stack write 32
        elsif mem_operI="111" then
          mem_to_SP <= std_logic_vector(unsigned(SP_to_mem) - 2);
        end if;

        -- : Writing data to address, if mem_write
        -- mem write 16:
        if mem_operO="010" then
          mem_arr(to_integer(unsigned(mem_address))) <= mem_mux(15 downto 0);
        -- mem write 32
        elsif mem_operO="011" then
          mem_arr(to_integer(unsigned(mem_address))) <= mem_mux(15 downto 0);
          mem_arr(to_integer(unsigned(mem_address)+1)) <= mem_mux(31 downto 16);
        end if;

      end if;
    end process;

  -- write back data
  with write_back_mux_sel select
    wb_data <=
      -- mem res
      mem_res          when "00",
      -- alu res
      alu_res          when "01",
      -- port or don't care
      inner_port_outp  when others;
  
end architecture;




