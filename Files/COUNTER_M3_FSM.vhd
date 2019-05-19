----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hern�ndez Rodr�guez
-- 
-- Create Date:    22:35:12 05/12/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    COUNTER_M3_FSM 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 State Machine for Mode 3 Timer Control
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_arith.ALL;

entity COUNTER_M3_FSM is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           thresh0 : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           gate : in  STD_LOGIC;
           ce : out  STD_LOGIC;
           load : out  STD_LOGIC;
           TOUT : out  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (15 downto 0);
           Q : in  STD_LOGIC_VECTOR (15 downto 0));
end COUNTER_M3_FSM;

architecture Behavioral of COUNTER_M3_FSM is

	type stetes is (ST0, ST1, ST2);

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
	
	NEXT_STATE_LOGIC: process(state, gate, thresh0)
	begin
		next_state <= state;
		case(state) is
			when ST0 => 
				if gate = '1' then 
					next_state <= ST1;
				end if;
			when ST1 =>
				if gate = '0' then 
					next_state <= ST2;
				elsif thresh0 = '1' then
					next_state <= ST0;
				end if;
			when ST2 =>
				if gate = '1' then
					next_state <= ST1;
				end if;
			when others => 
				next_state <= state;
			end case;
	end process;	
	
	OUPUT_LOGIC: process(state, gate, Q, D)
	begin
		case(state) is
			when ST0 =>
				load <= '1';
				ce <= '1';
			when ST1 =>
				load <= '0';
				ce <= '1';
			when ST2 => 
				load <= '0';
				ce <= '0';
			when others =>
				load <= '1';
				ce <= '1';
		end case;
		
		if gate = '1' then
			if conv_integer(Q) >= (conv_integer(D) + 1)/2 then
				TOUT <= '1';
			else
				TOUT <= '0';
			end if;
		else
			TOUT <= '1';
		end if;
	end process;


end Behavioral;

