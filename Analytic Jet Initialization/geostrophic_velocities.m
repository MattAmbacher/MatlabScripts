%geostrophic_velocities
%converts u,v to ug, vg

function [ug,vg] = geostrophic_velocities(T, p, f, dx,dy)
R = 8.314;
conversion_factor = 0.0289644; % kg/mol for dry air
T = 300 + T;
kappa = 0.286;

rho = p ./ (R .* T .* (1e5./p).^(-kappa)) * conversion_factor;
dpdy = diff(p, 1, 1)/dy;
dpdy = dpdy(:,1:end-1); %remove last column for dp/dy because stupid finite differencing is fucking stupid
dpdx = diff(p,1,2)/dx;
dpdx = dpdx(1:end-1,:); %remove last row for dp/dx because of stupid shit

rho = rho(1:end-1, 1:end-1); %remove the last column and row because dp is (m-1)x(n-1) due to finite differences
f = f(1:end-1,1:end-1); %remove the last column and row because dp is (m-1)x(n-1) due to finite differences
ug = -1.0./(f.*rho) .* dpdy;
vg = 1.0./(f.*rho) .* dpdx;
end