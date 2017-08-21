for nn=1:num_modes
   disp(['Mode ', num2str(nn-1)])
   disp('--------------------------')
   [K_range, div_slope, rot_bias, R2] = fit_spectra(K, geostrophic_energy(:,nn));
   disp(['Geo: slope is ', num2str(div_slope), ' R2 is ', num2str(R2)])
   [K_range, div_slope, rot_bias, R2] = fit_spectra(K, ageostrophic_energy(:,nn));
   disp(['Ageo: slope is ', num2str(div_slope), ' R2 is ', num2str(R2)])
   [K_range, div_slope, rot_bias, R2] = fit_spectra(K, rke_modes(:,nn));
   disp(['RKE: slope is ', num2str(div_slope), ' R2 is ', num2str(R2)])
   [K_range, div_slope, rot_bias, R2] = fit_spectra(K, dke_modes(:,nn));
   disp(['DKE: slope is ', num2str(div_slope), ' R2 is ', num2str(R2)])
end