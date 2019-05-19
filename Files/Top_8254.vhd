----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
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
		RD : IN std_logic;
		WR : IN std_logic;
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
	
	COMPONENT CW_REGISTER
	PORT(
		D : IN std_logic_vector(2 downto 0);
		A : IN std_logic_vector(2 downto 0);
		WR : IN std_logic;
		CLK : IN std_logic;
		RST : IN std_logic;          
		WCTRL : OUT std_logic;
		Y : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
	COMPONENT CHANNEL
	PORT(
		D : IN std_logic_vector(7 downto 0);
		A : IN std_logic_vector(2 downto 0);
		RD : IN std_logic;
		WR : IN std_logic;
		WCTRL : IN std_logic;
		RST : IN std_logic;
		CLK : IN std_logic;
		CS : IN std_logic;
		GATE : IN std_logic;
		CLKA : IN std_logic;          
		TOUT : OUT std_logic;
		DO : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	SIGNAL ADDRP : std_logic_vector(2 downto 0);
	SIGNAL WRITES, READS, WCW, enable : std_logic;
	SIGNAL DATAP, DATAO: std_logic_vector(7 downto 0);
	SIGNAL CHANNELS : std_logic_vector(6 downto 0);
	
begin

	Inst_ADDR_DATA_REG: ADDR_DATA_REG PORT MAP(
		CLK => CLK,
		CS => enable,
		RST => RST,
		RD => RD,
		WR => WR,
		A => ADDR,
		DIN => Din,
		AP => ADDRP,
		DI => DATAP

	);
	
	Inst_RW_CONTROL_SYNC: RW_CONTROL_SYNC PORT MAP(
		RD => RD,
		WR => WR,
		CS => enable,
		CLK => CLK,
		RST => RST,
		WRITES => WRITES,
		READS => READS
	);
	
	Inst_CW_REGISTER: CW_REGISTER PORT MAP(
		D => DATAP(4 downto 2),
		A => ADDRP,
		WR => WRITES,
		CLK => CLK,
		RST => RST,
		WCTRL => WCW,
		Y => CHANNELS
	);
	
	Inst_CHANNEL0: CHANNEL PORT MAP(
		D => DATAP,
		A => ADDRP,
		RD => READS,
		WR => WRITES,
		WCTRL => WCW,
		RST => RST,
		CLK => CLK,
		CS => CHANNELS(0),
		GATE => GATE_CH(0),
		CLKA => CLK_CH(0),
		TOUT => OUT_CH(0),
		DO => DATAO
	);
	
	Inst_CHANNEL1: CHANNEL PORT MAP(
		D => DATAP,
		A => ADDRP,		
		RD => READS,
		WR => WRITES,
		WCTRL => WCW,
		RST => RST,
		CLK => CLK,
		CS => CHANNELS(1),
		GATE => GATE_CH(1),
		CLKA => CLK_CH(1),
		TOUT => OUT_CH(1),
		DO => DATAO
	);
	
	Inst_CHANNEL2: CHANNEL PORT MAP(
		D => DATAP,
		A => ADDRP,		
		RD => READS,
		WR => WRITES,
		WCTRL => WCW,
		RST => RST,
		CLK => CLK,
		CS => CHANNELS(2),
		GATE => GATE_CH(2),
		CLKA => CLK_CH(2),
		TOUT => OUT_CH(2),
		DO => DATAO
	);
	
	Inst_CHANNEL3: CHANNEL PORT MAP(
		D => DATAP,
		A => ADDRP,		
		RD => READS,
		WR => WRITES,
		WCTRL => WCW,
		RST => RST,
		CLK => CLK,
		CS => CHANNELS(3),
		GATE => GATE_CH(3),
		CLKA => CLK_CH(3),
		TOUT => OUT_CH(3),
		DO => DATAO
	);
	
	Inst_CHANNEL4: CHANNEL PORT MAP(
		D => DATAP,
		A => ADDRP,		
		RD => READS,
		WR => WRITES,
		WCTRL => WCW,
		RST => RST,
		CLK => CLK,
		CS => CHANNELS(4),
		GATE => GATE_CH(4),
		CLKA => CLK_CH(4),
		TOUT => OUT_CH(4),
		DO => DATAO
	);
	
	Inst_CHANNEL5: CHANNEL PORT MAP(
		D => DATAP,
		A => ADDRP,		
		RD => READS,
		WR => WRITES,
		WCTRL => WCW,
		RST => RST,
		CLK => CLK,
		CS => CHANNELS(5),
		GATE => GATE_CH(5),
		CLKA => CLK_CH(5),
		TOUT => OUT_CH(5),
		DO => DATAO
	);
	
	Inst_CHANNEL6: CHANNEL PORT MAP(
		D => DATAP,
		A => ADDRP,		
		RD => READS,
		WR => WRITES,
		WCTRL => WCW,
		RST => RST,
		CLK => CLK,
		CS => CHANNELS(6),
		GATE => GATE_CH(6),
		CLKA => CLK_CH(6),
		TOUT => OUT_CH(6),
		DO => DATAO
	);
	
	enable <= not CS;
	
	process(DATAO)
	begin
		if DATAO = "ZZZZZZZZ" then
			Do <= (others => '1');
		else
			Do <= DATAO;
		end if;
	end process;
end Behavioral;

