LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity reg_file is

port  (
	-- the addresses of reg1 , reg2 and destination register
 	r1 , r2 , rd  : IN std_logic_vector (2 downto 0);
	-- the register write signal and the clk and reset
	regW , clk , rst : IN std_logic;
	-- and the input data
	datain : IN std_logic_vector(15 downto 0); 
	-- the dataRead1 and dataRead2 
	d1 , d2  : OUT std_logic_vector(15 downto 0)
	);

end entity;


architecture reg_file1 of reg_file is

TYPE ram_type IS ARRAY(0 TO 7) OF std_logic_vector(15 DOWNTO 0);
SIGNAL reg_ram : ram_type ;


begin
	
	PROCESS(clk , regW) IS
		BEGIN
			IF rst = '1' THEN
				reg_ram(0) <= (others => '0');
				reg_ram(1) <= (others => '0');
				reg_ram(2) <= (others => '0');
				reg_ram(3) <= (others => '0');
				reg_ram(4) <= (others => '0');
				reg_ram(5) <= (others => '0');
				reg_ram(6) <= (others => '0');
				reg_ram(7) <= (others => '0');
			ELSIF falling_edge(clk) THEN  
				IF regW = '1' THEN
					reg_ram(to_integer(unsigned(rd))) <= datain;
			
				END IF;
		
			END IF;
			
		END PROCESS;
		d1 <= reg_ram(to_integer(unsigned(r1)));
		d2 <= reg_ram(to_integer(unsigned(r2)));


end architecture;
