----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernández Rodríguez & Dariel Suárez González 
-- 
-- Create Date:    17:58:33 05/05/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    Top_8254 - Behavioral 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Timer 8254 - 7 chanels with modes 1 and 3
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Top_8254 is
    Port ( Din : in  STD_LOGIC_VECTOR (7 downto 0);
           Do : out  STD_LOGIC_VECTOR (7 downto 0);
           ADDR : in  STD_LOGIC_VECTOR (2 downto 0);
           RD : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK_CH : in  STD_LOGIC_VECTOR (6 downto 0);
           GATE_CH : in  STD_LOGIC_VECTOR (6 downto 0);
           OUT_CH : out  STD_LOGIC_VECTOR (6 downto 0));
end Top_8254;

architecture Behavioral of Top_8254 is

	COMPONENT ADDR_DATA_REG
	PORT(
		CLK : IN std_logic;
		CS : IN std_logic;
		RST : IN std_logic;
		A : IN std_logic_vector(2 downto 0);
		DIN : IN std_logic_vector(7 downto 0);          
		AP : OUT std_logic_vector(2 downto 0);
		DI : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RW_CONTROL_SYNC
	PORT(
		RD : IN std_logic;
		WR : IN std_logic;
		CS : IN std_logic;
		CLK : IN std_logic;
		RST : IN std_logic;          
		WRITES : OUT std_logic;
		READS : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT CH_Selector
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		A : IN std_logic_vector(2 downto 0);
		B : IN std_logic_vector(2 downto 0);
		SEL : IN std_logic;          
		Y : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	
	SIGNAL ADDRP,WADDR : std_logic_vector(2 downto 0);
	SIGNAL SELADDR, WRITES, READS : std_logic;
	SIGNAL CHANELS, DATAP: std_logic_vector(7 downto 0);
	
begin

	Inst_ADDR_DATA_REG: ADDR_DATA_REG PORT MAP(
		CLK => WR,
		CS => CS,
		RST => RST,
		A => ADDR,
		DIN => Din,
		AP => ADDRP,
		DI => DATAP
	);
	
	Inst_RW_CONTROL_SYNC: RW_CONTROL_SYNC PORT MAP(
		RD => RD,
		WR => WR,
		CS => CS,
		CLK => CLK,
		RST => RST,
		WRITES => WRITES,
		READS => READS
	);
	
	Inst_CH_Selector: CH_Selector PORT MAP(
		CLK => CLK,
		RST => RST,
		A => ADDRP,
		B => WADDR,
		SEL => SELADDR,
		Y => CHANELS
	);

end Behavioral;

