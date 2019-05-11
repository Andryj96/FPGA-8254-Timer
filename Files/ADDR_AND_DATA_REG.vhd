----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez 
-- 
-- Create Date:    22:33:33 05/06/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    ADDR_DATA_REG 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 Save data bus and address bus when WR
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADDR_DATA_REG is
	
	Generic( lenght_data : integer := 8;
				lenght_addr : integer := 3);
    Port (  
		  CLK,CS,RST,RD,WR : IN STD_LOGIC;
		  A:IN STD_LOGIC_VECTOR (lenght_addr-1 DOWNTO 0);
		  DIN:IN STD_LOGIC_VECTOR (lenght_data-1 DOWNTO 0);
		  AP:OUT STD_LOGIC_VECTOR (lenght_addr-1 DOWNTO 0);
		  DI:OUT STD_LOGIC_VECTOR (lenght_data-1 DOWNTO 0));

end ADDR_DATA_REG;

architecture ARCH_ADDR_DATA_REG  of  ADDR_DATA_REG  is

	COMPONENT GEN_REGISTER
	Generic (lenght: integer);
	PORT(
		D : IN std_logic_vector(lenght-1 downto 0);
		RST : IN std_logic;
		CE : IN std_logic;
		CLK : IN std_logic;
		EN : IN std_logic;          
		Q : OUT std_logic_vector(lenght-1 downto 0)
		);
	END COMPONENT;
	
	signal en_addr, en_data : std_logic;
	
begin

	Inst_REGISTER_DATA: GEN_REGISTER 
	generic map ( 
		lenght => lenght_data)
	PORT MAP(
		D => DIN,
		RST => RST,
		CE => CS,
		CLK => CLK,
		EN => en_data,
		Q => DI
	);
	
	Inst_REGISTER_ADDR: GEN_REGISTER 
	generic map ( 
		lenght => lenght_addr)
	PORT MAP(
		D => A,
		RST => RST,
		CE => CS,
		CLK => CLK,
		EN => en_addr,
		Q => AP
	);

	process(RD,WR)
	begin
		if WR = '0' then
			en_addr <= '1';
			en_data <= '1';
		elsif RD = '0' then
			en_addr <= '1';
			en_data <= '0';
		else
			en_addr <= '0';
			en_data <= '0';
		end if;
	end process;

end ARCH_ADDR_DATA_REG;


