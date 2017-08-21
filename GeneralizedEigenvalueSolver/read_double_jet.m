function [divE, rotE] = read_double_jet()
nx = 1024;
ny = 1024;
%nz = 150;

fList = load_all_netcdf('~/Desktop/SimulationData/hires/');
%fList = fList{1};
%N = size(fList,1);
N=1;
num_modes = 1;
%
%for n=1:size(fList,2)
%	disp(n)
%	disp(fList{n})
%end
%
for n=1:N
   %loop over each file
   
   %read in fields
   U = load_fields_from_netcdf(fList{2}, 'U');
   V = load_fields_from_netcdf(fList{2}, 'V');
   ph = load_fields_from_netcdf(fList{2}, 'PH');
   phb = load_fields_from_netcdf(fList{2}, 'PHB');
   PHI = ph + phb;
   clear ph; clear phb;
   z = squeeze(mean(mean(PHI,2),1))/9.81;
   dz = diff(z);
   
   %interpolate to mass points
   U = 0.5 * (U(2:end,:,:) + U(1:end-1,:,:));
   V = 0.5 * (V(:,2:end,:) + V(:,1:end-1,:));
   
   %run helm.m for each z level between 5km and 10km
   
   min_ind = find(z > 5000,1);
   max_ind = find(z >= 10000, 1);
   delta = zeros(size(U,1), size(U,2), max_ind - min_ind + 1, num_modes);
   zeta = zeros(size(delta));
   divE = zeros(size(U,1)/2,num_modes);
   rotE = zeros(size(U,1)/2,num_modes);
   for zz = min_ind:max_ind
      [delta(:,:,zz-min_ind+1,1), zeta(:,:,zz-min_ind+1,1)] = helm(U(:,:,zz), V(:,:,zz));
      [div_energy_per_level, rot_energy_per_level] = spec2d(delta(:,:,zz-min_ind+1,1), zeta(:,:,zz-min_ind+1,1));
      divE = divE + 1/5000 * div_energy_per_level * dz(zz);
      rotE = rotE + 1/5000 * rot_energy_per_level * dz(zz);
   end
end
end
