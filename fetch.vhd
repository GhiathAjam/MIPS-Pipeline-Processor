LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
	
ENTITY fetch IS PORT (
  rst, clk, freeze, unfreeze, flush : IN STD_LOGIC;
  alu_res, mem_res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

  PCn_O, PC_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  control_bits : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
  rd, rs, rt : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
  offset : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END;

ARCHITECTURE fetch_a OF fetch IS

  SIGNAL one_or_two : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL pc_out, adder_res, new_pc, instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

  Mux2x1 : ENTITY work.mux2x1 PORT MAP ("01", "10", instruction(0), one_or_two);
  Adder : ENTITY work.pcadder PORT MAP (one_or_two, pc_out, adder_res);
  Mux3x1 : ENTITY work.mux3x1 PORT MAP (adder_res, alu_res, mem_res, sel, new_pc);
  PC : ENTITY work.register32bit PORT MAP (new_pc, clk, rst, pc_out);
  InstructionMemory : ENTITY work.instructionmemory PORT MAP (pc_out(9 DOWNTO 0), instruction);
  FetchDecodeBuffer : ENTITY work.fetch_decode_buffer PORT MAP (adder_res, pc_out, instruction, clk, rst, flush, freeze, unfreeze, PCn_O, PC_O, control_bits, rd, rs, rt, offset);

END;