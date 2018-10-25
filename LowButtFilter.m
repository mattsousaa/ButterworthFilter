% Projeto de Filtro Passa Baixas de Butterworth

% Especificações:

% Frequencia de passagem wp = 300 Hz 
% Frequencia de rejeição ws = 750 Hz
% Perda de amplitude na faixa de passagem = -0,2228 dB
% Perda de amplitude na faixa de rejeição = -13.01 dB


%|H(jw)| -> Achar função de transferência do filtro

% obtendo as especificações

wp = 300*2*pi;                  % frequencia de passagem [rad/s]
ws = 750*2*pi;                  % frequencia de rejeição [rad/s]

epsilon = 1-10^(-0.2228/20);    % 20log(1-eps) = -0,2228 dB
delta = 10^(-13.01/20);         % 20log(del) = -13,01 dB

% obtenção da ordem do filtro:
N = log10 (((2*epsilon - epsilon^2)*delta^2)/((1-epsilon)^2*(1-delta^2)))/(2*log10(wp/ws));
N = ceil(N);                    % arredondamento p/ o proximo inteiro

% obtendo a frequencia de corte

wcp = wp/((2*epsilon - epsilon^2)/(1-epsilon)^2)^(1/(2*N));
wcs = ws/((1-delta^2)/delta^2)^(1/(2*N));
wc = (wcp + wcs)/2;             % media entre os dois

% função de transferência do filtro de Butterworth ordem 4

num = wc^4;                     % criação de um numerador
den = [1 2.6131*wc 3.4142*wc^2 2.6131*wc^3 wc^4]; % criação de um denominador
Hs = tf(num, den);              % transformação (analógico -> digital)

% discretização de Tustin (IIR)

filename = 'big-ben-strikes-12-good-quality-sound.wav';
[som, freq] = audioread (filename);  % obtem arquivo e freq. do audio

Ts = 1/freq;                    % definição do período 

IIR = c2d(Hs, Ts, 'tustin');    % aproximação de Tustin
[IIRnum, IIRden] = tfdata(IIR, 'v');

% Aplicação do filtro digital

somlowpass = filter(IIRnum, IIRden, som); % aplica o filtro

audiowrite('result.wav', somlowpass, freq); % gera o audio filtrado


