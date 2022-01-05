library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity alu is

port (
	-- the two operands
		d1, d2 : IN std_logic_vector(15 downto 0);
	-- the operation type
		alu_opr : IN std_logic_vector(2 downto 0);
	-- the required flags
		zero_flag , neg_flag , carry_flag : OUT std_logic;
	-- alu result
		res : OUT std_logic_vector(15 downto 0);
	-- the PC (program counter) which is the alu result with sign extended
		pc : OUT std_logic_vector(31 downto 0)
	);

end entity;


architecture alu1 of alu is 

signal operand1 , operand2 , increment_op1  : std_logic_vector (16 downto 0);
signal sub_operand : std_logic_vector (16 downto 0);
signal sub_pre_res , add_res  : std_logic_vector (16 downto 0);
signal sub_res , res_temp : std_logic_vector(15 downto 0);

begin

operand1 <= '0' & d1 ;

operand2 <= '0' & d2 ;

sub_operand <= '0' & (NOT d2) ;

sub_pre_res <= operand1 + sub_operand ;

sub_res <= sub_pre_res(15 downto 0) + ("000000000000000" & sub_pre_res(16)) ;

add_res <= operand1 + operand2 ;

increment_op1 <= operand1 + 1 ;

res <= res_temp;

res_temp <= 	NOT d1  when alu_opr = "000"
	else d1 when alu_opr = "001"
	else d2 when alu_opr = "010"
	else sub_res when alu_opr = "011"
	else add_res(15 downto 0) when alu_opr = "100"
	else d1 and d2 when alu_opr = "101"
	else increment_op1 (15 downto 0) ;

carry_flag <= '0'  when alu_opr = "000"
	else '0' when alu_opr = "001"
	else '0' when alu_opr = "010"
	else sub_pre_res(16) when alu_opr = "011"
	else add_res(16) when alu_opr = "100"
	else '0' when alu_opr = "101"
	else increment_op1 (16) ;

zero_flag <= '1' when to_integer(unsigned(res_temp)) = 0
	else '0' ;

neg_flag <= '1' when d1 < d2 and alu_opr = "011"
	else '0' ;

pc <= "0000000000000000" & res_temp ;


end architecture;
