library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

entity R/W_CONTROL_SYNC is
	
    Port (  
           
		  RD,WR,CS,CLK,RST : IN STD_LOGIC;
		   WRITE : OUT STD_LOGIC;
           READ : OUT  STD_LOGIC);
		   
end R/W_CONTROL_SYNC ;


architecture arch_R/W_CONTROL_SYNC  of  R/W_CONTROL_SYNC  is
signal EPWR, EPWR,EPRD, ESRD : STD_LOGIC;

begin

-- memoria de estados --
process (CLK, RST)
begin

 if (RST='0') then 
    EPWR <= '1';
	EPRD <= '1';
 elsif (CLK'event and CLK ='1') then
    EPWR <= ESWR;
	EPRD <= ESRD;
 
 end if ;
end process;


-- CLC próximo estado 
ESWR <=  EPWR;
ESRD <=  EPRD;

-- CLC de salida
 WRITE <= EPWR; 
 READ  <= EPRD;
 
end arch;


