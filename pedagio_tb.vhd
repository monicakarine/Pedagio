library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pedagio_tb is
end pedagio_tb;

architecture teste of pedagio_tb is
component pedagio is
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
end component;

signal RESET,CLOCK,Cliente,Botao_Ent,Botao_S: std_logic;
signal Peso, Pagamento,Valor_pd,Troco : std_logic_vector(15 downto 0); 
signal Eixos,multiplicador : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant PERIOD     : time := 20 ns;
   constant DUTY_CYCLE : real := 0.5;
   constant OFFSET     : time := 5 ns;

begin
instancia_pedagio: pedagio port map(RESET => RESET, CLOCK => CLOCK, Cliente => Cliente, Botao_Ent => Botao_Ent, Botao_S => Botao_S, 
Peso => Peso, Pagamento => Pagamento, Valor_pd=> Valor_pd, Troco => Troco,Eixos =>Eixos, multiplicador=> multiplicador);
estimulos_proc: process
begin
RESET <= '1'; 
wait for 50 ns; 
RESET <= '0'; 
Cliente <= '1'; -- Entra primeiro cliente
Botao_Ent <= '1'; -- Ele quer entrar no pedagio
Peso <= x"0820"; --2080 kg
Eixos <= x"2"; 
Pagamento <= x"003c"; -- Ele dá 60 reais
wait for 200 ns;
Botao_Ent <= '0'; 
Cliente <= '0'; 
wait for 50 ns; 
Cliente <= '1';
Botao_Ent <= '1';  
Peso <= x"53fc";--21500kg
Eixos <= x"4";
Pagamento <= x"0064"; --100 reais
wait for 200 ns;
Botao_Ent <= '0'; 
Cliente <= '0'; 
wait for 50 ns; 
Cliente <= '1'; 
Botao_Ent <= '1';
Peso <= x"01ea"; --490 kg
Eixos <= x"1"; 
Pagamento <= x"0014"; -- 20 reais
wait for 200 ns;
Botao_Ent <= '0'; 
Cliente <= '0'; 
wait for 50 ns; 
Cliente <= '1'; 
Botao_Ent <= '1';
Peso <= x"139c"; -- 5020 kg
Eixos <= x"2"; 
Pagamento <= x"0012"; -- 12 reais
wait for 200 ns;
Botao_Ent <= '0'; 
Cliente <= '0'; 
wait for 50 ns; 
Cliente <= '1'; 
Botao_Ent <= '1';
Peso <= x"0546"; -- 1350
Eixos <= x"3"; 
Pagamento <= x"0020"; -- 32 reais
wait for 200 ns;
end process;
------------------------------------------------------------------------------------
----------------- process para gerar o sinal de clock ------------------------------
------------------------------------------------------------------------------------		
        PROCESS    -- clock process for clock
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                CLOCK <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                CLOCK <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

		  
------------------------------------------------------------------------------------
----------------- processo para gerar o estimulo de reset
------------------------------------------------------------------------------------		
	sreset: process
	begin
		RESET <= '1';
		for i in 1 to 4 loop
			wait until rising_edge(CLOCK);
		end loop;
		RESET <= '0'; 
		wait;	
	end process sreset;
end teste;