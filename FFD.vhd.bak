LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity FFD is
port( D: in std_logic;
rst: in std_logic;
clock: in std_logic;
Q: out std_logic
);
end FFD;
architecture FFpD of FFD is
begin
process(clock,rst)
begin
	if (rst = '1') then
		Q <= '0';
	elsif (rising_edge(clock)) then
		Q <= D;
	end if;
end process;
end FFpD;