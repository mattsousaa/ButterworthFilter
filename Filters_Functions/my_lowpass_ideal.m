% Filtro passa baixas ideal
% 
% Retorna a função sinc(x)
% para teste de filtro digital passa-baixas

function hd = my_lowpass_ideal(wc,M)

alpha = (M-1)/2;
n = [0:M-1];
m = n - alpha + eps;
hd = sin(wc*m)./(pi*m);
%plot(hd);

end
