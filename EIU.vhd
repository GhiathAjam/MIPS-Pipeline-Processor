library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EIU is port(
-- inputs
  rst, clk, sendPC_memI:  in  std_logic;
  -- alu res or stack pointer or INT
  mem_address_mux_sel:    in std_logic_vector(1 downto 0);
  -- R destination, has idx of interrupt 
  Rd,
  -- mem/stack | read/write | 16/32
  mem_operI:  in  std_logic_vector(2 downto 0);
  -- memory address from load,store OR index of INT
  alu_res:    in  std_logic_vector(15 downto 0);
  -- current Program Counter, Stack Pointer
  PC, SP:     in  std_logic_vector(31 downto 0);
--- 
-- outputs
  sendPC_memO:  out std_logic;
  -- mem/stack | read/write | 16/32
  mem_operO:    out  std_logic_vector(2 downto 0);
  -- could be alu res or stack pointer or INT or Excep
  mem_address:  out std_logic_vector(19 downto 0) );
---

end entity;
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
architecture arc_EIU of EIU is

signal EIU_to_EPC, EPC_to_EIU: std_logic_vector(31 downto 0);

constant Tp20:         integer := 1048576;
constant RST_address:  std_logic_vector(19 downto 0) := (others => '0');
constant EX1_address:  std_logic_vector(19 downto 0) := (1 => '1', others => '0');
constant EX2_address:  std_logic_vector(19 downto 0) := (2 => '1', others => '0');
constant IVT_address:  std_logic_vector(19 downto 0) := (1 => '1', 2 => '1', others => '0');

begin

  EPC:  entity work.reg_N  generic map (32) port map (clk, rst, EIU_to_EPC, EPC_to_EIU);
  
  process(rst, clk)
  begin
   
    if rst='1' then
      -- send mem[0] & m[1] to pc mux
      -- mem oper = mem read 32
      mem_operO   <= "001";
      -- mem address = 0
      mem_address <= (others => '0');
      -- avoid latch
      sendPC_memO <= sendPC_memI;
 
    elsif rising_edge(clk) then
     if mem_address_mux_sel="10" then
        -- TODO: handle INT, hint: store a state
        -- IDX is Rd
     elsif mem_address_mux_sel="00" then
        -- alu res --> data memory access

        -- DATA ACCESS EXCEPTIONS
        -- cant read/write 16 when res > 0xFF00
        if ( mem_operI="000" or mem_operI="010" ) and alu_res >= X"FF00" then
          EIU_to_EPC  <= SP;
          mem_address <= EX2_address;
          mem_operO   <= "001";
          sendPC_memO <= '1';
        -- cant read/write 32 when res >= 0xFF00 - 1 
        elsif ( mem_operI="001" or mem_operI="011" ) and alu_res >= X"FEFF" then
          EIU_to_EPC  <= SP;
          mem_address <= EX2_address;
          mem_operO   <= "001";
          sendPC_memO <= '1';

        else
          sendPC_memO <= sendPC_memI;
          mem_operO   <= mem_operI;

          mem_address(19 downto 16) <= (others=>'0');
          mem_address(15 downto 0)  <= alu_res;
        end if;

     elsif mem_address_mux_sel="01" then
        -- STACK access, push
        
        -- TODO: check for exceptions

        -- STACK EXCEPTIONS
        -- cant read 16 when pointing first place
        if mem_operI="100" and unsigned(SP) = Tp20-1 then
          EIU_to_EPC  <= SP;
          mem_address <= EX1_address;
          mem_operO   <= "001";
          sendPC_memO <= '1';
        -- cant read 32 when pointing first or second place
        elsif mem_operI="101" and unsigned(SP) >= Tp20-2 then
          EIU_to_EPC  <= SP;
          mem_address <= EX1_address;
          mem_operO   <= "001";
          sendPC_memO <= '1';
        -- cant write 32 when pointing first place
        elsif mem_operI="111" and unsigned(SP) >= Tp20-1 then
          EIU_to_EPC  <= SP;
          mem_address <= EX1_address;
          mem_operO   <= "001";
          sendPC_memO <= '1';
        
        -- TODO: handle, TAKE CARE OF INC / DEC -> DONE
        
        -- stack read 16
        elsif mem_operI="100" then
          mem_address <= SP(19 downto 0);
          mem_operO   <= mem_operI;
          sendPC_memO <= sendPC_memI;
        -- stack read 32
        elsif mem_operI="101" then
          mem_address <= std_logic_vector(unsigned(SP(19 downto 0)) - 1);
          mem_operO   <= mem_operI;
          sendPC_memO <= sendPC_memI;

        -- stack write 16
        elsif mem_operI="110" then
          mem_address <= std_logic_vector(unsigned(SP(19 downto 0)) + 1);
          mem_operO   <= mem_operI;
          sendPC_memO <= sendPC_memI;
        -- stack write 32
        else
          mem_address <= std_logic_vector(unsigned(SP(19 downto 0)) + 1);
          mem_operO   <= mem_operI;
          sendPC_memO <= sendPC_memI;
        end if;

     end if;

    end if;

  end process;
end architecture;



