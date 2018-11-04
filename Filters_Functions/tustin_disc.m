%Cria funcao de transferencia analogica
 
Hs = tf([1], [0.01 1]);
 
%Discretiza a funcao de transferencia com amostragem de 1000Hz
 
Hz = c2d(Hs, 0.001, 'tustin');

%Plota a resposta ao degrau
 
step(Hs, '-', Hz, '--');
