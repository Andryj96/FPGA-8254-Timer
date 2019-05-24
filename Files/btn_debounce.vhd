----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:45:07 02/15/2016 
-- Design Name: 
-- Module Name:    btn_debounce - Behavioral 
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

entity btn_debounce is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           btn : in  STD_LOGIC;
           btn_deb : out  STD_LOGIC);
end btn_debounce;

architecture Behavioral of btn_debounce is

type debounce_fsm_states is (ZERO, EDGE_P, ONE, EDGE_N);

signal debounce_fsm_curr_st : debounce_fsm_states; 
signal debounce_fsm_next_st : debounce_fsm_states;

signal tick : std_logic;
signal tick_en : std_logic;

constant DIVIDER : integer := 500000; 
signal cnt : integer range 0 to DIVIDER;

begin

debounce_state_transition_logic: process(clk, rst)
begin
	if rising_edge(clk) then
		if rst = '1' then
			debounce_fsm_curr_st <= ZERO;
		else
			debounce_fsm_curr_st <= debounce_fsm_next_st;
		end if;
	end if;
end process;

debounce_next_state_logic: process(debounce_fsm_curr_st, btn, tick)
begin
	debounce_fsm_next_st <= debounce_fsm_curr_st;
	case debounce_fsm_curr_st is
	
		when ZERO =>
			if btn = '1' then
				debounce_fsm_next_st <= EDGE_P;
			end if;
		
		when EDGE_P =>
			if tick = '1' then
				debounce_fsm_next_st <= ONE;
			end if;				
		
		when ONE =>
			if btn = '0' then
				debounce_fsm_next_st <= EDGE_N;
			end if;		
		
		when EDGE_N =>
			if tick = '1' then
				debounce_fsm_next_st <= ZERO;
			end if;			
		
	end case;
end process;

tick_en <= '1' when ((debounce_fsm_curr_st = EDGE_P) or (debounce_fsm_curr_st = EDGE_N)) else '0';

debounce_tick_logic: process(clk, rst)
begin
	if rising_edge(clk) then
		if rst = '1' then
			cnt <= 0;
			tick <= '0';
		else
			if tick_en = '1' then
				if cnt = DIVIDER then 
					cnt <= 0;
					tick <= '1';
				else
					cnt <= cnt + 1;
					tick <= '0';
				end if;
			end if;
		end if;
	end if;
end process;

debounce_output_logic: process(clk, rst)
begin
	if rising_edge(clk) then
		if rst = '1' then
			btn_deb <= '0';
		else
			if debounce_fsm_curr_st = EDGE_P then
				btn_deb <= '1';
			elsif debounce_fsm_curr_st = EDGE_N then 
				btn_deb <= '0';
			end if;
		end if;
	end if;
end process;


end Behavioral;

