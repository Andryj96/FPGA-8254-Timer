----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez & Dariel Suarez Gonzalez
-- 
-- Create Date:    17:58:33 05/05/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    Controller 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Controller for 8254
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CTRL_8254 is
		Generic(
			cw: std_logic_vector(7 downto 0) := "00000001";
			dir: std_logic_vector(2 downto 0) := "000";
			lsb: std_logic_vector(7 downto 0) := "00000000";
			msb: std_logic_vector(7 downto 0) := "00000000"
		);
    Port ( rst : in  STD_LOGIC;
           clk : in   STD_LOGIC;
           start : in   STD_LOGIC;
           WR : out  STD_LOGIC;
           do : out  STD_LOGIC_VECTOR (7 downto 0);
           addr : out  STD_LOGIC_VECTOR (2 downto 0));
end CTRL_8254;

architecture Behavioral of CTRL_8254 is

	type states is (Init, W0, W1, W2, wait0, wait1, wait2, wait3, wait4, wait5, wait6, wait7, wait8, wait9, wait10, wait11, wait12);
	signal state, next_state : states;
	signal data, data_n:   STD_LOGIC_VECTOR (7 downto 0);
    signal add, add_n:   STD_LOGIC_VECTOR (2 downto 0);

begin
	
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				state <= Init;
				add <= "000";
				data <= "00000000";
			else
				state <= next_state;
				add <= add_n;
				data <= data_n;
			end if;
		end if;
	end process;

	
	process(state, start, data, add)
	begin
		next_state <= state; 
		data_n <= data;
		add_n <= add;
		case(state) is
			when Init =>
				if start = '1' then
					next_state <= W0;
					data_n <= cw;
					add_n <= "111";
				end if;
			when W0 =>
				next_state <= wait0;
			when wait0 =>
				next_state <= wait1;
			when wait1 =>
				next_state <= wait2;
			when wait2 =>
				next_state <= wait3;
			when wait3 =>
				next_state <= wait4;
			when wait4 =>
				next_state <= W1;
				data_n <= lsb;
				add_n <= dir;
			
			when W1 =>
				next_state <= wait5;
			when wait5 =>
				next_state <= wait6;
			when wait6 =>
				next_state <= wait7;
			when wait7 =>
				next_state <= wait8;
			when wait8 =>
				next_state <= wait9;
			when wait9 =>
				next_state <= W2;
				data_n <= msb;
				add_n <= dir;

			when W2 =>
				next_state <= wait10;
			when wait10 =>
				next_state <= wait11;
			when wait11 =>
				next_state <= wait12;
			when wait12 =>
				next_state <= Init;

			
		end case;
	end process;

	process(state, add, data)
	begin
		addr <= add;
		do <= data;
		WR <= '1';
		case(state) is
		when Init =>
		when W0 =>
			WR <= '0';
		when wait0 =>
			WR <= '0';
		when wait1 =>
		when wait2 =>
		when wait3 =>
		
		when wait4 =>
		when W1 =>
			WR <= '0';
		when wait5 =>
			WR <= '0';
		when wait6 =>
		when wait7 =>
		when wait8 =>
		
		when wait9 =>
		when W2 =>
			WR <= '0';
		when wait10 =>
			WR <= '0';
		when wait11 =>
		when wait12 =>
		end case;
	end process;

end Behavioral;

