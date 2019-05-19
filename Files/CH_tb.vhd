----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    17:58:33 05/05/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    CHANNEL - Test Bench 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 CHANNEL - Test Bench
--

----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CH_tb IS
END CH_tb;
 
ARCHITECTURE behavior OF CH_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CH_test_blocks
    PORT(
         D : IN  std_logic_vector(7 downto 0);
         A : IN  std_logic_vector(2 downto 0);
         RD : IN  std_logic;
         WR : IN  std_logic;
         WCTRL : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         CS : IN  std_logic;
         GATE : IN  std_logic;
         CLKA : IN  std_logic;
         RW,M,RDY : OUT  std_logic;
         LD0 : OUT  std_logic;
         LD1 : OUT  std_logic;
         LD2 : OUT  std_logic;
         OE0 : OUT  std_logic;
         OE1 : OUT  std_logic;
         RD0 : OUT  std_logic;
         RD1 : OUT  std_logic;
         TOUT : OUT  std_logic;
         Q : OUT  std_logic_vector(7 downto 0);
         Qsal : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(7 downto 0) := (others => '0');
   signal A : std_logic_vector(2 downto 0) := (others => '0');
   signal RD : std_logic := '1';
   signal WR : std_logic := '1';
   signal WCTRL : std_logic := '0';
   signal RST : std_logic := '1';
   signal CLK : std_logic := '0';
   signal CS : std_logic := '0';
   signal GATE : std_logic := '0';
   signal CLKA : std_logic := '0';

 	--Outputs
   signal RW : std_logic;
   signal M : std_logic;
   signal RDY : std_logic;
   signal LD0 : std_logic;
   signal LD1 : std_logic;
   signal LD2 : std_logic;
   signal OE0 : std_logic;
   signal OE1 : std_logic;
   signal RD0 : std_logic;
   signal RD1 : std_logic;
   signal TOUT : std_logic;
   signal Q : std_logic_vector(7 downto 0);
   signal Qsal : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
   constant CLKA_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CH_test_blocks PORT MAP (
          A => A,
          D => D,
          RD => RD,
          WR => WR,
          WCTRL => WCTRL,
          RST => RST,
          CLK => CLK,
          CS => CS,
          GATE => GATE,
          CLKA => CLKA,
          RW => RW,
          M => M,
          RDY => RDY,
          LD0 => LD0,
          LD1 => LD1,
          LD2 => LD2,
          OE0 => OE0,
          OE1 => OE1,
          RD0 => RD0,
          RD1 => RD1,
          TOUT => TOUT,
          Q => Q,
          Qsal => Qsal
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   CLKA_process :process
   begin
		CLKA <= '0';
		wait for CLKA_period/2;
		CLKA <= '1';
		wait for CLKA_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
      wait for 50 ns;	
		RST <= '0';
		wait for CLK_period;
		D <= "00000001";
		wait for CLK_period;
		WCTRL <= '1';
		CS <= '1';
		wait for CLK_period*3;
		WCTRL <= '0';
		wait for CLK_period*3;
		CS <= '0';
		D <= "00001111";
		
		wait for 20 ns;
		
		wait for CLK_period;
		WR <= '0';
		CS <= '1';
		wait for CLK_period*2;
		WR <= '1';
		wait for CLK_period*3;
		CS <= '0';
		
		wait for CLK_period*3;
		
		D <= "00000000";
		
		wait for 20 ns;
		WR <= '0';
		CS <= '1';
		wait for CLK_period*2;
		WR <= '1';
		wait for CLK_period*3;
		CS <= '0';
		
		GATE <= '1';
		wait for CLK_period*2;
--		GATE <= '0';
		wait for CLK_period*7;
		
		
		wait for 50 ns;
		RD <= '0';
		wait for CLK_period;
		CS <= '1';
		wait for CLK_period;
		RD <= '1';
		wait for CLK_period*3;
		CS <= '0';
			
		wait for CLK_period*7;
		
		
		wait for 50 ns;
		RD <= '0';
		wait for CLK_period;
		CS <= '1';
		wait for CLK_period;
		RD <= '1';
		wait for CLK_period*3;
		CS <= '0';
			
		

		wait for CLK_period*2;
--		GATE <= '0';
		
		
		D <= "00000010";
		A <= "111";
		WCTRL <= '1';
		CS <= '1';
		wait for CLK_period*2;
		WCTRL <= '0';
		wait for CLK_period*3;
		CS <= '0';

		
		wait for CLK_period*10;
		A <= "000";
		wait for CLK_period;
		CS <= '1';
		wait for CLK_period;
		RD <= '1';
		wait for CLK_period*3;
		CS <= '0';
			
		wait for CLK_period*7;
		
		
		wait for 50 ns;
		RD <= '0';
		wait for CLK_period;
		CS <= '1';
		wait for CLK_period;
		RD <= '1';
		wait for CLK_period*3;
		CS <= '0';
		wait for CLK_period*7;
		
		
		wait for 50 ns;
		RD <= '0';
		wait for CLK_period;
		CS <= '1';
		wait for CLK_period;
		RD <= '1';
		wait for CLK_period*3;
		CS <= '0';

      wait;
   end process;

END;
