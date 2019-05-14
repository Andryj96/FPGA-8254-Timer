--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:55:01 05/13/2019
-- Design Name:   
-- Module Name:   C:/Users/Andry/Desktop/FPGA/FPGA_8254_Timer/Files/tesst.vhd
-- Project Name:  FPGA_8254_Timer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RD_DATA_FSM
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
 
ENTITY tesst IS
END tesst;
 
ARCHITECTURE behavior OF tesst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RD_DATA_FSM
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         RW : IN  std_logic;
	      CE : in  STD_LOGIC;
         RD : IN  std_logic;
         OE0 : OUT  std_logic;
         OE1 : OUT  std_logic;
         LD0 : OUT  std_logic;
         LD1 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal RW : std_logic := '0';
   signal RD : std_logic := '0';
   signal CE : std_logic := '0';

 	--Outputs
   signal OE0 : std_logic;
   signal OE1 : std_logic;
   signal LD0 : std_logic;
   signal LD1 : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RD_DATA_FSM PORT MAP (
          CLK => CLK,
          RST => RST,
			 CE => CE,
          RW => RW,
          RD => RD,
          OE0 => OE0,
          OE1 => OE1,
          LD0 => LD0,
          LD1 => LD1
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
		RD <= '1';
		RW <= '0';
		RST <= '0';
		wait for 10 ns;	
		RST <= '1';
		
		wait for CLK_period;
		
		RW <= '1';
		
		wait for CLK_period*3;
		RD <= '0';
		wait for CLK_period;
		RD <= '1';

		wait for CLK_period*3;
			
		RD <= '0';
		wait for CLK_period;
		RD <= '1';

		wait for CLK_period*3;
			
		RD <= '0';
		wait for CLK_period;
		RD <= '1';


      wait;
   end process;

END;
