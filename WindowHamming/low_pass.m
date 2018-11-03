% Filtro passa-baixas FIR

fa = 20000;

f_samp = fa;

% Teorema de Nyquist
%
% f_amostragem >= 2*f_sinal
%
% A frequência de amostragem deve ser pelo menos o dobro da frequência 
% máxima do sinal.
%
% Especificações
% fp = 1000Hz
% fs = 1500Hz
% ft = 1500 - 1000 = 500
% fc = (1000+1500)/2 = 1250

[s1, fa] = audioread ('Voice 5.wav');
% fa = 11025Hz
% Teorema de Nyquist 
% A frequência de amostragem deve ser pelo menos o dobro
% da frequência máxima do sinal.

fsamp = fa;

fp = 1000; % frequência de passagem
fs = 2000; % frequência de corte

% normalização das frequências
wp = (fp/(fsamp/2))*pi; 
ws = (fs/(fsamp/2))*pi;

wt = ws - wp;     %frequência de transição

M = ceil((6.6*pi/wt)) + 1;

wc = (ws + wp)/2; %frequência de corte intermediária

hd = my_lowpass_ideal(wc,M); %função sinc para passa baixas ideal

w_hamm = hamming(M)';  %calcula a janela de hamming

h = hd.*w_hamm; %faz a multiplicação entre os vetores

s1_filtrado = conv(h,s1(:,1)); %convolução entre os sinais

% plota o som original no domínio tempo

[wave,fa]=audioread('Voice 5.wav');  

t=0:1/fa:(length(wave)-1)/fa;

plot(t,wave);

my_fft(s1,fsamp);

my_fft(s1_filtrado,fsamp);
