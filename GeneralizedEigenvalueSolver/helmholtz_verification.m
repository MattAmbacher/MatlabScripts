function helmholtz_verification(U,V)

dx = 5000; dy = 5000;
nx = size(U,2); ny = size(U,1);
Lx = nx*dx;

[delta, zeta] = rotdiv(U, V, nx, ny, Lx);

for nn=1:size(U,3)
   KE = 1/2 * sum(sum( U(:,:,nn).^2 + V(:,:,nn).^2));% * dx  * dy;
   [dke, rke] = spec2d(delta(:,:,nn), zeta(:,:,nn), nx, ny, dx);
   sprintf('KE: %0.5e , KE_hat: %0.5e ratio: %d', KE, sum(dke)+sum(rke), (sum(dke)+sum(rke))/KE)
end