%visualize_wavenumbers
N = size(U,2);
M = size(U,1);
Ly = 10000e3;
Lx = 10000e3;
kx = [-N/2+1:N/2];% * 2*pi/Lx;
ky = [-M/2+1:M/2];% * 2*pi/Ly;

contourf(kx,ky,U(:,:,27,1), 128, 'linecolor', 'none')