
### Projeto e simulação de um pedágio em VHDL para a disciplina de Laboratório de Sistemas Digitais da UFMG.
### Toll design and simulation in VHDL for the Digital Systems Laboratory course in UFMG.

I simulated a toll using 5 input signals (Cliente - 1 bit, Botao_Ent = 1 bit, Peso= 16 bits, Eixos = 4 bits and Pagamento = 16 bits) and 4 outputs (Valor = 16 bits, Troco = 16 bits, Multiplicador = 3 bits, and Botao_S = 1 bit). The costumer is detected by the signal Cliente = 1 and chooses, by pressing a botton (Botao_ent) if he/she wants to continue along the road or not. 
If the costumer chooses to enter the toll, then the system will calculate the fee cost by analyzing the weight and number of axles of the car. Using these two signals, the system calculates the fee to be paid and waits for payment, carried out through the Pagamento signal. Depending on the result, the multiplier is chosen from 3 pre-determined values. Tthe system will wait for the customer to enter the payment, and will not leave this state until the payment is equal to or greater than the calculated rate. The sign Botao_S receives the value 1 and the client is released to continue the journey. As soon as the customer leaves, the signal Cliente receives the value 0 and the system returns to the initial state.

F(x) = Peso/Eixos    | Multiplicador
---------------------| ------
450 <=F(x)<1000      | 1
1000 <=F(x)<2500     | 2
F(x)>=2500           | 3

This project also contains the simulation in Model Sim and the testbench. 
