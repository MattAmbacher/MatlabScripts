%compute power spectrum

function [wavenumbers, energy] = power_spectrum_calc(u,v);

[u,v] = unstagger(u,v);

uavg = mean(mean(u));
vavg = mean(mean(v));

u = u - uavg;
v = v - vavg;

Lx = 10000e3;
Ly = 6000e3;

N = size(u,2);
M = size(u,1);

U = abs(fftshift(fft2(u))).^2;
V = abs(fftshift(fft2(v))).^2;

k = 2*pi / Lx * ((1:N)-N/2);
l = 2*pi / Ly * ((1:M)-M/2);
energy = zeros(length(max( round( sqrt(k.^2 + l.^2)))),1);
wavenumbers = zeros(length(max(round(sqrt(k.^2 + l.^2)))),1);
for i=1:M
    for j=1:N
        K = round(sqrt( k(j)^2 + l(i)^2));
        if K == 0
            K = 1;
        end
        energy(K) = energy(K) + U(i,j);
    end 
end

