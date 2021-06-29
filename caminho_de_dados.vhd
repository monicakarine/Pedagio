library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_bit.rising_edge;
entity caminho_de_dados is
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
end entity;

architecture arch of caminho_de_dados is
--Declaração dos sinais necessários
signal valor_contador : integer range 0 to 100;
signal mltp : std_logic_vector (3 downto 0);
signal resultado_multiplica : std_logic_vector(15 downto 0); 
signal resultado_diferenca : std_logic_vector (15 downto 0);
signal resultado_divisao : std_logic_vector(15 downto 0); 
signal taxa : std_logic_vector(3 downto 0);
signal confirmacao_pagou : std_logic; 

---------------------------------------- Declaração dos componentes que serão utilizados---------------------------------------------------------------------
component contador
port(
	Clock,Reset,load: in std_logic; 
	Q : out integer range 0 to 10;
	fim : out std_logic
);
end component; 

component compara
port(
     Peso : in std_logic_vector (15 downto 0);
     saida1, saida2, saida3:  out std_logic
);
end component;

component define_multiplicador
port(
	  Ld_Multiplicador_1, Ld_Multiplicador_Eixos, Ld_Multiplicador_f: in std_logic; 
	  Eixos : in std_logic_vector(3 downto 0);
	  resultado_divisao : in std_logic_vector (15 downto 0);
     Multiplicador : out std_logic_vector (3 downto 0)
);
end component;

component multiplicacao
port
(
	multiplicador, taxa: in std_logic_vector(3 downto 0);
	valor : out std_logic_vector (15 downto 0)
);
end component;

component subtrator
port(
     flag_pagamento : in std_logic ; 
     Valor, Pagamento : in std_logic_vector (15 downto 0);
     Troco:  out std_logic_vector (15 downto 0)
);
end component; 

component comparador_pagamento
port(
     flag_inicio : in std_logic; 
     Valor, Pagamento : in std_logic_vector (15 downto 0);
	  pagou: out std_logic
);
end component; 

component FFD_Valor 
port( 
	D: in std_logic_vector (15 downto 0);
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic_vector (15 downto 0)
);
end component;

component FFD_Troco
port( 
	D: in std_logic_vector (15 downto 0);
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic_vector (15 downto 0)
);
end component; 

component FFD_multiplicador
port( 
	D: in std_logic_vector (3 downto 0);
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic_vector (3 downto 0)
);
end component;

component FFD_botao
port( 
	D: in std_logic;
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic
);
end component; 

component FFD_pagou
port( 
	D: in std_logic;
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic
);
end component; 

component divisao 
	port
	(
	peso: in std_logic_vector(15 downto 0);
	eixos: in std_logic_vector(3 downto 0);
	valor : out std_logic_vector (15 downto 0)
	);
end component; 


begin
taxa <= x"6"; 
     
u0: contador port map(Clock => clk, Reset => rst, load => Ld_contador,Q => valor_contador, fim => fim_contador);
u1: compara port map(Peso=>Peso,saida1=>peso_menor_900, saida2=> peso_entre_900_e_20000, saida3=>peso_maior_20000);
u2: define_multiplicador port map(Ld_Multiplicador_1 => Ld_Multiplicador_1, Ld_Multiplicador_Eixos => Ld_Multiplicador_Eixos, 
Ld_Multiplicador_f => Ld_Multiplicador_f,Eixos => Eixos, resultado_divisao => resultado_divisao, Multiplicador => mltp);
u3: divisao port map (peso=> Peso, eixos => Eixos, valor => resultado_divisao);
u6: multiplicacao port map(multiplicador=>mltp,taxa=> taxa, valor => resultado_multiplica); 
u7: comparador_pagamento port map(flag_inicio => Ld_Pagamento, Valor =>resultado_multiplica, Pagamento => Pagamento, pagou=>confirmacao_pagou);
u8: subtrator port map (flag_pagamento => confirmacao_pagou, Valor => resultado_multiplica, Pagamento => Pagamento, Troco=> resultado_diferenca); 
u5: FFD_pagou port map (D => confirmacao_pagou, registra => Ld_Pagamento, rst => rst, clock => clk, Q=> confirma_pagamento); 
u9: FFD_Valor port map(D => resultado_multiplica, registra => Ld_Valor, rst => rst, clock => clk, Q => Valor_pd); 
u10: FFD_Troco port map (D => resultado_diferenca, registra => Ld_Troco, rst => rst, clock => clk, Q => Troco); 
u11: FFD_multiplicador port map(D => mltp, registra => Ld_Valor, rst => rst, clock => clk, Q => Multiplicador);
u12: FFD_botao port map (D=> Ld_Troco, registra => Ld_Botao_S, rst => rst, clock => clk, Q => Botao_S);
end arch;