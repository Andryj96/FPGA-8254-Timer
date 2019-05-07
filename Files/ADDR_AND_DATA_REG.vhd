library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

entity ADDR_DATA_REG is
	
    Port (  
           
		  WR,CS,RST : IN STD_LOGIC;
		  A:IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		  DIN:IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		  AP:OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		  DI:OUT STD_LOGIC_VECTOR (7 DOWNTO 0));

end ADDR_DATA_REG ;


architecture ARCH_ADDR_DATA_REG  of  Count  is
signal EP, ES: std_logic_vector (7 downto 0);
signal EPA, ESA: std_logic_vector (2 downto 0);

begin

-- memoria de estados --
process (WR, reset)
begin

 if (reset='0') then 
    EP <= (others =>'0');
	EPA <= (others =>'0');
 elsif (WR'event and WR ='1') then
    EP <= ES;
	EPA <= ESA;
 
 end if ;
end process;


-- CLC próximo estado 
ES <=   EP when CS = '0' else
        ES;
ESA <=   EPA when CS = '0' else
        ESA;

-- CLC de salida
 DI <= EP;   
 AP <= EPA;

end ARCH_ADDR_DATA_REG;


