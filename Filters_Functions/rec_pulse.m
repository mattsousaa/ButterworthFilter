fs = 500;             
T = 0.2;

t = -0.5:1/fs:0.5;

x=rectpuls(t,T);

plot(t,x,'k');
axis([-0.5 0.5 0 3]);
title('Rectangular Pulse');
xlabel('Times(s)');
ylabel('Amplitude');

L=length(x);
NFFT = 1024;

%FFT with FFTshift for both negative & positive frequencies
X = fftshift(fft(x,NFFT)); 
f = fs*(-NFFT/2:NFFT/2-1)/NFFT; %Frequency Vector
 
figure;
plot(f,abs(X)/(L),'r');
title('Magnitude of FFT');
xlabel('Frequency (Hz)')
ylabel('Magnitude |X(f)|');
