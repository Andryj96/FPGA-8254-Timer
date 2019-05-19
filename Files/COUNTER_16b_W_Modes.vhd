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
		 TOUT : OUT STD_LOGIC;
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

	COMPONENT COUNTER_M1_FSM
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		thresh0 : IN std_logic;
		gate : IN std_logic;
		CS : IN std_logic;          
		ce : OUT std_logic;
		TOUT : OUT std_logic;
		load : OUT std_logic
		);
	END COMPONENT;

	COMPONENT COUNTER_M3_FSM
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		thresh0 : IN std_logic;
		CS : IN std_logic;
		gate : IN std_logic;
		D : IN std_logic_vector(15 downto 0);
		Q : IN std_logic_vector(15 downto 0);          
		ce : OUT std_logic;
		load : OUT std_logic;
		TOUT : OUT std_logic
		);
	END COMPONENT;
	
	signal end_cnt, en_M1, en_M3, ce, ce1, ce3 : std_logic;
	signal lod, load1, load3, out_1, out_3: std_logic;
	signal qout : std_logic_vector(15 downto 0);
	
begin
	
	Inst_COUNTER_DOWN_B_16 : CUNTER_DOWN_B_16
	  PORT MAP (
		 clk => CLK,
		 ce => ce,
		 sclr => RST,
		 load => lod,
		 thresh0 => end_cnt,
		 l => D,
		 q => qout
	  );

	Inst_COUNTER_M1_FSM: COUNTER_M1_FSM PORT MAP(
		CLK => CLK,
		RST => RST,
		thresh0 => end_cnt,
		gate => EN,
		CS => en_M1,
		ce => ce1,
		TOUT => out_1,
		load => load1
	);
	
	Inst_COUNTER_M3_FSM: COUNTER_M3_FSM PORT MAP(
		CLK => CLK,
		RST => RST,
		thresh0 => end_cnt,
		CS => en_M3,
		gate => EN,
		ce => ce3,
		load => load3,
		TOUT => out_3,
		D => D,
		Q => qout
	);
	
	process(LOAD, MODE, load1, load3, ce1, ce3, out_1, out_3)
	begin
		if LOAD = '1' then	--TIMER Configured
			if MODE = '0' then
				lod <= load1;
				ce <= ce1;
				TOUT <= out_1;
				en_M1 <= '1';
				en_M3 <= '0';
			else
				lod <= load3;
				ce <= ce3;
				TOUT <= out_3;
				en_M1 <= '0';
				en_M3 <= '1';
			end if;
		else
				lod <= '0';
				ce <= '0';
				TOUT <= '0';
				en_M1 <= '0';
				en_M3 <= '0';
		end if;
	end process;
	
	Q <= qout;
	
end Behavioral;

