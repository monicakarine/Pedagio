library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplicacao is
port
(
	multiplicador, taxa: in std_logic_vector(3 downto 0);
	valor : out std_logic_vector (15 downto 0)
);

end entity;

architecture rtl of multiplicacao is
signal resultado : std_logic_vector (7 downto 0);
begin
resultado <= std_logic_vector(unsigned(multiplicador)* unsigned(taxa));
valor <= std_logic_vector(resize(unsigned(resultado), valor'length));
end rtl;

