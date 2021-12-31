library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode_execute_buf is

port	(
	-- the main clock
		clk : IN std_logic;
-----------------------------------------------------------
	-- inputs concerning the register file
		d1_I, d2_I  : IN std_logic_vector(15 downto 0);
		rd_I : IN std_logic_vector(2 downto 0);
-----------------------------------------------------------------
	-- input concerning the Immediate value
		immediate_I : IN std_logic_vector(15 downto 0);
-----------------------------------------------------------------
	-- inputs concerning the control unit
		sendPC_memO_I,
  		frez_fetch_dec_buf_I, flsh_fetch_dec_buf_I,
  		flsh_dec_exec_buf_I,
  		unfrez_fetch_dec_buf_I,
  		zero_neg_flag_enO_I, carry_flag_enO_I,
  		flags_bakO_I, flags_restoreO_I, set_carryO_I,
  		reg_write_back_I,
  		-- data2 or next PC
  		mem_input_mux_sel_I,
  		-- imm or data2 
		alu_mux_sel_I,
  		port_read_I, port_write_I:  IN  std_logic;
        ------------------------------------------
 		-- pc+1 or alu res or mem res
		PC_mux_sel_I, 
  		--- mem res, alu res, port res
  		write_back_mux_sel_I,
  		-- alu res or stack pointer or INT
  		mem_address_mux_sel_I:  IN std_logic_vector(1 downto 0);
	-------------------------------------------
	  -- not, pass_1, pass_2, sub, add, and
  		alu_oper_I,
  	  -- no branch, branch zero, branch neg, branch carr, BRANCH ALWAYS
  		sendPC_exO_I,
  	  -- mem/stack | read/write | 16/32
  		mem_oper_I:  IN  std_logic_vector(2 downto 0);
--------------------------------------------------------------
	-- outputs concerning the reg file
		d1_O, d2_O  : OUT std_logic_vector(15 downto 0);
		rd_O : OUT std_logic_vector(2 downto 0);
-----------------------------------------------------------------
	-- output concerning the Immediate value
		immediate_O : OUT std_logic_vector(15 downto 0);
-----------------------------------------------------------------
	-- outputs concerning the control unit
		sendPC_memO_O,
  		frez_fetch_dec_buf_O, flsh_fetch_dec_buf_O,
  		flsh_dec_exec_buf_O,
  		unfrez_fetch_dec_buf_O,
  		zero_neg_flag_enO_O, carry_flag_enO_O,
  		flags_bakO_O, flags_restoreO_O, set_carryO_O,
  		reg_write_back_O,
  		-- data2 or next PC
  		mem_input_mux_sel_O,
  		-- imm or data2 
		alu_mux_sel_O,
  		port_read_O, port_write_O:  OUT  std_logic;
  	------------------------------------------
 		-- pc+1 or alu res or mem res
		PC_mux_sel_O, 
  		--- mem res, alu res, port res
  		write_back_mux_sel_O,
  		-- alu res or stack pointer or INT
  		mem_address_mux_sel_O:  OUT std_logic_vector(1 downto 0);
	-------------------------------------------
	  -- not, pass_1, pass_2, sub, add, and
  		alu_oper_O,
  	  -- no branch, branch zero, branch neg, branch carr, BRANCH ALWAYS
  		sendPC_exO_O,
  	  -- mem/stack | read/write | 16/32
  		mem_oper_O:  OUT  std_logic_vector(2 downto 0)


	);

end entity;


architecture dec_ex_buf of decode_execute_buf is

constant SIGNALS_BITS:  integer := 81;
signal out_vec:		std_logic_vector(0 to SIGNALS_BITS-1);

begin
 -- 1 bit
  (sendPC_memO_O,
  frez_fetch_dec_buf_O, flsh_fetch_dec_buf_O,
  flsh_dec_exec_buf_O,
  unfrez_fetch_dec_buf_O,
  zero_neg_flag_enO_O, carry_flag_enO_O,
  flags_bakO_O, flags_restoreO_O, set_carryO_O,
  reg_write_back_O,
  mem_input_mux_sel_O,
  alu_mux_sel_O,
  port_read_O, port_write_O) <= out_vec(0 to 14);

  -- 2 bits
  PC_mux_sel_O             <= out_vec(15 to 16);
  write_back_mux_sel_O     <= out_vec(17 to 18);
  mem_address_mux_sel_O    <= out_vec(19 to 20);

-- 3 bits
  sendPC_exO_O             <= out_vec(21 to 23);
  alu_oper_O               <= out_vec(24 to 26);
  mem_oper_O               <= out_vec(27 to 29);

-- reg file destination
  rd_O 	 <= out_vec(30 to 32);
-- reg file data read
  d1_O <= out_vec(33 to 48);
  d2_O <= out_vec(49 to 64);
-- the immediate value
  immediate_O <= out_vec(65 to 80);


	process (clk, flsh_dec_exec_buf_I) is
	begin
		IF (flsh_dec_exec_buf_I = '1') then
			out_vec <= (others => '0');	
		elsif (falling_edge(clk)) then
			out_vec(0 to 14) <= (sendPC_memO_I,
  						frez_fetch_dec_buf_I, flsh_fetch_dec_buf_I,
  						flsh_dec_exec_buf_I,
  						unfrez_fetch_dec_buf_I,
  						zero_neg_flag_enO_I, carry_flag_enO_I,
  						flags_bakO_I, flags_restoreO_I, set_carryO_I,
  						reg_write_back_I,
  						mem_input_mux_sel_I,
  						alu_mux_sel_I,
  						port_read_I, port_write_I);
		
			

			--out_vec(15 to 20) <=  ( PC_mux_sel_I, write_back_mux_sel_I, mem_address_mux_sel_I );
			out_vec(15 to 16) <= PC_mux_sel_I ;
			out_vec(17 to 18) <= write_back_mux_sel_I ;
			out_vec(19 to 20) <= mem_address_mux_sel_I ;			



			--out_vec(21 to 29) <= ( sendPC_exO_I, alu_oper_I, mem_oper_I );
			out_vec(21 to 23) <= sendPC_exO_I;
			out_vec(24 to 26) <= alu_oper_I;
			out_vec(27 to 29) <= mem_oper_I;

			--out_vec(30 to 64) <= ( rd_I, d1_I, d2_I );
			out_vec(30 to 32) <= rd_I ;
			out_vec(33 to 48) <= d1_I ;
			out_vec(49 to 64) <= d2_I ;


			out_vec(65 to 80) <= immediate_I;

		END IF;


	end process;


end architecture;






