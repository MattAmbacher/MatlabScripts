clf;
count = 1;
first = 26; last = 28;
height = 7; width = 6.375;
for nn=first:2:last
    subplot(2,1,count)
    %clf;
    [ref_K, ref_53, ref_3] = make_slopes(10^6, 30, 300);
    
   loglog(K, geostrophic_energy(:,nn), 'k-', 'linewidth', 2);
   hold on;
   loglog(K, ageostrophic_energy(:,nn), 'k--', 'linewidth', 2);
   loglog(K, dke_modes(:,nn) , 'r:', 'linewidth', 2);
   %loglog(K, PE_modes(:,nn), 'r-.', 'linewidth', 2);
   loglog(K, rke_modes(:,nn), 'r-.', 'linewidth', 2);
   loglog(ref_K, ref_53, 'k-');
   loglog(ref_K, ref_3, 'k-');
   %loglog([ceil(Lx/(2*pi)*f/cn(nn)) ceil(Lx/(2*pi)*f/cn(nn))], [10^-2, 10^7], 'Color', [0 0.5 0])
   %line1=char('Geostrophic','Ageostrophic');
  %  line2=char('RKE','DKE');
    %line={line1,line2};
   % h5=legend(line,'location','southwest','Orientation','horizontal');
  %legend('Geostrophic', 'Ageostrophic', 'APE' , 'location','southwest', 'orientation', 'horizontal');
   if (count == 2)
        hL = columnlegend(2, {'Geo', 'Ageo', 'DKE', 'RKE'}); 
        set(hL, 'Position', [0.22, 0.08, 0.35, 0.1]);
          %legend('Geostrophic', 'Ageostrophic', 'RKE', 'DKE', 'location','northoutside', 'orientation', 'horizontal');

   end
   set(gca, 'xtick', logspace(0, 3, 4));
   set(gca, 'ytick', logspace(-2, 8, 6));
   if (count == 2)
        xlabel('$\mathbf{\tilde{k}}$', 'interpreter', 'LaTeX');
   end
   ylabel('$\mathbf{E_k} (\mathbf{\tilde{k}})  ~~(\mathrm{m}^3 \mathrm{s}^{-2} \mathrm{kg}~ \mathrm{m}^{-3})$', 'interpret', 'latex')
   axis([0 512 10^-2 10^9])
   % title(['Vertical Mode ', num2str(nn-1)])
   set(gca, 'fontsize', 12)
   set(gca, 'fontweight', 'bold')
   set(gcf,'PaperUnits','inches','Papersize',[width height],'PaperPositionMode','Auto')
   count = count + 1; 
   %print('-dpdf', '-fillpage', '-r500', ['GeoAgeop_DKERKE_', num2str(nn-1), '.pdf'])
   %grid on
end
   print('-dpdf', '-fillpage', '-r500', ['GeoAgeo_RKEDKE_', num2str(first-1), '-', num2str(last-1), '.pdf'])

