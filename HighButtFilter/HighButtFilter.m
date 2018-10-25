%|H(jw)| -> Achar função de transferência do filtro

% obtendo as especificaçõespecifica

wp = 2000;                  % frequencia de passagem [rad/s]
ws = 1000;                  % frequencia de rejeição [rad/s]

% troca wp e ws

new_wp = ws;
new_ws = wp;

epsilon = 1-10^(-10/20);    % 20log(1-eps) = -0.4 dB
delta = 10^(-0.4/20);         % 20log(del) = -10 dB

% obtenção da ordem do filtro:
N = log10 (((2*epsilon - epsilon^2)*delta^2)/((1-epsilon)^2*(1-delta^2)))/(2*log10(new_wp/new_ws));
N = ceil(N);                    % arredondamento p/ o proximo inteiro

% obtendo a frequencia de corte

wcp = new_wp/((2*epsilon - epsilon^2)/(1-epsilon)^2)^(1/(2*N));
wcs = new_ws/((1-delta^2)/delta^2)^(1/(2*N));
wc = (wcp + wcs)/2;             % media entre os dois

wc_pa = (new_wp*new_ws)/wc;

% função de transferência do filtro de Butterworth ordem 4

num = [wc_pa]^4;                     % criação de um numerador
den = [1 2.6131*wc_pa 3.4142*wc_pa^2 2.6131*wc_pa^3 wc_pa^4];
Hs = tf(num, den);              % analógico -> digital

% discretização de Tustin (IIR)

filename = 'big-ben-strikes-12-good-quality-sound.wav';
[som, freq] = audioread (filename);  % obtem arquivo e freq. do audio

Ts = 1/freq;

IIR = c2d(Hs, Ts, 'tustin');    % aproximação de Tustin
[IIRnum, IIRden] = tfdata(IIR, 'v');

% Aplicação do filtro digital

somlowhigh = filter(IIRnum, IIRden, som); % aplica o filtro

audiowrite('resulthigh.wav', somlowhigh, freq);


