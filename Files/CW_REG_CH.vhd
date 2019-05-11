----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    10:41:33 05/08/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    CW_REG_CH
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Control Word Register for individual channel
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CW_REG_CH is
    Port ( CS : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (1 downto 0);
           M : out  STD_LOGIC;
           RW : out  STD_LOGIC;
           RDY : out  STD_LOGIC);
end CW_REG_CH;

architecture Behavioral of CW_REG_CH is	
	
	type stetes is (ST0, ST1, ST2, ST3);
	
	signal state, next_state : stetes;
	signal mode, n_mode : std_logic;
	
begin
	
	process(CLK,CS)
	begin
		if CS = '0' then
			if rising_edge(CLK) then
				if RST = '0' then
					state <= ST0;
					mode <= '0';
				else
					state <= next_state;
					mode <= n_mode;
				end if;
			end if;
		end if;	
	end process;
	
	NEXT_STATE_LOGIC: process(state, EN, D, mode)
	begin
		next_state <= state;
		n_mode <= mode;
		case(state) is
			when ST0 => 
				if EN = '1' and D(1) = '0' then 
					next_state <= ST1;
				end if;
			when ST1 =>
				if EN = '1' then
					n_mode <= D(0);
					if D(1) = '0' then
						next_state <= ST2;
					else
						next_state <= ST3;
					end if;
				end if;
			when ST2 =>
				if EN = '1' then
					if D(1) = '0' then
						next_state <= ST1;
					else
						next_state <= ST3;
					end if;
				end if;
			when ST3 =>
				if EN = '1' then
					next_state <= ST1;
				end if; 
			when others => 
				next_state <= state;
			end case;
	end process;	
	
	OUPUT_LOGIC: process(state, mode)
	begin
		case(state) is
			when ST0 =>
				RW <= '0';
				M <= '0';
				RDY <= '0';
			when ST1 =>
				RW <= '0';
				M <= mode;
				RDY <= '1';
			when ST2 => 
				RW <= '0';
				M <= mode;
				RDY <= '1';
			when ST3 => 
				RW <= '1';
				M <= mode;
				RDY <= '1';
			when others =>
				RW <= '0';
				M <= '0';
				RDY <= '0';
			end case;
	end process;
end Behavioral;

