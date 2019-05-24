----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez & Dariel Suarez Gonzalez
-- 
-- Create Date:    19:17:11 05/11/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    OUT_DATA_REG_WHZ 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Counter's out register with High Impedance
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OUT_DATA_REG_WHZ is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (7 downto 0);
           Q : out  STD_LOGIC_VECTOR (7 downto 0));
end OUT_DATA_REG_WHZ;

architecture Behavioral of OUT_DATA_REG_WHZ is	

	COMPONENT GEN_REGISTER
	PORT(
		D : IN std_logic_vector(7 downto 0);
		RST : IN std_logic;
		CLK : IN std_logic;
		EN : IN std_logic;          
		Q : OUT std_logic_vector(7 downto 0)
		);
		
	END COMPONENT;
	
	signal qout : std_logic_vector(7 downto 0);
	
begin

	Inst_GEN_REGISTER: GEN_REGISTER PORT MAP(
		D => D,
		RST => RST,
		CLK => CLK,
		EN => EN,
		Q => qout
	);
	
	process(CS, qout)
	begin
		if CS = '0' then
			Q <= qout;
		else
			Q <= (others => 'Z');
		end if;
	end process;
			

end Behavioral;

