dx = 20000;
dy = 20000;
dz = 30000/50;


Lx = 5000e3;
Ly = 5000e3;
Lz = 30000;

x = 0:dx:Lx;
y = 0:dy:Ly;
z = 0:dz:Lz;

p0 = 1e5;
eta = eta_to_z_fixedpoint(x,y,z);

u = zeros(length(x), length(y), length(z));
T = zeros(length(x), length(y), length(z));
rho = zeros(length(x), length(y), length(z));
phi = zeros(length(x), length(y), length(z));
for zz=1:length(z)
    uu = set_u(x,y,eta(1,:,zz));
    [pphi, pphi_prime] = set_geopotential(x,y,eta(1,:,zz));
    [Tt, Tavg, ttheta] = set_temperature(x,y,eta(1,:,zz), pphi_prime);
    for ii=1:length(x)
        u(ii,:,zz) = uu;
        T(ii,:,zz) = ttheta;
        phi(ii,:,zz) = pphi;
        rho(ii,:,zz) = p0 .* eta(ii,:,zz)./(287.0 .* Tt);
    end
end

% u = permute(u, [2,1,3]);
% T = permute(T, [2,1,3]);
% rho = permute(rho, [2,1,3]);
% phi = permute(phi, [2,1,3]);

