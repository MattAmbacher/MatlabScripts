dke_modes = zeros(nx/2, num_modes);
rke_modes = zeros(nx/2, num_modes);

for nn=1:num_modes
    [vertU, vertV, vertPHI] = vert_projection(U,V,PHI, p, modes(:,nn));
    [delta, zeta] = helm(vertU, vertV);
    [dke_modes(:,nn), rke_modes(:,nn), ~] = spec2d(delta, zeta, nx, ny, dx);
end