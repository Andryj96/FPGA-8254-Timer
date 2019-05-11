----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    21:11:33 05/08/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    CW_REGISTER 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 REceive a control word and ouputs the signals for config. a chanel
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CW_REGISTER is
    Port ( D : in  STD_LOGIC_VECTOR (7 downto 0);
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WCTRL : out  STD_LOGIC;
           A : out  STD_LOGIC_VECTOR (2 downto 0));
end CW_REGISTER;

architecture Behavioral of CW_REGISTER is

signal data_c, data_n: std_logic_vector (7 downto 0);

begin

	process(CLK)
	begin
		if rising_edge(CLK) then
			if RST = '0' then
				data_c <= (others=>'0');
			else
				data_c <= data_n;
			end if;
		end if;
	end process;
	
	process(EN, data_c, D)
	begin
		if EN = '0' then
			data_n <= D;
			WCTRL <= '1';
		else
			WCTRL <= '0';
			data_n <= data_c;
		end if;
	end process;
		
		A <= data_c(2) & data_c(3) & data_c(4);
	
end Behavioral;

