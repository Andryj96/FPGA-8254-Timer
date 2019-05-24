----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez & Dariel Suarez Gonzalez
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
	
	type stetes is (ST0, ST1, ST2, ST3, ST4);
	
	signal state, next_state : stetes;
	signal mode, n_mode : std_logic;
	
begin
	
	process(CLK,CS)
	begin
		if rising_edge(CLK) then
			if RST = '1' then
				state <= ST0;
				mode <= '0';
			elsif CS = '1' then
				state <= next_state;
				mode <= n_mode;
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
					n_mode <= D(0);
				end if;
			when ST1 =>
				if EN = '1' then
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
				next_state <= ST4;
			when ST4 =>
				next_state <= ST1;
			when others => 
				next_state <= state;
			end case;
	end process;	
	
	OUPUT_LOGIC: process(state, mode)
	begin
	RW <= '0';
		case(state) is
			when ST0 =>
				M <= '0';
				RDY <= '0';
			when ST1 =>
				M <= mode;
				RDY <= '1';
			when ST2 => 
				M <= mode;
				RDY <= '1';
			when ST3 => 
				RW <= '1';
				M <= mode;
				RDY <= '1';
			when ST4 => 
				RW <= '1';
				M <= mode;
				RDY <= '1';
			when others =>
				M <= '0';
				RDY <= '0';
			end case;
	end process;
end Behavioral;

