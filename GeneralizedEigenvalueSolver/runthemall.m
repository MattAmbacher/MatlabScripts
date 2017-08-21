%normalmodes_simple;
%loadNormalModes;
[dummyU, dummyV, dummyPHI] = vert_projection(U,V,PHI,P_HYD);
vert_proj_U = zeros(size(dummyU,1), size(dummyU,2), num_modes);
vert_proj_V = zeros(size(dummyV,1), size(dummyV,2), num_modes);
vert_proj_PHI = zeros(size(dummyPHI,1), size(dummyPHI,2), num_modes);

Uhat = zeros(size(dummyU,1), size(dummyU,2), num_modes);
Vhat = zeros(size(dummyV,1), size(dummyV,2), num_modes);
PHIhat = zeros(size(dummyPHI,1), size(dummyPHI,2), num_modes);

for n=1:num_modes
   interp_mode = interp1(Pcheb(2:end-1), modes(:,n), P_HYD, 'spline');
   [vert_proj_U(:,:,n), vert_proj_V(:,:,n), vert_proj_PHI(:,:,n)] = vert_projection(U,V,PHI,interp_mode); 
   [Uhat(:,:,n), Vhat(:,:,n), PHIhat(:,:,n)] = horiz_projection(vert_proj_U(:,:,n), vert_proj_V(:,:,n), vert_proj_PHI(:,:,n));
end