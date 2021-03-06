library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity subtrator is
port(
	  flag_pagamento : in std_logic ; 
     Valor, Pagamento : in std_logic_vector (15 downto 0);
     Troco:  out std_logic_vector (15 downto 0)
);
end entity;

architecture bhv of subtrator is
signal resultado : std_logic_vector (15 downto 0);
begin
process (flag_pagamento,Valor,resultado,Pagamento) is 
begin
if (flag_pagamento = '1') then
resultado <= std_logic_vector(unsigned(Pagamento)- unsigned(Valor));
Troco <= std_logic_vector(resize(unsigned(resultado), Troco'length));
end if; 
end process;
end bhv;