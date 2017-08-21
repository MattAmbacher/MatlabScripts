%calculate TKE Tme series
files = load_all_netcdf('~/Desktop/SimulationData/hires/');
tke_series = [];
for nn=1:length(files)
   U = ncread(files(nn,:), 'U');
   if  nn == 1
      jet_mean = U(:,:,:,1);
      jet_mean = (U(1:end-1,:,:) + U(2:end,:,:))/2;
   end
   V = ncread(files(nn,:), 'V');
   U = (U(1:end-1,:,:,:) + U(2:end,:,:,:))/2;
   V = (V(:,1:end-1,:,:) + V(:,2:end,:,:))/2;
   
   modifiedU = zeros(size(U,1),size(U,2), size(U,3));
   for tt = 1:size(U,4)
        modifiedU = U(:,:,:,tt) - jet_mean;
        modifiedV = V(:,:,:,tt);
        tke_series = [tke_series; 1/2*sum(modifiedU(:).^2 + modifiedV(:).^2)];
   end
    clear U; clear V;
end
