----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hern�ndez Rodr�guez
-- 
-- Create Date:    21:11:33 05/08/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    COUNTER_16b_W_Modes 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Binary 16 bits down counter with two operations modeds
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COUNTER_16b_W_Modes is

	  PORT (
		 CLK : IN STD_LOGIC;
		 EN : IN STD_LOGIC;
		 RST : IN STD_LOGIC;
		 LOAD : IN STD_LOGIC;
		 MODE : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 RCO : OUT STD_LOGIC;
		 Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	  
end COUNTER_16b_W_Modes;

architecture Behavioral of COUNTER_16b_W_Modes is

	COMPONENT CUNTER_DOWN_B_16
	  PORT (
		 clk : IN STD_LOGIC;
		 ce : IN STD_LOGIC;
		 sclr : IN STD_LOGIC;
		 load : IN STD_LOGIC;
		 l : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 thresh0 : OUT STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
END COMPONENT;

begin
	
	Inst_CUNTER_DOWN_B_16 : CUNTER_DOWN_B_16
	  PORT MAP (
		 clk => CLK,
		 ce => EN,
		 sclr => RST,
		 load => LOAD,
		 thresh0 => RCO,
		 l => D,
		 q => Q
	  );

end Behavioral;

