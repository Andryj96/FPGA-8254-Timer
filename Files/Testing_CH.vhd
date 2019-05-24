----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez & Dariel Suarez Gonzalez
-- 
-- Create Date:    23:58:33 05/20/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    CHANNEL - Test Bench 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 CHANNEL - Test Bench
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Testing_CH is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           read_btn : in  STD_LOGIC;
           start0_btn : in  STD_LOGIC;
           gate0_btn : in  STD_LOGIC;
           start1_btn : in  STD_LOGIC;
           gate1_btn : in  STD_LOGIC;			  
           selector_btn : in  STD_LOGIC;			  
           sout0 : out  STD_LOGIC;
           sout1 : out  STD_LOGIC;
			  datao : out  std_logic_vector(7 downto 0)
           );
end Testing_CH;

architecture Behavioral of Testing_CH is

	COMPONENT btn_debounce
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		btn : IN std_logic;          
		btn_deb : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT CTRL_8254
	Generic(
		cw: std_logic_vector(7 downto 0);
		dir: std_logic_vector(2 downto 0);
		lsb: std_logic_vector(7 downto 0);
		msb: std_logic_vector(7 downto 0)
	);
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		start : IN std_logic;          
		WR : OUT std_logic;
		do : OUT std_logic_vector(7 downto 0);
		addr : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Top_8254
	PORT(
		Din : IN std_logic_vector(7 downto 0);
		ADDR : IN std_logic_vector(2 downto 0);
		RD : IN std_logic;
		WR : IN std_logic;
		CS : IN std_logic;
		CLK : IN std_logic;
		RST : IN std_logic;
		CLK_CH : IN std_logic_vector(6 downto 0);
		GATE_CH : IN std_logic_vector(6 downto 0);          
		Do : OUT std_logic_vector(7 downto 0);
		OUT_CH : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
	COMPONENT rising_edge_detector
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		level : IN std_logic;          
		pulse : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT divisor
	Generic(DIVIDER: integer);
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;          
		clk_o : OUT std_logic
		);
	END COMPONENT;
	
	constant RD : std_logic := '1';
	constant CS : std_logic := '0';
	
	signal  selector, WR, WR0, WR1, start0p, start1p, start_0, start_1, clk_0, clk_1, gate_0, gate_1, gate1p : std_logic;
	signal addr, addr0, addr1: std_logic_vector(2 downto 0);
	signal din, din0, din1: std_logic_vector(7 downto 0);
	signal souts, clkses, gates :  STD_LOGIC_VECTOR (6 downto 0);
begin

	Inst_divisor_CH0: divisor 
	Generic map (
		DIVIDER => 1000 --50k
	)
	PORT MAP(
		clk => clk,
		rst => rst,
		clk_o => clk_0
	);
	
	Inst_divisor_CH1: divisor 
	Generic map (
		DIVIDER => 10000 --5k
	)
	PORT MAP(
		clk => clk,
		rst => rst,
		clk_o => clk_1
	);
	

	Inst_CTRL_8254_CH0: CTRL_8254 
	Generic map (
		cw => "00000001",  --Modo 1
		dir => "000",
		lsb => "01010000", --50 000
		msb => "11000011"
	)
	PORT MAP(
		rst => rst,
		clk => clk,
		start => start_0,
		WR => WR0,
		do => din0,
		addr => addr0
	);
	
	Inst_CTRL_8254_CH1: CTRL_8254 
	Generic map (
		cw => "00000100",
		dir => "001",
		lsb => "01010000", -- 50 000
		msb => "11000011"
	)
	PORT MAP(
		rst => rst,
		clk => clk,
		start => start_1,
		WR => WR1,
		do => din1,
		addr => addr1
	);
	
	WR <= WR0 and WR1;
	din <= din0 when selector = '0' else din1;
	addr <= addr0 when selector = '0' else addr1;
	
	Inst_Top_8254: Top_8254 PORT MAP(
		Din => din,
		Do => datao,
		ADDR => addr,
		RD => RD,
		WR => WR,
		CS => CS,
		CLK => clk,
		RST => rst,
		CLK_CH => clkses,
		GATE_CH => gates,
		OUT_CH => souts
	);
	
	clkses <= "00000" & clk_1 & clk_0;
	gates <= "00000" & gate_1 & gate_0;


	Inst_btn_debounce_start0: btn_debounce PORT MAP(
		clk => clk,
		rst => rst,
		btn => start0_btn,
		btn_deb => start0p
	);
	
	Inst_rising_edge_detector_start0: rising_edge_detector PORT MAP(
		clk => clk,
		rst => rst,
		level => start0p,
		pulse => start_0
	);
	
		Inst_btn_debounce_start1: btn_debounce PORT MAP(
		clk => clk,
		rst => rst,
		btn => start1_btn,
		btn_deb => start1p
	);
	
	Inst_rising_edge_detector_start1: rising_edge_detector PORT MAP(
		clk => clk,
		rst => rst,
		level => start1p,
		pulse => start_1
	);
	
	Inst_btn_debounce_gate0: btn_debounce PORT MAP(
		clk => clk,
		rst => rst,
		btn => gate0_btn,
		btn_deb => gate_0
	);

	Inst_btn_debounce_gate1: btn_debounce PORT MAP(
		clk => clk,
		rst => rst,
		btn => gate1_btn,
		btn_deb => gate_1
	);

	Inst_btn_debounce_selector: btn_debounce PORT MAP(
		clk => clk,
		rst => rst,
		btn => selector_btn,
		btn_deb => selector
	);
	
--	Inst_btn_debounce_RD: btn_debounce PORT MAP(
--		clk => clk,
--		rst => rst,
--		btn => read_btn,
--		btn_deb => RD
--	);
	sout0 <= souts(0);
	sout1 <= souts(1);

	
end Behavioral;

