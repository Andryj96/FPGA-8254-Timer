----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez & Dariel Suarez Gonzalez
-- 
-- Create Date:    22:33:33 05/06/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    R/W_Sync
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Sync RD and WR signals with FPGA Clock
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RW_CONTROL_SYNC is
	
    Port (
		RD,WR,CS,CLK,RST : IN STD_LOGIC;
		WRITES : OUT STD_LOGIC;
		READS : OUT  STD_LOGIC);
		   
end RW_CONTROL_SYNC ;


architecture arch_RW_CONTROL_SYNC  of  RW_CONTROL_SYNC  is

	COMPONENT falling_edge_detector
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		cs : IN std_logic;
		start : IN std_logic;          
		pulse : OUT std_logic
		);
	END COMPONENT;
	
begin
	
		Inst_falling_edge_detector_WR: falling_edge_detector PORT MAP(
		clk => CLK,
		rst => RST,
		cs => CS,
		start => WR,
		pulse => WRITES
	);
		Inst_falling_edge_detector_RD: falling_edge_detector PORT MAP(
		clk => CLK,
		rst => RST,
		cs => CS,
		start => RD,
		pulse => READS
	);
 
end arch_RW_CONTROL_SYNC;


