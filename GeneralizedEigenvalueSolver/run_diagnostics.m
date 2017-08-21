KE_modes = zeros(1, num_modes);
for n = 1:num_modes
     KE_modes(n) = KE(squeeze(Uhat(:,:,n)), squeeze(Vhat(:,:,n)));
end