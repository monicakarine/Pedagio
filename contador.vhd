library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
entity contador is
port(
	Clock,Reset,load: in std_logic; 
	Q : out integer range 0 to 10;
	fim : out std_logic
);
end entity;
architecture bhv of contador is
signal tempo : integer range 0 to 10;
begin
process (Clock,Reset) is
begin
	if (Reset = '1') then
		tempo <= 0; 
		fim <= '0'; 
	elsif (Clock'event and Clock = '1') then
		if (load = '1') then
			tempo <= tempo+1; 
			Q <= tempo;
		else
		tempo <= 0; 
		end if;
		if (tempo>5) then 
			fim <= '1'; 
			tempo <= 0;  
		end if; 
	end if; 
Q <= tempo;	
end process; 
end bhv; 


