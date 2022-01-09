library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity decode_stage is

port (
  -- the main clock
    clk, rst : IN std_logic;
----------------------------------------------------
  -- inputs concerning register file
    -- the addresses of reg1 , reg2 and destination register
    r1 , r2 , rd  : IN std_logic_vector (2 downto 0);
    -- the register write signal 
    regW : IN std_logic;
    -- and the input data (for write back)
    datain : IN std_logic_vector(15 downto 0);

------------------------------------------------------
  -- inputs concerning the control unit
    -- 2 bits => operation type  and 3 bits => function
    instr_ctrl_bits:  in  std_logic_vector(4 downto 0);
    -- sent from the memeory stage
    sendPC_memI,
    -- signals sent to the CU from decode/execute buffer
    zero_neg_flag_enI, carry_flag_enI,
    flags_bakI, flags_restI, set_carryI,
    -- signals sent to the CU from the AlU
    alu_carry_flag, alu_zero_flag, alu_neg_flag:  in  std_logic;
    -- sent from the decode/execute buffer
    sendPC_exI:  in  std_logic_vector(2 downto 0);

------------------------------------------------------
  -- outputs concerning register file
    -- the dataRead1 and dataRead2 
    d1 , d2  : OUT std_logic_vector(15 downto 0);

-------------------------------------------------------
  -- outputs concerning the control unit
    alu_or_PCn, sendPC_memO,
    frez_fetch_dec_buf, flsh_fetch_dec_buf,
    flsh_dec_exec_buf,
    unfrez_fetch_dec_buf,
    zero_neg_flag_enO, carry_flag_enO,
    flags_bakO, flags_restoreO, set_carryO,
    reg_write_back,
    -- data2 or next PC
    mem_input_mux_sel,
    -- imm or data2 
    alu_mux_sel,
    port_read, port_write:  out  std_logic;

    -- pc+1 or alu res or mem res
    PC_mux_sel, 
    --- mem res, alu res, port res
    write_back_mux_sel,
    -- alu res or stack pointer or INT
    mem_address_mux_sel:  out std_logic_vector(1 downto 0);

    -- not, pass_1, pass_2, sub, add, and
    alu_oper,
    -- no branch, branch zero, branch neg, branch carr, BRANCH ALWAYS
    sendPC_exO,
    -- mem/stack | read/write | 16/32
    mem_oper:  out  std_logic_vector(2 downto 0);
    
    memEn, flsh_exec_mem_buf:  out std_logic
    );

end entity;


architecture decode1 of decode_stage is


begin

registerFile: entity work.reg_file port map ( r1, r2, rd, regW, clk, rst, datain, d1, d2 );

controlUnit: entity work.control_unit port map (
              rst, clk, sendPC_memI,
              zero_neg_flag_enI, carry_flag_enI,
              flags_bakI, flags_restI, set_carryI,
              alu_carry_flag, alu_zero_flag, alu_neg_flag,
              sendPC_exI, instr_ctrl_bits,
              sendPC_memO,
              frez_fetch_dec_buf, flsh_fetch_dec_buf,
              flsh_dec_exec_buf,
              unfrez_fetch_dec_buf,
              zero_neg_flag_enO, carry_flag_enO,
              flags_bakO, flags_restoreO, set_carryO,
              reg_write_back,
              mem_input_mux_sel, alu_mux_sel, port_read, port_write,
              PC_mux_sel, write_back_mux_sel, mem_address_mux_sel,
              alu_oper, sendPC_exO, mem_oper, alu_or_PCn,
              memEn, flsh_exec_mem_buf
            );




end architecture;








