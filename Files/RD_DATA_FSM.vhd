----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    23:27:11 05/13/2019 
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

entity RD_DATA_FSM is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           RW : in  STD_LOGIC;
           RD : in  STD_LOGIC;
           OE0 : out  STD_LOGIC;
           OE1 : out  STD_LOGIC;
           LD0 : out  STD_LOGIC;
           LD1 : out  STD_LOGIC);
end RD_DATA_FSM;

architecture Behavioral of RD_DATA_FSM is

type states is (ST0, ST1, ST2, ST3, ST4);

signal state, next_state : states;

begin
 
process(CLK,CE)
	begin
		if rising_edge(CLK) then
			if RST = '0' then
				state <= ST0;
			elsif CE = '1' then
				state <= next_state;
			end if;
		end if;
	end process;
	
	NEXT_STATE_LOGIC: process(state, RD, RW)
	begin
		next_state <= state;
		case(state) is
			when ST0 => 
				if RW = '1' and RD = '1' then 
						next_state <= ST1;
				end if;
			when ST1 =>
				next_state <= ST2;
			when ST2 =>
				if RD = '0' then
					next_state <= ST3;
				end if;
			when ST3 =>
				if RD = '0' then
					next_state <= ST4;
				end if;
			when ST4 =>
					next_state <= ST0;
			when others => 
				next_state <= state;

			end case;
	end process;	
	
	OUPUT_LOGIC: process(state)
	begin
		LD0 <= '0';
		LD1 <= '0';
		OE0 <= '1';  --HZ
		OE1 <= '1';	 --HZ
		case(state) is
			when ST0 =>
			when ST1 =>
				LD0 <= '1';
				LD1 <= '1';
			when ST2 => 
			when ST3 => 
				OE0 <= '0';
			when ST4 => 
				OE1 <= '0';
			when others =>
			end case;
	end process;
	
end Behavioral;

