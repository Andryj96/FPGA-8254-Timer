----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    20:50:41 05/13/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    LD_DATA_FSM
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 State Machine for control count's data load
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LD_DATA_FSM is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           LD0 : out  STD_LOGIC;
           LD1 : out  STD_LOGIC;
           LD2 : out  STD_LOGIC);
end LD_DATA_FSM;

architecture Behavioral of LD_DATA_FSM is

type states is (ST0, ST1, ST2, ST3);

signal load, n_load : std_logic;
signal state, next_state : states;

begin

process(CLK,CE)
	begin
		if rising_edge(CLK) then
			if RST = '0' then
				state <= ST0;
				load <= '0';
			elsif CE = '1' then
				state <= next_state;
				load <= n_load;
			end if;
		end if;
	end process;
	
	NEXT_STATE_LOGIC: process(state, WR, load)
	begin
		next_state <= state;
		n_load <= load;
		case(state) is
			when ST0 => 
				if WR = '0' then 
					next_state <= ST1;
				end if;
			when ST1 =>
				if WR = '1' then
					next_state <= ST2;
				end if;
			when ST2 =>
				if WR = '0' then
					next_state <= ST3;
				end if;
			when ST3 =>
				next_state <= ST0;
				n_load <= '1';
			when others => 
				next_state <= state;

			end case;
	end process;	
	
	OUPUT_LOGIC: process(state, load)
	begin
		LD2 <= load;
		case(state) is
			when ST0 =>
				LD0 <= '0';
				LD1 <= '0';
			when ST1 =>
				LD0 <= '1';
				LD1 <= '0';
			when ST2 => 
				LD0 <= '0';
				LD1 <= '0';
			when ST3 => 
				LD0 <= '0';
				LD1 <= '1';
			when others =>
				LD0 <= '0';
				LD1 <= '0';
			end case;
	end process;
	
end Behavioral;

