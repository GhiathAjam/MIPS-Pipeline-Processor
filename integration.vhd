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
    signal PCn_o_f, PC_o_f: std_logic_vector(31 downto 0);
    signal ctrl_bits_o_f: std_logic_vector(4 downto 0);
    signal rd_o_f, r1_o_f, r2_o_f: std_logic_vector(2 downto 0);
    signal immediate_o_f: std_logic_vector(15 downto 0);

-- declare signals from decode
    signal d1_o_d, d2_o_d: std_logic_vector(15 downto 0);

    signal sendPC_mem_o_d, frez_fetch_dec_buf_o_d, flsh_fetch_dec_buf_o_d,
    flsh_dec_exec_buf_o_d, unfrez_fetch_dec_buf_o_d,
    zero_neg_flag_en_o_d, carry_flag_en_o_d,
    flags_bak_o_d, flags_restore_o_d, set_carry_o_d,
    reg_write_back_o_d, mem_input_mux_sel_o_d,
    alu_mux_sel_o_d, port_read_o_d, port_write_o_d, alu_PCn_o_d,
    memEn_o_d  : std_logic;

    signal PC_mux_sel_o_d, write_back_mux_sel_o_d,
    mem_address_mux_sel_o_d: std_logic_vector(1 downto 0);

    signal alu_oper_o_d, sendPC_ex_o_d, mem_oper_o_d: std_logic_vector(2 downto 0);
 
-- declare signals from decode_execute_buffer
    signal sendPC_mem_o_d_b,
    zero_neg_flag_enI_d, carry_flag_enI_d,
    flags_bak_o_d_b, flags_restore_o_d_b, set_carryI_d,
    reg_write_back_o_d_b,
    mem_input_mux_sel_o_d_b,
    alu_mux_sel_o_d_b,
    port_read_o_d_b, port_write_o_d_b,
    memEn_o_d_b   : std_logic;

    signal write_back_mux_sel_o_d_b, mem_address_mux_sel_o_d_b: std_logic_vector(1 downto 0);

    signal alu_oper_o_d_b, sendPC_exI_d,
    mem_oper_o_d_b, rd_o_d_b: std_logic_vector(2 downto 0);

    signal d1_o_d_b, d2_o_d_b, immediate_o_d_b: std_logic_vector(15 downto 0);

    signal PCn_o_d_b, PC_o_d_b: std_logic_vector(31 downto 0);

-- declare signals from execute
    signal alu_zero_flag_o_e, alu_neg_flag_o_e, alu_carry_flag_o_e: std_logic;
    signal alu_res_o_e: std_logic_vector(15 downto 0);
    signal alu_res32_o_e: std_logic_vector(31 downto 0);

-- declare signals from execute_memory_buffer 
    signal flags_bakI_d, flags_restI_d,
    reg_write_back_o_e_b,
    mem_input_mux_sel_o_e_b,
    port_read_o_e_b, port_write_o_e_b,
    sendPC_mem_o_e_b: std_logic;

    signal write_back_mux_sel_o_e_b,
    mem_address_mux_sel_o_e_b: std_logic_vector(1 downto 0);

    signal mem_oper_o_e_b, rd_o_e_b: std_logic_vector(2 downto 0);

    signal alu_res_o_e_b, d2_o_e_b: std_logic_vector(15 downto 0);

    signal PCn_o_e_b, PC_o_e_b: std_logic_vector(31 downto 0);
   
    signal memEn_o_e_b: std_logic;

-- declare signals from memory
    signal sendPC_memI_d: std_logic;

    signal wb_data_o_m: std_logic_vector(15 downto 0);
    signal mem_res32_o_m: std_logic_vector(31 downto 0);

-- declare signals from memory_writeback_buffer
    signal regW_o_w_b: std_logic;
    signal rd_o_w_b: std_logic_vector(2 downto 0);
    signal datain_o_w_b: std_logic_vector(15 downto 0);

begin

  --
  -- FETCH
  --
  fetch:                   entity work.fetch  
  port map(
  -- INPUTS
    rst, clk, frez_fetch_dec_buf_o_d, unfrez_fetch_dec_buf_o_d,
    flsh_fetch_dec_buf_o_d, alu_PCn_o_d, alu_res32_o_e, mem_res32_o_m, PCn_o_d_b, PC_mux_sel_o_d,
  -- OUTPUTS
    PCn_o_f, PC_o_f, ctrl_bits_o_f, rd_o_f, r1_o_f, r2_o_f, immediate_o_f);

  -- FETCH DECDE BUFFER IS INSIDE FETCH STAGE

  --
  -- DECODE
  --
  decode_stage:                  entity work.decode_stage
  port map(
  -- INPUTS
    clk, rst, r1_o_f, r2_o_f , rd_o_w_b,
    regW_o_w_b, datain_o_w_b, ctrl_bits_o_f,
    sendPC_memI_d, zero_neg_flag_enI_d, carry_flag_enI_d,
    flags_bakI_d, flags_restI_d, set_carryI_d,
    alu_carry_flag_o_e, alu_zero_flag_o_e, alu_neg_flag_o_e,
    sendPC_exI_d,

  -- OUTPUTS
    d1_o_d, d2_o_d, alu_PCn_o_d,
    sendPC_mem_o_d, frez_fetch_dec_buf_o_d, flsh_fetch_dec_buf_o_d,
    flsh_dec_exec_buf_o_d, unfrez_fetch_dec_buf_o_d,
    zero_neg_flag_en_o_d, carry_flag_en_o_d,
    flags_bak_o_d, flags_restore_o_d, set_carry_o_d,
    reg_write_back_o_d, mem_input_mux_sel_o_d,
    alu_mux_sel_o_d, port_read_o_d, port_write_o_d,

    PC_mux_sel_o_d, write_back_mux_sel_o_d,
    mem_address_mux_sel_o_d,

    alu_oper_o_d, sendPC_ex_o_d, mem_oper_o_d,
    memEn_o_d); 
    

  --
  -- DECODE EXCUTE BUFFER
  --
  decode_execute_buf:   entity work.decode_execute_buf  
  port map(
  -- INPUTS
    clk, rst, d1_o_d, d2_o_d, rd_o_f,
    immediate_o_f, sendPC_mem_o_d,
    flsh_dec_exec_buf_o_d, zero_neg_flag_en_o_d, carry_flag_en_o_d,
    flags_bak_o_d, flags_restore_o_d, set_carry_o_d,
    reg_write_back_o_d, mem_input_mux_sel_o_d,
    alu_mux_sel_o_d, port_read_o_d, port_write_o_d,
    write_back_mux_sel_o_d,
    mem_address_mux_sel_o_d,
    alu_oper_o_d, sendPC_ex_o_d, mem_oper_o_d,
    PCn_o_f, PC_o_f,
    memEn_o_d,
  -- OUTPUTS
    d1_o_d_b, d2_o_d_b, rd_o_d_b,
    immediate_o_d_b, sendPC_mem_o_d_b,
    zero_neg_flag_enI_d, carry_flag_enI_d,
    flags_bak_o_d_b, flags_restore_o_d_b, set_carryI_d,
    reg_write_back_o_d_b,
    mem_input_mux_sel_o_d_b,
    alu_mux_sel_o_d_b,
    port_read_o_d_b, port_write_o_d_b,
    write_back_mux_sel_o_d_b,
    mem_address_mux_sel_o_d_b,
    alu_oper_o_d_b, sendPC_exI_d,
    mem_oper_o_d_b,
    PCn_o_d_b, PC_o_d_b,
    memEn_o_d_b );


  --
  -- EXCUTE
  --
  execute_stage:                 entity work.execute_stage  
  port map(
  -- INPUTS
    d1_o_d_b, d2_o_d_b, immediate_o_d_b,
    alu_oper_o_d_b, alu_mux_sel_o_d_b,
  -- OUTPUTS
    alu_zero_flag_o_e, alu_neg_flag_o_e, alu_carry_flag_o_e,
    alu_res_o_e, alu_res32_o_e );

  --
  -- EXECUTE MEMOTY BUFFER
  --
  execute_memory_buf:   entity work.execute_memory_buf  
  port map(
  -- INPUTS
    clk, rst,
    d2_o_d_b, rd_o_d_b,
    flags_bak_o_d_b, flags_restore_o_d_b,
    sendPC_mem_o_d_b,
    reg_write_back_o_d_b,
    mem_input_mux_sel_o_d_b,
    port_read_o_d_b, port_write_o_d_b,
    write_back_mux_sel_o_d_b,
    mem_address_mux_sel_o_d_b,
    mem_oper_o_d_b, alu_res_o_e,
    PCn_o_d_b, PC_o_d_b,
    memEn_o_d_b,
  -- OUTPUS
    d2_o_e_b, rd_o_e_b,
    flags_bakI_d, flags_restI_d,
    sendPC_mem_o_e_b,
    reg_write_back_o_e_b,
    mem_input_mux_sel_o_e_b,
    port_read_o_e_b, port_write_o_e_b,
    write_back_mux_sel_o_e_b,
    mem_address_mux_sel_o_e_b,
    mem_oper_o_e_b, alu_res_o_e_b,
    PCn_o_e_b, PC_o_e_b,
    memEn_o_e_b );
   

  --
  -- MEMORY
  --
  memory:                  entity work.memory  
  port map(
  -- INPUTS
    rst, clk, sendPC_mem_o_e_b,
    flags_bakI_d, flags_restI_d,
    mem_input_mux_sel_o_e_b,
    port_read_o_e_b, port_write_o_e_b,
    memEn_o_e_b,

    write_back_mux_sel_o_e_b,
    mem_address_mux_sel_o_e_b,

    rd_o_e_b,
    mem_oper_o_e_b,

    port_inp, d2_o_e_b,
    alu_res_o_e_b,
    PCn_o_e_b, PC_o_e_b,
  -- OUTPUTS
    sendPC_memI_d,

    wb_data_o_m, port_outp, mem_res32_o_m ); 


  --
  -- MEMORY WRITEBACK BUFFER
  --
  memory_writeback_buffer: entity work.memory_writeback_buffer  
  port map(
  -- INPUTS
    rst, clk,
    reg_write_back_o_e_b,
    rd_o_e_b, wb_data_o_m,
  -- OUTPUTS
    regW_o_w_b,
    rd_o_w_b, datain_o_w_b );  

end architecture;







