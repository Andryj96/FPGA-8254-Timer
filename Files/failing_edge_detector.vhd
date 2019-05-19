----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    23:51:33 06/05/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    Falling Edge Detector
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Detect signal falling edge and sync with clk
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity falling_edge_detector is
    Port ( 	clk : in  STD_LOGIC;
				cs : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            start : in  STD_LOGIC;
				pulse : out  STD_LOGIC);
end falling_edge_detector;

architecture Behavioral of falling_edge_detector is
	
	type stetes is (ST0, ST1, ST2, ST3);
	
	signal state, next_state : stetes;
	
begin
	
	process(CLK,CS)
	begin
		if rising_edge(CLK) then
			if RST = '1' then
				state <= ST0;
			elsif CS = '1' then
				state <= next_state;
			end if;
		end if;
	end process;
	
	NEXT_STATE_LOGIC: process(state, start)
	begin
		next_state <= state;
		case(state) is
			when ST0 => 
				if start = '0' then 
					next_state <= ST1;
				end if;
			when ST1 =>
						next_state <= ST2;
			when ST2 =>
						next_state <= ST3;
			when ST3 =>
						next_state <= ST0;

			when others => 
				next_state <= state;
			end case;
	end process;	
	
	OUPUT_LOGIC: process(state)
	begin
				pulse <= '1';
				case(state) is
			when ST0 =>
			when ST1 =>
			when ST2 =>
				pulse <= '0';
			when ST3 =>
				pulse <= '0';
			when others =>
				pulse <= '1';
			end case;
	end process;
end Behavioral;

