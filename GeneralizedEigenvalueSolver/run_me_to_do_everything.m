
%normalmode_kasahara;
normalmodes_FD;
disp('Beginning field projection')
scale = 1.0216e5;
%[U, V, PHI] = interp_fields_to_modes(flip(U,3),flip(V,3),flip(PHI,3), flipud(P_HYD), sigma, scale);
[U, V, PHI] = interp_fields_to_modes(flip(U,3),flip(V,3),flip(PHI,3), flipud(P_HYD), phalf, scale);
%[Uhat, Vhat, PHIhat] = project_fields(U,V,PHI, flipud(P_HYD), modes, num_modes, sigma, scale);
[Uhat, Vhat, PHIhat] = project_fields(U,V,PHI, flipud(P_HYD), modes, num_modes, p, 1);
g = 9.81;
% 
ny = size(Uhat,2); nx = size(Uhat,1);
%k_vec = -M/2:(M/2-1); l_vec = -(N)/2:((2*N)/2-1);
%ny = size(Uhat,2); nx = size(Uhat,1);
k_vec = -nx/2:(nx/2-1); l_vec = -ny/2:(ny/2-1);

E_modes = zeros(nx+ny,num_modes);
KE_modes = zeros(size(E_modes));
PE_modes = zeros(size(E_modes));
geostrophic_energy = zeros(size(E_modes)); %Geostrophic energy
ageostrophic_energy = zeros(size(E_modes)); %Ageostrophic waves
rke_modes = zeros(size(E_modes));
dke_modes = zeros(size(E_modes));

disp('Beginning Geostrophic/Ageostrophic decomposition')
for nn=1:num_modes
    %E_modes is the total KE in each vertical mode + PE in each vertical
    %mode
    disp(['Mode ', num2str(nn)]);
    disp(['Lambda ', num2str(lam(nn))]);
    disp('----------------------')
    cn =sqrt(1/lam(nn));
    disp(['cn in run_me is ', num2str(cn)]);
    tic
    [E_modes(:,nn), KE_modes(:,nn), PE_modes(:,nn)] = KH_spectrum(Uhat(:,:,nn), Vhat(:,:,nn), PHIhat(:,:,nn)/cn, k_vec, l_vec, nx, ny);
    disp(['KH_spectrum took ', num2str(toc), ' seconds'])
    tic
    [geostrophic_energy(:,nn), ageostrophic_energy(:,nn)] = GeoAgeo(Uhat(:,:,nn), Vhat(:,:,nn), PHIhat(:,:,nn), k_vec, l_vec, lam(nn), nx, ny);
    disp(['GeoAgeo took ', num2str(toc), ' seconds'])
    disp('----------------------')
end

KE = KE_full(U,V, sigma, scale);
% R = 287;
% cp = 1004.5;
% T0 = 288;
% lapse = 0.005;
% g = 9.81;
% kappa = R/cp;
% 
% eta = P_HYD/max(P_HYD);
% theta = T0 * eta.^(R*lapse/g - kappa);
% dtheta_dp = 1./P_HYD .*( R*lapse/g - kappa) .* eta .^(R*lapse/g - kappa);
% KE_tot = 1/2*sum( U(:).^2 + V(:).^2 );
% p_surface = max(P_HYD);
% 
% [delta, zeta] = rotdiv(Uhat, Vhat, 1);
% [div_bins, rot_bins] = spec2d(delta, zeta);
%APE_tot = (R*p_surface^(-kappa))/2 * dp*sum(P_HYD.^(kappa - 1) .* (-g * dtheta_dp) );