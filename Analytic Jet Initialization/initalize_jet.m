dx = 5000;
dy = 5000;
dz = 25000/100;


Lx = dx*1024;
Ly = dy*1024;
Lz = 25000;

x = 0:dx:Lx;
%y = -Ly:dy:Ly;
y = 0:dy:Ly;
z = 0:dz:Lz;

p0 = 1e5;
eta = eta_to_z_fixedpoint(x,y,z,Ly);
%eta = 1:-deta:01;
%eta = flip(eta,3);
eta = linspace(0.02, 1, 101);


u = zeros(length(x), length(y), length(z));
T = zeros(length(x), length(y), length(z));
rho = zeros(length(x), length(y), length(z));
phi = zeros(length(x), length(y), length(z));
for zz=1:length(z)
    %uu = set_u(x,y,eta(1,:,zz), Ly);
    uu = set_u(x,y,eta(zz), Ly);
    %[pphi, pphi_prime] = set_geopotential(x,y,eta(1,:,zz), Ly);
    [pphi, pphi_prime] = set_geopotential(x,y,eta(zz), Ly);
    %[Tt, Tavg, ttheta] = set_temperature(x,y,eta(1,:,zz), pphi_prime);
    [Tt, Tavg, ttheta] = set_temperature(x,y,eta(zz), pphi_prime);
    for ii=1:length(x)
        u(ii,:,zz) = uu;
        T(ii,:,zz) = ttheta;
        phi(ii,:,zz) = pphi;
        %rho(ii,:,zz) = p0 .* eta(ii,:,zz)./(287.0 .* Tt);
        rho(ii,:,zz) = p0 .* eta(zz)./(287.0 .* Tt);
    end
end

max(max(squeeze(u(1,:,:))))
% u = permute(u, [2,1,3]);
% T = permute(T, [2,1,3]);
% rho = permute(rho, [2,1,3]);
% phi = permute(phi, [2,1,3]);

