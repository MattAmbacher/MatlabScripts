function [phi, phi_prime] = set_geopotential(x, y, eta, Ly)
lapse_rate = 0.005; %K/m
%lapse_rate = 0;
b = 2; %non-dimensional vertical width parameter 
T0 = 288; %K
Rd = 287.0; %J/kg/K - Dry air gas constant
g = 9.80616; % m / s^2
Omega = 7.292e-5; %1/s
f0 = 2*Omega*sin(pi/4); %1/s
a = 6.371229e6; % m - Radius of the Earth
beta0 = 2*Omega*cos(pi/4/a); % on beta plane
beta0 = 0; %on f plane
%u0 = 55; % m / s
u0 = 35;
y0 = Ly/2; %meridional position of reference latitude
Ly2 = 0;
phi_prime = zeros(1,length(y));

phi_avg = T0*g/lapse_rate * (1 - eta.^(Rd*lapse_rate/g));
for jj=1:length(y)
    phi_prime(jj) = 0.5*u0*( (f0 - beta0*y0).*(y(jj) - Ly2 - Ly/(2*pi).*sin(2*pi*y(jj)/Ly)) + beta0/2*(y(jj).^2 - Ly*y(jj)/pi.*sin(2*pi*y(jj)/Ly) - ...
        Ly*Ly/(2*pi*pi).*cos(2*pi*y(jj)/Ly) - Ly*Ly/3 - Ly*Ly/(2*pi*pi) ));
        if y(jj) < 0
            phi_prime(jj) = - phi_prime(jj);
        end
end
phi = phi_avg + phi_prime .* log(eta) .* exp( - (log(eta)/b).^2 );
end
