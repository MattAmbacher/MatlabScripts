
function [U, V, PHI, P_HYD] = read_single_jet()
    %nx,ny,nz refer to unstaggered values
    % returns: vertically averaged fields extended in y
    clear all;
    nx = 320;
    ny = 800;
    nz = 180;

    fList = load_all_netcdf('~/Desktop/SimulationData/Mike/');
    %fList = fList(1,:); %take only the first file i.e. wrfout_d01_05_00:00:00
    
    Uextend = zeros(nx, 2*ny, nz);
    Vextend = zeros(nx, 2*ny, nz);
    PHIextend = zeros(nx, 2*ny, nz);

   %read in fields
   U = squeeze(load_fields_from_netcdf(fList{end}, 'U'));
   V = squeeze(load_fields_from_netcdf(fList{end}, 'V'));
   phb = squeeze(load_fields_from_netcdf(fList{end}, 'PHB'));
   ph = squeeze(load_fields_from_netcdf(fList{end}, 'PH'));
   PHI = ph + phb;
   P_HYD = squeeze(load_fields_from_netcdf(fList{end}, 'P_HYD'));
   
   P_HYD = squeeze(mean(mean(P_HYD,2),1));

   %interpolate to mass points
   Um = 0.5 * (U(2:end,:,:,:) + U(1:end-1,:,:,:));
   Vm = 0.5 * (V(:,2:end,:,:) + V(:,1:end-1,:,:));
   PHIm = 0.5 * (PHI(:,:,2:end,:) + PHI(:,:,1:end-1,:));
   %P_HYD = 0.5 * (P_HYD(2:end) + P_HYD(1:end-1));

   %Extend in y
   Uextend(:,1:ny,:,:) = Um;
   Uextend(:,ny+1:end,:,:) = flip(Um,2); %even extension
   Vextend(:,1:ny,:,:) = Vm;
   Vextend(:,ny+1:end,:,:) = -flip(Vm,2); %odd extension
   PHIextend(:,1:ny,:,:) = PHIm;
   PHIextend(:,ny+1:end,:,:) = flip(PHIm,2); %even extension

   
   U = Uextend;
   V = Vextend;
   PHI = PHIextend;
   P_HYD = P_HYD;

end
