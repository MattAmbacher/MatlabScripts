function [shear, dz, Lz] = calc_shear(U,PHI)
z = squeeze(mean(mean(PHI,1),2))/9.81;
dz = diff(z);
Lz = z(80) - z(40);
shear = zeros(size(U,1), size(U,2), size(U,3)-2);
for nn=2:size(U,3)-1
   shear(:,:,nn-1) = ( U(:,:,nn+1)-  U(:,:,nn-1))/(dz(nn) + dz(nn-1));
end
end