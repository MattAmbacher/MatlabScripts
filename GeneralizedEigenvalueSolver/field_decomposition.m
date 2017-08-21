M = size(Uhat,2); N = size(Uhat,1);
k_vec = -M/2:(M/2-1); l_vec = -N/2:(N/2-1);
K = 1:round(sqrt(max(k_vec.^2 + l_vec.^2)));
A0 = zeros(round(sqrt(max(k_vec.^2 + l_vec.^2))), num_modes);
Am = zeros(size(A0));
Ap = zeros(size(A0));
for nn=1:num_modes
[A0(:,nn), Ap(:,nn), Am(:,nn)] = GeoAgeo(Uhat(:,:,nn), Vhat(:,:,nn), PHIhat(:,:,nn), k_vec, l_vec, lam(nn));
end