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
    Port ( CE : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           RD : in  STD_LOGIC;
           RW : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           LD0 : out  STD_LOGIC;
           LD1 : out  STD_LOGIC;
           LD2 : out  STD_LOGIC;
           OE0 : out  STD_LOGIC;
           OE1 : out  STD_LOGIC;
           RD0 : out  STD_LOGIC;
           RD1 : out  STD_LOGIC);
end TIMER_CONTROL;

architecture Behavioral of TIMER_CONTROL is

	COMPONENT LD_DATA_FSM
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		WR : IN std_logic;
		CE : IN std_logic;          
		LD0 : OUT std_logic;
		LD1 : OUT std_logic;
		LD2 : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT RD_DATA_FSM
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		CE : IN std_logic;
		RW : IN std_logic;
		RD : IN std_logic;          
		OE0 : OUT std_logic;
		OE1 : OUT std_logic;
		LD0 : OUT std_logic;
		LD1 : OUT std_logic
		);
	END COMPONENT;
	
	signal en_RD : std_logic;
begin

	Inst_LD_DATA_FSM: LD_DATA_FSM PORT MAP(
		CLK => CLK,
		RST => RST,
		WR => WR,
		CE => CE,
		LD0 => LD0,
		LD1 => LD1,
		LD2 => en_RD
	);
	
	Inst_RD_DATA_FSM: RD_DATA_FSM PORT MAP(
		CLK => CLK,
		RST => RST,
		CE => en_RD,
		RW => RW,
		RD => RD,
		OE0 => OE0,
		OE1 => OE1,
		LD0 => RD0,
		LD1 => RD1
	);
	
	LD2 <= en_RD;
	
end Behavioral;

