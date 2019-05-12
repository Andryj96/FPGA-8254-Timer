----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez 
-- 
-- Create Date:    18:56:23 05/11/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    CHANNEL 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Channel Block for 8254
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CHANNEL is
    Port ( D : in  STD_LOGIC_VECTOR (7 downto 0);
           RD : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           WCTRL : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           GATE : in  STD_LOGIC;
           CLKA : in  STD_LOGIC;
           TOUT : out  STD_LOGIC;
           DO : out  STD_LOGIC_VECTOR (7 downto 0));
end CHANNEL;

architecture Behavioral of CHANNEL is

begin


end Behavioral;

