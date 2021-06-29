library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisao is

	port
	(
	peso: in std_logic_vector(15 downto 0);
	eixos: in std_logic_vector(3 downto 0);
	valor : out std_logic_vector (15 downto 0)
	);

end entity;

architecture rtl of divisao is
signal resultado : std_logic_vector (15 downto 0);
begin
resultado <= std_logic_vector(unsigned(peso)/ unsigned(eixos));
valor <= std_logic_vector(resize(unsigned(resultado), valor'length));
end rtl;
