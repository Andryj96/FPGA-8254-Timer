----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    17:58:33 05/05/2019 
-- Design Name: 	 CH_Selector
-- Module Name:    CH_Selector - Behavioral 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Mux with Decoder for Chanel Selector
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CH_Selector is
    Port ( CLK : in  STD_LOGIC;
			  RST : in  STD_LOGIC;
			  A : in  STD_LOGIC_VECTOR (2 downto 0);
           B : in  STD_LOGIC_VECTOR (2 downto 0);
           SEL : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (7 downto 0));
end CH_Selector;

architecture Behavioral of CH_Selector is

SIGNAL value: STD_LOGIC_VECTOR (2 downto 0);
begin

process(SEL)
begin
 	if SEL = '0' then
		value <= A;
	else 
		value <= B;
	end if;
end process;

process(CLK)
begin
   if rising_edge(CLK) then
      if RST = '0' then
         Y <= "11111111";
      else
         case value is
            when "000" => Y <= "11111110";
            when "001" => Y <= "11111101";
            when "010" => Y <= "11111011";
            when "011" => Y <= "11110111";
            when "100" => Y <= "11101111";
            when "101" => Y <= "11011111";
            when "110" => Y <= "10111111";
            when "111" => Y <= "01111111";
            when others => Y <= "11111111";
         end case;
      end if;
   end if;
end process;
 

end Behavioral;

