----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:23:24 02/15/2016 
-- Design Name: 
-- Module Name:    refresh_div - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisor is
	 Generic(DIVIDER: integer := 1000);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk_o : out  STD_LOGIC);
end divisor;

architecture Behavioral of divisor is

signal cnt : integer range 0 to DIVIDER;

begin

divisor_counter_logic: process(clk, rst)
begin
	if rising_edge(clk) then
		if rst = '1' then
			cnt <= 0;
		else
			if cnt = DIVIDER then
				cnt <= 0;
			else
				cnt <= cnt + 1;
			end if;
		end if;
	end if;
end process;

clk_o <= '1' when cnt = DIVIDER else '0';

end Behavioral;

