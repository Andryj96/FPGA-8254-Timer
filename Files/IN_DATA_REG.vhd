----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez & Dariel Suarez Gonzalez
-- 
-- Create Date:    18:31:11 05/11/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    IN_DATA_REG
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Holds the input count value for counter's reload  
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IN_DATA_REG is
    Port ( D : in  STD_LOGIC_VECTOR (7 downto 0);
           Q : out  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC);
end IN_DATA_REG;

architecture Behavioral of IN_DATA_REG is

	COMPONENT GEN_REGISTER
	PORT(
		D : IN std_logic_vector(7 downto 0);
		RST : IN std_logic;
		CLK : IN std_logic;
		EN : IN std_logic;          
		Q : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
begin

	Inst_GEN_REGISTER: GEN_REGISTER PORT MAP(
		D => D,
		RST => RST,
		CLK => CLK,
		EN => EN,
		Q => Q
	);

end Behavioral;

