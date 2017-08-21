nx = size(U,1); ny = size(U,2);
dx = 5000;
Lx = nx*dx;

[delta, zeta] = rotdiv(U, V, nx, ny, Lx);


z1 = find(z > 7000, 1);
z2 = find(z > 10000, 1);
z3 = find(z > 15000, 1);
z4 = find(z > 20000, 1);


rotE = zeros(nx/2,size(U,3));
divE = zeros(size(rotE));
potE = zeros(size(rotE));

rke = zeros(nx/2, 1);
dke = zeros(nx/2,1);
PE = zeros(nx/2,1);
z1 = 1; z2 = size(delta,3);
for nn=z1:z2
   %PHhat = fftshift(fft2(PH(:,:,nn)))/sqrt(nx*ny); 
   [divE(:,nn), rotE(:,nn), potE(:,nn)] = spec2d(delta(:,:,nn), zeta(:,:,nn), nx, ny, dx);
end

for kk=1:nx/2
    rke(kk)  = 1/2*1/(P_HYD(z1) - P_HYD(z2)) * sum ( (rotE(kk,2:end) + rotE(kk, 1:end-1)) .* dp');
    dke(kk)  = 1/2*1/(P_HYD(z1) - P_HYD(z2)) * sum ( (divE(kk,2:end) + divE(kk, 1:end-1)) .* dp');
    %PE(kk) = 1/2*1/(P_HYD(z1) - P_HYD(z2)) * sum( (potE(kk,2:end) + potE(kk,1:end-1)) .* dp');
end

KE = rke + dke;



