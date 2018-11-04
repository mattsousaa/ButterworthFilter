fs = 10000;                 %freq. de amostragem
t = [0:1/fs:10];            
s1 = sin(2*pi*50*t);        % sinal 1
s2 = 15*sin(2*pi*150*t);    % sinal 2
s3 = 40*sin(2*pi*80*t);     % sinal 3
s4 = 30*sin(2*pi*350*t);    % sinal 4
s5 = 65*sin(2*pi*200*t);    % sinal 5

s = s1+s2+s3+s4+s5;         % soma dos 5 sinais

plot(t,s);                  % plota o grafico (time)

% my_fft(s, fs);            % plota o grafico (frequency)
