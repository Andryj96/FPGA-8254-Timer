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

type states is (start, reading, read0, read1, waiting);

signal state, next_state : states;
signal load, n_load, ouput, n_ouput : std_logic;

begin
 
process(CLK,CE)
	begin
		if rising_edge(CLK) then
			if RST = '0' then
				state <= start;
				load <= '1';
				ouput <= '0';
			elsif CE = '1' then
				state <= next_state;
				load <= n_load;
				ouput <= n_ouput;
			end if;
		end if;
	end process;
	
	NEXT_STATE_LOGIC: process(state, RD, RW, load, ouput)
	begin
		next_state <= state;
		n_load <= load;
		n_ouput <= ouput;
		case(state) is
			when start => 
				if RW = '1' and RD = '1' then 
					next_state <= reading;
					n_load <= '0';
				elsif RD = '0' then
					n_load <= '1';
					next_state <= read0;
				end if;
			when reading =>
				if RD = '0' then
					next_state <= read0;
					n_ouput <= '0';
				end if;
			when read0 =>
				if RD = '1' then
					next_state <= waiting;
				end if;
			when waiting =>
				if RD = '0' then
					next_state <= read1;
					n_ouput <= '1';
				end if;
			when read1 =>
				if RD = '1' then
					next_state <= start;
				end if;
			when others => 
				next_state <= state;

			end case;
	end process;	
	
	OUPUT_LOGIC: process(state, load, ouput)
	begin
		LD0 <= load;
		LD1 <= load;
		OE0 <= ouput;
		OE1 <= not ouput;
	end process;
	
end Behavioral;

