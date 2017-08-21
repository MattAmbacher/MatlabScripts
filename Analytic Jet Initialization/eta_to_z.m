%eta_to_z.m
% Create jet for bwave with same analytic ICs as Ullrich, Reed, and
% Jablonowski (2015). This program converts the eta pressure coordinate to
% the cartesian z coordinate for WRF to use

function [z, T] = eta_to_z(x,y,eta, u0, T0, gamma, Rd, Omega, Ly, y0, b)
%takes in array of eta and converts to z
a = 6.37e6; %radius of earth
f0 = 2*Omega*sin(pi/4);
%beta0 = 2*Omega*cos(pi/4)/a;
beta0 = 0;

phi_avg = T0*9.81/gamma * ( 1 - eta.^(Rd*gamma/9.81));
phi_prime = u0/2 * ((f0-beta0.*y0) * (y - Ly/2 -Ly/(2*pi) * sin(2*pi.*y/Ly)) + beta0/2 * (y.^2 - Ly*y/pi * sin(2*pi.*y/Ly) - ...
    Ly^2/(2*pi^2) * cos(2*pi.*y/Ly) - Ly^2/3 - Ly^2/(2*pi^2)) );

phi = phi_avg + phi_prime.*log(eta)*exp( -(log(eta)/b).^2 );

z = phi/9.81;

T = set_temperature(eta,phi_prime,T0,Rd,gamma, b);
end
