----------------------------------------------------------------------------------
-- MIT License
--	Copyright (c) 2019
-- Engineers: Andry J. Hernandez Rodriguez
-- 
-- Create Date:    21:11:33 05/08/2019 
-- Design Name: 	 8254_Timer
-- Module Name:    CW_REGISTER 
-- Project Name:   FPGA_8254_Timer
-- Target Devices: Spaartan3E-XC3S1600E
-- Tool versions:  Xilinx ISE 14.7
-- Description: 	 REceive a control word and ouputs the signals for config. and select a chanel
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CW_REGISTER is
    Port ( D : in  STD_LOGIC_VECTOR (2 downto 0);
           A : in  STD_LOGIC_VECTOR (2 downto 0);
           WR : in  STD_LOGIC;
           RD : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WCTRL : out  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (6 downto 0));
end CW_REGISTER;

architecture Behavioral of CW_REGISTER is

signal data_c, data_n: std_logic_vector (2 downto 0);
signal wctrl_c, wctrl_n: std_logic;

begin

	process(CLK)
	begin
		if rising_edge(CLK) then
			if RST = '1' then
				data_c <= (others=>'0');
				wctrl_c <= '0';
			else
				wctrl_c <= wctrl_n;
				data_c <= data_n;
			end if;
		end if;
	end process;
	
	process(WR, RD, data_c, D, A, wctrl_c)
	begin			
		wctrl_n <= '0';
		if A = "111" and WR = '0' then
			data_n <= D;
			wctrl_n <= '1';
		elsif WR = '0' or RD = '0' then
			data_n <= A;
		else
			data_n <= data_c;
		end if;
	end process;

	process(data_c)
	begin
		case data_c is
			when "000" => Y <= "0000001";
			when "001" => Y <= "0000010";
			when "010" => Y <= "0000100";
			when "011" => Y <= "0001000";
			when "100" => Y <= "0010000";
			when "101" => Y <= "0100000";
			when "110" => Y <= "1000000";
			when others => Y <= "0000001";
		end case;
	end process;
	
		WCTRL <= wctrl_c;
	
end Behavioral;

