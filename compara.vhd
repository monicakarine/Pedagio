library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity compara is
port(
	
     Peso : in std_logic_vector (15 downto 0);
     saida1, saida2, saida3:  out std_logic
);
end compara;

architecture comportamental of compara is

begin
	saida1 <= '1' when Peso < std_logic_vector(to_unsigned(900,16)) else '0';
	saida3 <= '1' when (Peso > std_logic_vector(to_unsigned(900,16)) or Peso = std_logic_vector(to_unsigned(900,16))) and (Peso<std_logic_vector(to_unsigned(20000,16)))
	else '0'; 
	saida2 <= '1' when (Peso > std_logic_vector(to_unsigned(20000,16)) or Peso = std_logic_vector(to_unsigned(20000,16))) else '0';
	
end comportamental;

