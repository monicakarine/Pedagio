library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_bit.rising_edge;

entity pedagio is
	port(
	 RESET   : in    std_logic; -- reset input
	 CLOCK   : in    std_logic; -- clock input
	 Cliente, Botao_Ent: in std_logic;
	 Peso    : in    std_logic_vector (15 downto 0);
	 Eixos 	 : in    std_logic_vector(3 downto 0);
	 Pagamento : in std_logic_vector (15 downto 0);
	 Valor_pd  : out std_logic_vector (15 downto 0);
	 multiplicador : out std_logic_vector(3 downto 0);
	 Troco 			 : out std_logic_vector (15 downto 0);
	 Botao_S 		 : out std_logic
);
end entity;

architecture arch of pedagio is
signal fim_count, confirma_pag, peso1,peso2,peso3 : std_logic; 
signal inicia_contador, inicia_pagamento, inicia_troco, inicia_m1,inicia_m2, inicia_m3,inicia_valor,inicia_saida: std_logic; 


component caminho_de_dados 
	port(
	clk    : in  std_logic;
    rst    : in  std_logic;
	 Peso   : in std_logic_vector(15 downto 0);
	 Eixos  : in std_logic_vector(3 downto 0);
	 Multiplicador : out std_logic_vector(3 downto 0);
	 Pagamento : in std_logic_vector (15 downto 0); 
	 Valor_pd : out std_logic_vector(15 downto 0);
	 Troco    : out std_logic_vector(15 downto 0);
	 Botao_S  : out std_logic; 
	 
	 -- Sinais da/para controladora --
    Ld_Contador   : in  std_logic;
	 Ld_Pagamento   : in std_logic;
	 Ld_Multiplicador_1,Ld_Multiplicador_Eixos,Ld_Multiplicador_f: in std_logic;
	 Ld_Valor        :in std_logic;
	 Ld_Troco       : in std_logic;
	 Ld_Botao_S        : in std_logic;
    fim_contador: out std_logic;
	 confirma_pagamento : out std_logic; 
	 peso_menor_900,peso_entre_900_e_20000,peso_maior_20000 : out std_logic
);
end component; 

component controladora 
port(
 RESET   : in    std_logic; -- reset input
 CLOCK   : in    std_logic; -- clock input
 Cliente, Botao_Ent: in std_logic;
 fim_contador, confirma_Pagamento : in std_logic; 
 peso_menor_900,peso_entre_900_e_20000,peso_maior_20000 : in std_logic;
 Ld_Contador, Ld_Pagamento,Ld_Multiplicador_1,Ld_Multiplicador_Eixos,Ld_Multiplicador_f,Ld_Valor,Ld_Troco, Ld_Botao_S : out std_logic
);
end component; 
begin 
a1: controladora port map(RESET => RESET, CLOCK => CLOCK, Cliente => Cliente, Botao_Ent => Botao_Ent, fim_contador => fim_count, 
confirma_Pagamento => confirma_pag, peso_menor_900 => peso1, peso_entre_900_e_20000 => peso2, peso_maior_20000 => peso3, 
Ld_Contador => inicia_contador, Ld_Pagamento => inicia_pagamento, Ld_Multiplicador_1 => inicia_m1, Ld_Multiplicador_Eixos => inicia_m2,
Ld_Multiplicador_f => inicia_m3, Ld_Valor => inicia_valor, Ld_Troco => inicia_troco, Ld_Botao_S => inicia_saida); 

a2: caminho_de_dados port map(clk=> CLOCK,rst => RESET, Peso => Peso, Eixos => Eixos, Multiplicador => multiplicador, 
Pagamento => Pagamento, Valor_pd => Valor_pd, Troco => Troco, Botao_S => Botao_S,  Ld_contador => inicia_contador, 
Ld_Pagamento => inicia_pagamento,Ld_Multiplicador_1 => inicia_m1, Ld_Multiplicador_Eixos => inicia_m2, 
Ld_Multiplicador_f => inicia_m3, Ld_Valor => inicia_valor, Ld_Troco => inicia_troco, Ld_Botao_S => inicia_saida, 
fim_contador => fim_count, confirma_Pagamento => confirma_pag, peso_menor_900 => peso1, peso_entre_900_e_20000 => peso2, 
peso_maior_20000 => peso3); 

end arch;
