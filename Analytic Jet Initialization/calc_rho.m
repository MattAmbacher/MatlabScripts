%calc_rho.m
% Create jet for bwave with same analytic ICs as Ullrich, Reed, and
% Jablonowski (2015). This program calculates the density from the ideal
% gas law

function rho = calc_rho(eta, T, Ps)
Rd = 287; % J / Kg/ K
P = eta*Ps;
rho = P./(Rd*T).*100; %100 is conversion factor to kg/m^3
end
