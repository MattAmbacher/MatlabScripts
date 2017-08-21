%set_temperature.m
% Create jet for bwave with same analytic ICs as Ullrich, Reed, and
% Jablonowski (2015). This program sets the temperature variable from the
% eta coordinate and phi' coordinate

function [T, T_avg, theta] = set_temperature(x, y, eta, phi_prime)
lapse_rate = 0.005; % K / m
%lapse_rate = 0; %isothermal
T0 = 288; %K
kappa = 0.286;
b = 2; %dimensionless vertical width paramter
Rd = 287; % J / kg / K


T_avg = T0*eta.^(Rd*lapse_rate/9.8);
T = T_avg + phi_prime./Rd .* ( 2/b^2 .* (log(eta).^2) - 1) .* ( exp(-(log(eta)/b).^2) );
theta = T.* (1./(eta)).^kappa;
end
