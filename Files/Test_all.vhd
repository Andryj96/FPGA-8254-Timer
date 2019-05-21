----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    17:58:33 05/05/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    Top_8254 - Test Bench 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Timer 8254 - Test Bench
--

----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_all IS
END test_all;
 
ARCHITECTURE behavior OF test_all IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Top_8254
    PORT(
         Din : IN  std_logic_vector(7 downto 0);
         Do : OUT  std_logic_vector(7 downto 0);
         ADDR : IN  std_logic_vector(2 downto 0);
         RD : IN  std_logic;
         WR : IN  std_logic;
         CS : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         CLK_CH : IN  std_logic_vector(6 downto 0);
         GATE_CH : IN  std_logic_vector(6 downto 0);
         OUT_CH : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic_vector(7 downto 0) := (others => '0');
   signal ADDR : std_logic_vector(2 downto 0) := (others => '0');
   signal RD : std_logic := '1';
   signal WR : std_logic := '1';
   signal CS : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '1';
   signal CLK_CH : std_logic_vector(6 downto 0) := (others => '0');
   signal GATE_CH : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal Do : std_logic_vector(7 downto 0);
   signal OUT_CH : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
   constant CLK_CH0_period : time := 40 ns;
   constant CLK_CH1_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top_8254 PORT MAP (
          Din => Din,
          Do => Do,
          ADDR => ADDR,
          RD => RD,
          WR => WR,
          CS => CS,
          CLK => CLK,
          RST => RST,
          CLK_CH => CLK_CH,
          GATE_CH => GATE_CH,
          OUT_CH => OUT_CH
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   CLK_CH0_process :process
   begin
		CLK_CH(0) <= '0';
		wait for CLK_CH0_period/2;
		CLK_CH(0) <= '1';
		wait for CLK_CH0_period/2;
   end process;
	
    CLK_CH1_process :process
   begin
		CLK_CH(1) <= '0';
		wait for CLK_CH1_period/2;
		CLK_CH(1) <= '1';
		wait for CLK_CH1_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

      wait for 70 ns;	
		RST <= '0';
		wait for 20 ns;
		ADDR <= "111";
		Din <= "00000001";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
		
      wait for CLK_period*5;

		ADDR <= "000";
		Din <= "00001111";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
		
      wait for CLK_period*4;
		
		ADDR <= "000";
		Din <= "00000000";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
      wait for CLK_period*3;
		
		
		
		ADDR <= "111";
		Din <= "00000101";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
		
      wait for CLK_period*5;

		ADDR <= "001";
		Din <= "00001111";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
		
      wait for CLK_period*4;
		
		ADDR <= "001";
		Din <= "00000000";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
      wait for CLK_period*3;
		
		GATE_CH(1) <= '1';
		
      wait for CLK_period*10;
--		GATE_CH(1) <= '0';
		
--		Testing reload

		
		ADDR <= "000";
		Din <= "00000111";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
      wait for CLK_period*3;
		
		GATE_CH(0) <= '1';
		GATE_CH(1) <= '1';

      wait for CLK_period*20;

		ADDR <= "001";
		Din <= "00001111";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
      wait for CLK_period*30;
		
--		Latch Command		
		ADDR <= "111";
		Din <= "00000010";
		
		WR <= '0';
      wait for CLK_period*2;
		WR <= '1';
      wait for CLK_period*3;

		ADDR <= "011";
		RD <= '0';
      wait for CLK_period*2;
		RD <= '1';
      wait for CLK_period*6;

		ADDR <= "000";
		RD <= '0';
      wait for CLK_period*2;
		RD <= '1';
      wait for CLK_period*3;
		
		ADDR <= "000";
		RD <= '0';
      wait for CLK_period*2;
		RD <= '1';
      wait for CLK_period*3;

      wait;
   end process;

END;
