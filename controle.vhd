library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_bit.rising_edge;
entity controladora is
port(
 RESET   : in    std_logic; -- reset input
 CLOCK   : in    std_logic; -- clock input
 Cliente, Botao_Ent: in std_logic;
 fim_contador, confirma_Pagamento : in std_logic; 
 peso_menor_900,peso_entre_900_e_20000,peso_maior_20000 : in std_logic;
 Ld_Contador,Ld_Pagamento,Ld_Multiplicador_1,Ld_Multiplicador_Eixos,Ld_Multiplicador_f,Ld_Valor,Ld_Troco, Ld_Botao_S : out std_logic
);
end entity;

architecture arch of controladora is
type estado is (Inicio,Espera,Leitura,Calcula_Valor_1, Calcula_Valor_2,Calcula_Valor_3,Espera_Pagamento,Calcula_Troco,Espera_Saida);
signal estado_atual,proximo_estado : estado; --estado atual recebe o tipo de estado 

begin
---------------------------------------- Máquina de estados finitos---------------------------------------------------------------------------------------------
sequencial: process(CLOCK, RESET)
	begin
			if (RESET = '1') then
				estado_atual <= Inicio; --recebe o primeiro estado no reset
			elsif (rising_edge(CLOCK))then
				estado_atual <= proximo_estado;
			end if;
end process; 


combinacional: process(Cliente, Botao_Ent, peso_menor_900,peso_entre_900_e_20000,peso_maior_20000,confirma_Pagamento,estado_atual)
begin
Ld_Contador <= '0'; 
Ld_Multiplicador_1 <= '0';
Ld_Multiplicador_Eixos <= '0';
Ld_Multiplicador_f <= '0';  
Ld_Pagamento <= '0';
Ld_Troco <= '0';
Ld_Valor <= '0';
Ld_Botao_S <= '0'; 


case estado_atual is
				when Inicio=>
				if(Cliente = '1') then
					proximo_estado <= Espera;
				else
					proximo_estado <= Inicio;
				end if;
					
				when Espera=>
				Ld_Contador <= '1'; 
				if(Botao_Ent = '1') then
						proximo_estado <= Leitura;
				elsif (fim_contador = '1') then --se o tempo do contador tiver estourado
						proximo_estado <= Inicio;
				else
				proximo_estado <= Espera; --se mantem na espera e fica contando
				end if;
					
				when Leitura=>
				if (peso_menor_900 = '1') then 
				proximo_estado <= Calcula_Valor_1;
				elsif (peso_entre_900_e_20000 = '1') then
				proximo_estado <= Calcula_Valor_2; 
				elsif (peso_maior_20000 = '1') then
				proximo_estado <= Calcula_Valor_3;
			   else 
			   proximo_estado <= Leitura; 	
				end if; 
	
			   
				when Calcula_Valor_1=>				
				Ld_Multiplicador_1 <= '1'; 
				Ld_Valor <= '1'; 
				proximo_estado <= Espera_Pagamento; 
				
				when Calcula_Valor_2=>				
				Ld_Multiplicador_Eixos <= '1'; 
				Ld_Valor <= '1'; 
				proximo_estado <= Espera_Pagamento; 
				
				when Calcula_Valor_3=>				
				Ld_Multiplicador_f <= '1';
				Ld_Valor <= '1'; 
				proximo_estado <= Espera_Pagamento; 
		
				when Espera_Pagamento=>
				Ld_Pagamento <= '1'; 
				if (Confirma_Pagamento = '1') then --bit do comparador de pagamento
				proximo_estado <= Calcula_Troco;
				else
				proximo_estado <= Espera_Pagamento; 		
				end if;
			
			
		     	when Calcula_Troco =>
				Ld_Troco <= '1'; 
				Ld_Botao_S <= '1'; 
				proximo_estado <= Espera_Saida;
				
				when Espera_Saida =>
				if (Cliente = '1') then
				proximo_estado <= Espera_Saida;
				else
				Ld_Botao_S <= '0'; 
				proximo_estado <= Inicio; 				
				end if;

when others =>
       proximo_estado<= Inicio;
end case;
end process combinacional;		

end arch;
