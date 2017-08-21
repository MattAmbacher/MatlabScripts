rke_slopes = zeros(num_modes,1);
for nn=1:num_modes
   
   clf;
   figure(1);
   hold off;
   
   %loglog(K, E_modes(:,nn), 'k-');
   
   [K_range, rot_slope, rot_bias] = fit_spectra(K, geostrophic_energy(:,nn));
   [K_range, rke_slope, rke_bias] = fit_spectra(K, rke_modes(:,nn));
   [K_range, div_slope, div_bias] = fit_spectra(K, ageostrophic_energy(:,nn));
   [K_range, dke_slope, dke_bias] = fit_spectra(K, dke_modes(:,nn));
   geo_slopes(nn) = rot_slope;
   ageo_slopes(nn) = div_slope;
   rke_slopes(nn) = rke_slope;
   dke_slopes(nn) = dke_slope;
  
   %[K_range, tot_slope, tot_bias] = fit_spectra(K, E_modes(:,nn));
   disp(['Mode ', num2str(nn)])
   disp(['Slope for geo: ', num2str(rot_slope)])
   disp(['Slope for RKE: ', num2str(rke_slope)])
   disp(['Slope for ageo: ', num2str(div_slope)])
   disp(['Slope for DKE: ', num2str(dke_slope)])
   [ref_K, ref_53, ref_3] = make_slopes(10^8, 30, 300);
   %disp(['Slope for total energy: ', num2str(tot_slope)])
   
   loglog(K, geostrophic_energy(:,nn), 'k-', 'linewidth', 2);
   hold on;
   loglog(K, ageostrophic_energy(:,nn), 'k--', 'linewidth', 2);
   %oglog(K, rke_modes(:,nn), 'r-.', 'linewidth', 2);
   %loglog(K, dke_modes(:,nn), 'r:', 'linewidth', 2);
   loglog(ref_K, ref_53, 'k-');
   loglog(ref_K, ref_3, 'k-');
   set(gca, 'xtick', logspace(0, 3, 4));
   xlabel('$\mathbf{\tilde{k}}$', 'interpreter', 'LaTeX');
   axis([0 512 10^-3 10^9])
   set(gca, 'fontsize', 14)
   set(gca, 'fontweight', 'bold')


   set(gca, 'fontsize', 14)
   set(gca, 'fontweight', 'bold')
   set(gcf,'PaperUnits','inches','Papersize',[width height],'PaperPositionMode','Auto')
   pause(1)
   %print('-dpdf', '-fillpage', '-r500', ['GeoAgeoRKEDKE_', num2str(nn), '.pdf'])
end