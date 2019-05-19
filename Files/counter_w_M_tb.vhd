--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:44:59 05/16/2019
-- Design Name:   
-- Module Name:   C:/Users/Andry/Desktop/FPGA/Test/test/counter_w_M_tb.vhd
-- Project Name:  test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: COUNTER_16b_W_Modes
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY counter_w_M_tb IS
END counter_w_M_tb;
 
ARCHITECTURE behavior OF counter_w_M_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal CLK : std_logic := '0';
   signal EN : std_logic := '0';
   signal RST : std_logic := '1';
   signal LOAD : std_logic := '1';
   signal MODE : std_logic := '0';
   signal D : std_logic_vector(15 downto 0) := "0000000011111111";

 	--Outputs
   signal TOUT: std_logic;
   signal Q : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: COUNTER_16b_W_Modes PORT MAP (
          CLK => CLK,
          EN => EN,
          RST => RST,
          LOAD => LOAD,
          MODE => MODE,
          D => D,
          TOUT => TOUT,
          Q => Q
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for CLK_period;	
		RST <= '0';
		wait for CLK_period*3;
		MODE <= '0';
		D <= "0000000000000111";
		wait for CLK_period;
		EN <= '1';
		wait for CLK_period*3;
		EN <= '0';

		wait for CLK_period*10;
--		EN <= '1';
--		wait for CLK_period*3;
--		EN <= '0';
      wait;
   end process;

END;
