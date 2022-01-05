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
  -- FETCH DECDE BUFFER IS INSIDE FETCH STAGE

-- declare signals from fetch
    signal PCn, PC: std_logic_vector(31 downto 0);
    signal ctrl_bits: std_logic_vector(4 downto 0);
    signal rd, r1, r2: std_logic_vector(2 downto 0);
    signal immediate: std_logic_vector(15 downto 0);

-- declare signals from decode
    signal d1, d2: std_logic_vector(15 downto 0);

    signal sendPC_memO, frez_fetch_dec_buf, flsh_fetch_dec_buf,
    flsh_dec_exec_buf, unfrez_fetch_dec_buf,
    zero_neg_flag_enO, carry_flag_enO,
    flags_bakO, flags_restoreO, set_carryO,
    reg_write_back, mem_input_mux_sel,
    alu_mux_sel, port_read, port_write: std_logic;

    signal PC_mux_sel, write_back_mux_sel,
    mem_address_mux_sel: std_logic_vector(1 downto 0);

    signal alu_oper, sendPC_exO, mem_oper: std_logic_vector(2 downto 0);
 
-- declare signals from decode_execute_buffer
    signal sendPC_memO_O,
    zero_neg_flag_enI, carry_flag_enI,
    flags_bakO_O, flags_restoreO_O, set_carryI,
    reg_write_back_O,
    mem_input_mux_sel_O,
    alu_mux_sel_O,
    port_read_O, port_write_O: std_logic;

    signal write_back_mux_sel_O, mem_address_mux_sel_O: std_logic_vector(1 downto 0);

    signal alu_oper_O, sendPC_exI,
    mem_oper_O, rd_O: std_logic_vector(2 downto 0);

    signal d1_O, d2_O, immediate_O: std_logic_vector(15 downto 0);

    signal PCnO, PCO: std_logic_vector(31 downto 0);

-- declare signals from execute
    signal alu_zero_flag, alu_neg_flag, alu_carry_flag: std_logic;
    signal alu_res: std_logic_vector(15 downto 0);
    signal alu_res32: std_logic_vector(31 downto 0);

-- declare signals from execute_memory_buffer 
    signal flags_bakI, flags_restI,
    reg_write_back_OO,
    mem_input_mux_sel_OO,
    port_read_OO, port_write_OO,
    sendPC_memOO: std_logic;

    signal write_back_mux_sel_OO,
    mem_address_mux_sel_OO: std_logic_vector(1 downto 0);

    signal mem_oper_OO, rd_OO: std_logic_vector(2 downto 0);

    signal alu_resO, d2_OO: std_logic_vector(15 downto 0);

    signal PCnOO, PCOO: std_logic_vector(31 downto 0);
   
-- declare signals from memory
    signal sendPC_memI: std_logic;

    signal wb_data: std_logic_vector(15 downto 0);
    signal mem_res32: std_logic_vector(31 downto 0);

-- declare signals from memory_writeback_buffer
    signal regW: std_logic;
    signal rdO: std_logic_vector(2 downto 0);
    signal datain: std_logic_vector(15 downto 0);

begin

  fetch:                   entity work.fetch  
  port map(
  -- INPUTS
    rst, clk, frez_fetch_dec_buf, unfrez_fetch_dec_buf,
    flsh_fetch_dec_buf, alu_res32, mem_res32, PC_mux_sel,
  -- OUTPUTS
    PCn, PC, ctrl_bits, rd, r1, r2, immediate);

  -- FETCH DECDE BUFFER IS INSIDE FETCH STAGE

  decode_stage:                  entity work.decode_stage
  port map(
  -- INPUTS
    clk, rst, r1, r2 , rdO,
    regW, datain, ctrl_bits,
    sendPC_memI, zero_neg_flag_enI, carry_flag_enI,
    flags_bakI, flags_restI, set_carryI,
    alu_carry_flag, alu_zero_flag, alu_neg_flag,
    sendPC_exI,

  -- OUTPUTS
    d1, d2,
    sendPC_memO, frez_fetch_dec_buf, flsh_fetch_dec_buf,
    flsh_dec_exec_buf, unfrez_fetch_dec_buf,
    zero_neg_flag_enO, carry_flag_enO,
    flags_bakO, flags_restoreO, set_carryO,
    reg_write_back, mem_input_mux_sel,
    alu_mux_sel, port_read, port_write,

    PC_mux_sel, write_back_mux_sel,
    mem_address_mux_sel,

    alu_oper, sendPC_exO, mem_oper); 
    

  decode_execute_buf:   entity work.decode_execute_buf  
  port map(
  -- INPUTS
    clk, rst, d1, d2, rd,
    immediate, sendPC_memO,
    flsh_dec_exec_buf, zero_neg_flag_enO, carry_flag_enO,
    flags_bakO, flags_restoreO, set_carryO,
    reg_write_back, mem_input_mux_sel,
    alu_mux_sel, port_read, port_write,
    write_back_mux_sel,
    mem_address_mux_sel,
    alu_oper, sendPC_exO, mem_oper,
    PCn, PC,
  -- OUTPUTS
    d1_O, d2_O, rd_O,
    immediate_O, sendPC_memO_O,
    zero_neg_flag_enI, carry_flag_enI,
    flags_bakO_O, flags_restoreO_O, set_carryI,
    reg_write_back_O,
    mem_input_mux_sel_O,
    alu_mux_sel_O,
    port_read_O, port_write_O,
    write_back_mux_sel_O,
    mem_address_mux_sel_O,
    alu_oper_O, sendPC_exI,
    mem_oper_O,
    PCnO, PCO );

  execute_stage:                 entity work.execute_stage  
  port map(
  -- INPUTS
    d1_O, d2_O, immediate,
    alu_oper_O, alu_mux_sel_O,
  -- OUTPUTS
    alu_zero_flag, alu_neg_flag, alu_carry_flag,
    alu_res, alu_res32 );

  execute_memory_buf:   entity work.execute_memory_buf  
  port map(
  -- INPUTS
    clk, rst,
    d2_O, rd_O,
    flags_bakO_O, flags_restoreO_O,
    sendPC_memO_O,
    reg_write_back_O,
    mem_input_mux_sel_O,
    port_read_O, port_write_O,
    write_back_mux_sel_O,
    mem_address_mux_sel_O,
    mem_oper_O, alu_res,
    PCnO, PCO,
  -- OUTPUS
    d2_OO, rd_OO,
    flags_bakI, flags_restI,
    sendPC_memOO,
    reg_write_back_OO,
    mem_input_mux_sel_OO,
    port_read_OO, port_write_OO,
    write_back_mux_sel_OO,
    mem_address_mux_sel_OO,
    mem_oper_OO, alu_resO,
    PCnOO, PCOO );
   


  memory:                  entity work.memory  
  port map(
  -- INPUTS
    rst, clk, sendPC_memOO,
    flags_bakI, flags_restI,
    mem_input_mux_sel_OO,
    port_read_OO, port_write_OO,

    write_back_mux_sel_OO,
    mem_address_mux_sel_OO,

    mem_oper_OO,

    port_inp, d2_OO,
    alu_resO,
    PCnOO, PCOO,
  -- OUTPUTS
    sendPC_memI,

    wb_data, port_outp, mem_res32 ); 

memory_writeback_buffer: entity work.memory_writeback_buffer  
  port map(
  -- INPUTS
    rst, clk,
    reg_write_back_OO,
    rd_OO, wb_data,
  -- OUTPUTS
    regW,
    rdO, datain );  

end architecture;







