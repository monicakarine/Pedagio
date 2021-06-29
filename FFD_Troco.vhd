LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity FFD_Troco is
port( 
	D: in std_logic_vector (15 downto 0);
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic_vector (15 downto 0)
);
end FFD_Troco;

architecture FFpD of FFD_Troco is
begin
process(clock,rst)
begin
	if (rst = '1') then
		Q <= x"0000";
	elsif (rising_edge(clock) and registra = '1') then
		Q <= D;
	end if;
end process;
end FFpD;