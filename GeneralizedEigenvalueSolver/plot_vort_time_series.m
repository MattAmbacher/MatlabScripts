figure(1)
clf;
for nn=1:6
    loadFields;
    count = 1;
    %for jj=40:80
    %    [zeta(:,:,count), Uy, Vx] = calc_vort(U, V, jj);
    %    count = count + 1;
    %end
    %disp(['Ro Max: ', num2str(max(zeta(:))/1e-4)])
    %RMS_Ro = calc_Ro_RMS(zeta(:,end/2:end,:));
    %disp(['Ro RMS: ', num2str(RMS_Ro/1e-4)])
    %[shear, dz, Lz] = calc_shear(U, PHI);
    %disp(['Fr Max: ', num2str(max(shear(:))/1e-2)]);
    %RMS_Fr = calc_Fr_RMS(shear, dz, Lz);
    %disp(['Fr RMS: ', num2str(RMS_Fr/1e-2)]) 
    plot_vort_div
    subplot(3,2,nn)
    contourf(xx,yy, div', 128, 'linecolor', 'none')
    set(gca, 'fontweight', 'bold')
    colormap darkjet;
    
    if (nn == 1)
       ylabel('y (km)');
       set(gca, 'XTick', [])
    end
    
    if (nn == 2) 
       set(gca, 'XTick', [])
       set(gca, 'Ytick', [])
    end
    
    if (nn == 3)
       ylabel('y (km)')
       set(gca, 'XTick', [])
    end
    
    if (nn == 4)
       set(gca, 'XTick', [])
       set(gca, 'Ytick', [])
    end
    
    if (nn == 5)
       xlabel('x (km)')
       ylabel('y (km)')
    end
    
    if (nn == 6)
       xlabel('x (km)');
       set(gca, 'YTick', [])
    end
    caxis([-2e-4, 2e-4]);
end
publishpic;
set(gcf,'PaperUnits','inches','Papersize',[width height],'PaperPositionMode','Auto')
print -dpdf -r500 -fillpage div_height_50.pdf