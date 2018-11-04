% Projeto de Filtro Passa Baixas de Butterworth

% Especificações:

% Frequencia de passagem wp = 300 Hz 
% Frequencia de rejeição ws = 750 Hz
% Perda de amplitude na faixa de passagem = -0.2228 dB
% Perda de amplitude na faixa de rejeição = -13.01 dB

% Fases do projeto:
% 0. Especificações
% 1. Encontrar a ordem (N)
% 2. Descobrir wc
% 3. Montar a função H(s)
% 4. Implementação

% Ordem do filtro:
% N = log(((2*epsilon - epsilon^2)*delta^2)/((1-epsilon)^2*(1-delta^2)))/(2*log(wp/ws))
% Arredondar N para o inteiro mais próximo

% Frequência de corte:
% Faixa de Passagem: wc = wp/((2*epsilon - epsilon^2)/(1-epsilon)^2)^(1/(2*N))
% Faixa de Rejeição: wc = ws/((1-delta^2)/delta^2)^(1/(2*N)) 
% Fazer média entre os dois

% Montar H(s)
% H(s) = (wc^N)/Qn(s)
% O polinômio Qn(s) depende da ordem e já se encontra tabelado

%|H(jw)| -> Achar função de transferência do filtro

% obtendo as especificações

% Hz -> ciclos/seg -> 2*pi/s

wp = 300*2*pi;                  % frequencia de passagem [rad/s]
ws = 750*2*pi;                  % frequencia de rejeição [rad/s]

epsilon = 1-10^(-0.2228/20);    % 20log(1-eps) = -0.2228 dB
delta = 10^(-13.01/20);         % 20log(del) = -13.01 dB

% obtenção da ordem do filtro:
N = log10 (((2*epsilon - epsilon^2)*delta^2)/((1-epsilon)^2*(1-delta^2)))/(2*log10(wp/ws));
N = ceil(N);                    % arredondamento p/ o proximo inteiro

% obtendo a frequencia de corte

wcp = wp/((2*epsilon - epsilon^2)/(1-epsilon)^2)^(1/(2*N));
wcs = ws/((1-delta^2)/delta^2)^(1/(2*N));
wc = (wcp + wcs)/2;             % media entre os dois

% função de transferência do filtro de Butterworth ordem N

num = wc^N;                     % criação de um numerador
den = [1 2.6131*wc 3.4142*wc^2 2.6131*wc^3 wc^4]; % criação de um denominador
Hs = tf(num, den);              % transformação (analógico -> digital)

% discretização de Tustin (IIR)

filename = 'The Less I Know The Better - Tame Impala Lyrics.wav';
[som, freq] = audioread (filename);  % obtem arquivo e freq. do audio

Ts = 1/freq;                    % definição do período 

IIR = c2d(Hs, Ts, 'tustin');    % aproximação de Tustin
[IIRnum, IIRden] = tfdata(IIR, 'v');

% Aplicação do filtro digital

somlowpass = filter(IIRnum, IIRden, som); % aplica o filtro

audiowrite('impalalow.wav', somlowpass, freq); % gera o audio filtrado

filter_signal = audioread('impalalow.wav');

f_s = 11025;                    % frequencia de amostragem

[wave,f_s]=audioread('The Less I Know The Better - Tame Impala Lyrics.wav'); 

signal1 = audioread('The Less I Know The Better - Tame Impala Lyrics.wav');

signal2 = audioread('impalalow.wav');

%sound(wave,fs); 

t=0:1/f_s:(length(wave)-1)/f_s;

plot(t,wave);                   % plot do sinal original no domínio do tempo

my_fft(signal1, f_s);         % plot do sinal original

my_fft(signal2, f_s);         % plot do sinal filtrado
