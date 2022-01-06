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
		res32 : OUT std_logic_vector(31 downto 0)
	);

end entity;


architecture alu1 of alu is 

signal operand1 , operand2 , increment_op1,
add_res, sub_res, res_temp: std_logic_vector(16 downto 0);

begin

	operand1 <= '0' & d1 ;
	operand2 <= '0' & d2 ;

	add_res <= operand1 + operand2;
	sub_res <= operand1 - operand2;
	increment_op1 <= operand1 + 1 ;

	-- 000- not FIRST OPERAND
	-- 001- pass first operand
	-- 010- pass second operand
	-- 011- sub
	-- 100- add
	-- 101- and
	-- 110- increment first operand

	res_temp <= 	NOT operand1  				when alu_opr = "000"
					else operand1								when alu_opr = "001"
					else operand2 							when alu_opr = "010"
					else sub_res 								when alu_opr = "011"
					else add_res								when alu_opr = "100"
					else operand1 and operand2	when alu_opr = "101"
					else increment_op1;

	zero_flag <= '1' when to_integer(unsigned(res_temp)) = 0
		else '0' ;

	neg_flag <= '1' when res_temp(15)='1'
		else '0';

	carry_flag <= res_temp(16);

	res <= res_temp(15 downto 0);
	res32 <= "0000000000000000" & res_temp(15 downto 0);

end architecture;
