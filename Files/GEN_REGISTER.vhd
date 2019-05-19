----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    11:44:11 05/06/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    Generic Register
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Generic Register with CE, load and sync Reset 
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GEN_REGISTER is
	Generic (lenght: integer := 8 );
    Port ( D : in  STD_LOGIC_VECTOR (lenght-1 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (lenght-1 downto 0));
end GEN_REGISTER;

architecture Behavioral of GEN_REGISTER is

signal curr_val, next_val : STD_LOGIC_VECTOR (lenght-1 downto 0);
begin

	process(CLK)
	begin
		if rising_edge(CLK) then
			if RST = '1' then
				curr_val <= (others => '0');
			else
				curr_val <= next_val;
			end if;
		end if;
	end process;
	
	process(EN, curr_val, D)
	begin
		if EN = '1' then 
			next_val <= D;
		else
			next_val <= curr_val;
		end if;
		Q <= curr_val;
	end process;

end Behavioral;

