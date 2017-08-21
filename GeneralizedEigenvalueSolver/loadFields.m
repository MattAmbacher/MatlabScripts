%load field including velocity, and vertical pressure coordinate
%fList = load_all_netcdf('~/Desktop/SimulationData/higherRo/');
fList = load_all_netcdf('~/Desktop/SimulationData/evenpressure/');
%fList = fList(2:end,:);
fList
dummyU = load_fields_from_netcdf(fList{1}, 'U');
dummyV = load_fields_from_netcdf(fList{1}, 'V');
dummyPHI = load_fields_from_netcdf(fList{1}, 'PHB');
disp (fList{1})
U = zeros(size(dummyU));
V = zeros(size(dummyV));
PHI = zeros(size(dummyPHI));
nn = 1;
tot_time = size(dummyU,4)*size(fList,1);
for n=1:1%size(fList,1)
    P_HYD = load_fields_from_netcdf(fList{nn}, 'P_HYD');
    P_HYD = P_HYD(:,:,:,1);
    P_HYD = squeeze(mean(mean(P_HYD,1),2));
    Utemp = load_fields_from_netcdf(fList{nn}, 'U');
    Vtemp = load_fields_from_netcdf(fList{nn}, 'V');
    T = load_fields_from_netcdf(fList{nn}, 'T');
    T = T + 300;
    phb = load_fields_from_netcdf(fList{nn}, 'PHB');
    PH = load_fields_from_netcdf(fList{nn}, 'PH');
    PHItemp = PH + phb;
    DN = load_fields_from_netcdf(fList{nn}, 'DN');
    mu = load_fields_from_netcdf(fList{nn}, 'MU');
    mub = load_fields_from_netcdf(fList{nn}, 'MUB');
    MU = mu + mub;
    clear phb; clear mu; clear mub;

   
    %Do unstaggering and interpolation here
    U = Utemp(:,:,:,1);
    V = Vtemp(:,:,:,1);
    PHI = PHItemp(:,:,:,1);
    %DN = DN(:,:,:,1);
    %for nn = 1:size(Utemp,4)
      %  U = U + 1/tot_time*sUtemp(:,:,:,nn);
      %  V = V + 1/tot_time*Vtemp(:,:,:,nn);
       % PHI = PHI + 1/tot_time*PHItemp(:,:,:,nn);
    %end
    clear Utemp; clear Vtemp; clear PHItemp;
end
U = (U(1:end-1,:,:) + U(2:end,:,:))/2;
V = (V(:,1:end-1,:) + V(:,2:end,:))/2;
PHI = (PHI(:,:,1:end-1,:) + PHI(:,:,2:end,:))/2;
PH = (PH(:,:,1:end-1,:) + PH(:,:,2:end,:))/2;
