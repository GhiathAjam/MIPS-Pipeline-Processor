library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity execute_memory_buf is

port(
  -- the main clock
  clk, rst : in std_logic;
-----------------------------------------------------------
  -- inputs concerning the register file
  d2_I  : in std_logic_vector(15 downto 0);
  rd_I : in std_logic_vector(2 downto 0);
-----------------------------------------------------------------
  -- inputs concerning the control unit
  flags_bakO_I, flags_restoreO_I,
  sendPC_memO_I,
  reg_write_back_I,
  -- data2 or next PC
  mem_input_mux_sel_I,
  port_read_I, port_write_I:  in  std_logic;
------------------------------------------
  --- mem res, alu res, port res
  write_back_mux_sel_I,
  -- alu res or stack pointer or inT
  mem_address_mux_sel_I:  in std_logic_vector(1 downto 0);
-------------------------------------------
  -- mem/stack | read/write | 16/32
  mem_oper_I:  in  std_logic_vector(2 downto 0);
-------------------------------------------
  -- inputs from execute
  alu_res_I:  in  std_logic_vector(15 downto 0);
--------------------------------------------------------------
  PCnI, PCI:  in  std_logic_vector(31 downto 0);
--------------------------------------------------------------
--------------------------------------------------------------
  -- outputs concerning the reg file
  d2_O  : out std_logic_vector(15 downto 0);
  rd_O : out std_logic_vector(2 downto 0);
-----------------------------------------------------------------
   -- outputs concerning the control unit
   flags_bakO_O, flags_restoreO_O,
   sendPC_memO_O,
   reg_write_back_O,
   -- data2 or next PC
   mem_input_mux_sel_O,
   port_read_O, port_write_O:  out  std_logic;
------------------------------------------
   --- mem res, alu res, port res
   write_back_mux_sel_O,
   -- alu res or stack pointer or inT
   mem_address_mux_sel_O:  out std_logic_vector(1 downto 0);
-------------------------------------------
   -- mem/stack | read/write | 16/32
   mem_oper_O:  out  std_logic_vector(2 downto 0);
-------------------------------------------
  -- outputs from execute
  alu_res_O:  out  std_logic_vector(15 downto 0);
-------------------------------------------
  PCnO, PCO:  out  std_logic_vector(31 downto 0) );

end entity;


architecture arc_execute_memory_buf of execute_memory_buf is

constant SIGNALS_BITS:  integer := 49 +32 +32;
signal out_vec:    std_logic_vector(0 to SIGNALS_BITS-1);

begin
 -- 1 bit
  (flags_bakO_O, flags_restoreO_O,
  sendPC_memO_O,
  reg_write_back_O,
  mem_input_mux_sel_O,
  port_read_O, port_write_O) <= out_vec(0 to 6);

  -- 2 bits
  write_back_mux_sel_O     <= out_vec(7 to 8);
  mem_address_mux_sel_O    <= out_vec(9 to 10);

  -- 3 bits
  mem_oper_O               <= out_vec(11 to 13);

  -- reg file destination
  rd_O    <= out_vec(14 to 16);
  -- reg file data read
  d2_O <= out_vec(17 to 32);
  -- alu res
  alu_res_O <= out_vec(33 to 48);
  -- PCs
  PCnO <= out_vec(49 to 80);
  PCO  <= out_vec(81 to 112);


process (clk, rst) is
  begin
    if rst = '1' then
      out_vec <= (others => '0');  
    elsif (falling_edge(clk)) then
      out_vec(0 to 6) <= (flags_bakO_I, flags_restoreO_I,
              sendPC_memO_I,
              reg_write_back_I,
              mem_input_mux_sel_I,
              port_read_I, port_write_I);
    
      out_vec(7 to 8) <= write_back_mux_sel_I ;
      out_vec(9 to 10) <= mem_address_mux_sel_I ;      

      out_vec(11 to 13) <= mem_oper_I;

      out_vec(14 to 16) <= rd_I ;
      out_vec(17 to 32) <= d2_I ;
      out_vec(33 to 48) <= alu_res_I;		

      out_vec(49 to 80)  <= PCnI;
      out_vec(81 to 112) <= PCI;

    END IF;


  end process;


end architecture;






