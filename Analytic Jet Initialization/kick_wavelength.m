%kick_wavelength.m
%Finding out what gaussian parameters result in a kick with wavelength
%4000km
dx = 15000;
x = linspace(0,15000e3, 1000);
N = length(x);
L = 15000e3;
n = 2^nextpow2(N);
sig1 = 500e3;
y1 = exp( -(x).^2/(2*sig1^2));
Y1 = fft(y1,n);

k =2*pi/L*(0:n/2);
figure(1)
plot(k, abs(Y1(1:n/2+1)));
hold on
plot([2*pi/4000e3, 2*pi/4000e3], [0, 50], 'r--');
hold off;
figure(2)
plot(y1)

