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

	COMPONENT CW_REG_CH
	PORT(
		CS : IN std_logic;
		EN : IN std_logic;
		CLK : IN std_logic;
		RST : IN std_logic;
		D : IN std_logic_vector(1 downto 0);          
		M : OUT std_logic;
		RW : OUT std_logic;
		RDY : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT TIMER_CONTROL
	PORT(
		CE : IN std_logic;
		WR : IN std_logic;
		RD : IN std_logic;
		RW : IN std_logic;
		CLK : IN std_logic;
		RST : IN std_logic;          
		LD0 : OUT std_logic;
		LD1 : OUT std_logic;
		LD2 : OUT std_logic;
		OE0 : OUT std_logic;
		OE1 : OUT std_logic;
		RD0 : OUT std_logic;
		RD1 : OUT std_logic
		);
	END COMPONENT;	
	
	COMPONENT IN_DATA_REG
	PORT(
		D : IN std_logic_vector(7 downto 0);
		RST : IN std_logic;
		EN : IN std_logic;
		CLK : IN std_logic;          
		Q : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
 
    COMPONENT COUNTER_16b_W_Modes
    PORT(
         CLK : IN  std_logic;
         EN : IN  std_logic;
         RST : IN  std_logic;
         LOAD : IN  std_logic;
         MODE : IN  std_logic;
         D : IN  std_logic_vector(15 downto 0);
         TOUT : OUT  std_logic;
         Q : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	COMPONENT OUT_DATA_REG_WHZ
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		EN : IN std_logic;
		CS : IN std_logic;
		D : IN std_logic_vector(7 downto 0);          
		Q : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	signal mode, ready, rw, ld0, ld1, ld2, oe0, oe1, rd0, rd1 : std_logic;
	signal in_lsb, in_msb, out_lsb, out_msb : std_logic_vector(7 downto 0);

begin

	Inst_CW_REG_CH: CW_REG_CH PORT MAP(
		CS => CS,
		EN => WCTRL,
		CLK => CLK,
		RST => RST,
		D => D(1 downto 0),
		M => mode,
		RW => rw,
		RDY => ready
	);
	
	Inst_TIMER_CONTROL: TIMER_CONTROL PORT MAP(
		WR => WR,
		RD => RD,
		RW => rw,
		CE => ready,
		CLK => CLK,
		RST => RST,
		LD0 => ld0,
		LD1 => ld1,
		LD2 => ld2,
		OE0 => oe0,
		OE1 => oe1,
		RD0 => rd0,
		RD1 => rd1 
	);	
	
	Inst_LSB_IN_REG: IN_DATA_REG PORT MAP(
		D => D,
		Q => in_lsb,
		RST => RST,
		EN => ld0,
		CLK => CLK
	);	
	
	Inst_MSB_IN_REG: IN_DATA_REG PORT MAP(
		D => D,
		Q => in_msb,
		RST => RST,
		EN => ld1,
		CLK => CLK
	);

	Inst_COUNTER_16b_W_Modes: COUNTER_16b_W_Modes PORT MAP(
		CLK => CLKA,
		EN => GATE,
		RST => RST,
		LOAD => ld2,
		MODE => mode,
		D(7 downto 0) => in_lsb,
		D(15 downto 8) => in_msb,
		TOUT => TOUT,
		Q(7 downto 0) => out_lsb,
		Q(15 downto 8) => out_msb
	);
	
	Inst_LSB_OUT_WHZ: OUT_DATA_REG_WHZ PORT MAP(
		CLK => CLK,
		RST => RST,
		EN => rd0,
		CS => oe0,
		D => out_lsb,
		Q => DO
	);
	
	Inst_MSB_OUT_WHZ: OUT_DATA_REG_WHZ PORT MAP(
		CLK => CLK,
		RST => RST,
		EN => rd1,
		CS => oe1,
		D => out_msb,
		Q => DO
	);
	
end Behavioral;

