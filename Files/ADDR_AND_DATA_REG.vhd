----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernández Rodríguez & Dariel Suárez González 
-- 
-- Create Date:    22:33:33 06/05/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    ADDR_DATA_REG 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Timer 8254 - 7 chanels with modes 1 and 3
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADDR_DATA_REG is
	
    Port (  
           
		  WR,CS,RST : IN STD_LOGIC;
		  A:IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		  DIN:IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		  AP:OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		  DI:OUT STD_LOGIC_VECTOR (7 DOWNTO 0));

end ADDR_DATA_REG ;


architecture ARCH_ADDR_DATA_REG  of  ADDR_DATA_REG  is


begin

-- memoria de estados --
process (WR, CS)
begin
if CS = '0' then
	if (WR'event and WR ='1') then
		if RST = '0' then 
			DI <= (others =>'0');
			AP <= (others =>'0');
		else
			DI <= DIN;
			AP <= A;
		end if;
	end if;	
end if;	 
end process;

end ARCH_ADDR_DATA_REG;


