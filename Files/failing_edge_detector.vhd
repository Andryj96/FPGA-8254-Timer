----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernández Rodríguez & Dariel Suárez González 
-- 
-- Create Date:    23:51:33 06/05/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    Failing Edge Detector
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Timer 8254 - 7 chanels with modes 1 and 3
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity failing_edge_detector is
    Port ( 	clk : in  STD_LOGIC;
				cs : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            start : in  STD_LOGIC;
				pulse : out  STD_LOGIC);
end failing_edge_detector;

architecture Behavioral of failing_edge_detector is

		signal Q1, Q2 : std_logic;

begin

	process(clk, cs)
		begin
			if cs = '0' then
				if rising_edge(clk) then
					if (rst = '0') then
						Q1 <= '1';
						Q2 <= '1';
					else
						Q1 <= start;
						Q2 <= Q1;
					end if;
				end if;
			end if;
		end process;
		 
	process(Q1, Q2)
		begin
			pulse <= Q1 or (not Q2);	
		end process;		
		
end Behavioral;


