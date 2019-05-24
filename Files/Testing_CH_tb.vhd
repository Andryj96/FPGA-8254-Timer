--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:11:26 05/21/2019
-- Design Name:   
-- Module Name:   C:/Users/Andry/Desktop/FPGA/FPGA_8254_Timer/Files/Testing_CH_tb.vhd
-- Project Name:  FPGA_8254_Timer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Testing_CH
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
 
ENTITY Testing_CH_tb IS
END Testing_CH_tb;
 
ARCHITECTURE behavior OF Testing_CH_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Testing_CH
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         start_btn : IN  std_logic;
         gate0_btn : in  std_logic;
         datao : out  std_logic_vector(7 downto 0);
         sout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '1';
   signal clk : std_logic := '0';
   signal start_btn : std_logic := '0';
   signal gate0_btn : std_logic := '0';

 	--Outputs
   signal sout : std_logic;
   signal datao :   std_logic_vector(7 downto 0);
 -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Testing_CH PORT MAP (
          rst => rst,
          clk => clk,
          start_btn => start_btn,
          gate0_btn => gate0_btn,
          sout => sout,
          datao => datao
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 50 ns;	
		rst <= '0';

      wait for clk_period*2;

		start_btn <= '1';
      wait for 100 ns;
		start_btn <= '0';
		
      wait for clk_period*60;
		gate0_btn <= '0';
      wait for 1000 ns;
		gate0_btn <= '1';
     
      wait;
   end process;

END;
