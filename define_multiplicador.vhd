library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity define_multiplicador is
port(
	
     Ld_Multiplicador_1, Ld_Multiplicador_Eixos, Ld_Multiplicador_f: in std_logic; 
	  Eixos : in std_logic_vector(3 downto 0);
	  resultado_divisao : in std_logic_vector (15 downto 0);
     Multiplicador : out std_logic_vector (3 downto 0)
);
end define_multiplicador;
architecture arch of define_multiplicador is
begin
mult : process (Ld_Multiplicador_1,Ld_Multiplicador_Eixos,Ld_Multiplicador_f)
begin
if (Ld_Multiplicador_1 = '1') then --PESO MENOR QUE 900
Multiplicador <= x"1"; 
elsif (Ld_Multiplicador_Eixos = '1') then -- PESO MAIOR QUE 20000
Multiplicador <= Eixos; 
elsif (Ld_Multiplicador_f = '1') then 
					if ((resultado_divisao > std_logic_vector(to_unsigned(450,16)) or resultado_divisao = std_logic_vector(to_unsigned(450,16))) 
					and (resultado_divisao < std_logic_vector(to_unsigned(1000,16)))) then
					Multiplicador<= x"1";				
					elsif((resultado_divisao > std_logic_vector(to_unsigned(1000,16)) or resultado_divisao = std_logic_vector(to_unsigned(1000,16)))
					and (resultado_divisao < std_logic_vector(to_unsigned(2500,16)))) then 
					Multiplicador <= x"2";				
					elsif ((resultado_divisao > std_logic_vector(to_unsigned(2500,16)) or resultado_divisao = std_logic_vector(to_unsigned(2500,16))))
					then
					Multiplicador<= x"3";
					end if;
end if; 
end process; 
end arch;

