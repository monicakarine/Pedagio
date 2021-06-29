LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity FFD_botao is
port( 
	D: in std_logic;
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic
);
end FFD_botao;

architecture FFpD of FFD_botao is
begin
process(clock,rst)
begin
	if (rst = '1' or registra = '0') then
		Q <= '0';
	elsif (rising_edge(clock) and registra = '1') then
		Q <= D;
	end if;
end process;
end FFpD;