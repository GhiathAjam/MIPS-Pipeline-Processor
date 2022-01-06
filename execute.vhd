library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity execute_stage is

port (
	-- the two operands
		d1, d2, immediate : IN std_logic_vector(15 downto 0);
	-- the operation type
		alu_opr : IN std_logic_vector(2 downto 0);
	-- ALU mus selectors
		alu_mux_sel : IN std_logic;
	-- the required flags
		zero_flag , neg_flag , carry_flag : OUT std_logic;
	-- alu result
		res : OUT std_logic_vector(15 downto 0);
	-- the PC (program counter) which is the alu result with sign extended
		pc : OUT std_logic_vector(31 downto 0)
	);

end entity;


architecture execute of execute_stage is

signal second_operand : std_logic_vector(15 downto 0);

begin

second_operand <= d2 when alu_mux_sel = '1'
	else immediate;

alu_unit: entity work.alu port map (d1, second_operand, alu_opr, zero_flag, neg_flag, carry_flag, res, pc) ;

end architecture;