----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hern�ndez Rodr�guez
-- 
-- Create Date:    01:53:13 05/12/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    TIMER_CONTROL 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 State Machine for timer reload and ouput control
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TIMER_CONTROL is
    Port ( RDY : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           RD : in  STD_LOGIC;
           RW : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           LD0 : out  STD_LOGIC;
           LD1 : out  STD_LOGIC;
           LD2 : out  STD_LOGIC;
           OL0 : out  STD_LOGIC;
           OL1 : out  STD_LOGIC;
           RD0 : out  STD_LOGIC;
           RD1 : out  STD_LOGIC);
end TIMER_CONTROL;

architecture Behavioral of TIMER_CONTROL is

begin


end Behavioral;

