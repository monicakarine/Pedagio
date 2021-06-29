library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity comparador_pagamento is
port(
	  flag_inicio : in std_logic; 
     Valor, Pagamento : in std_logic_vector (15 downto 0);
	  pagou: out std_logic
);
end entity;

architecture comportamental of comparador_pagamento is
begin
process (flag_inicio) is
begin 
if (flag_inicio = '1') then
	if (Pagamento>Valor or Pagamento = Valor) then
	pagou <= '1';
	else
	pagou <= '0'; 
	end if; 
end if; 
end process;
end comportamental;