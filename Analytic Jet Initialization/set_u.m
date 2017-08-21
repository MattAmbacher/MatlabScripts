%set_u.m
% Create jet for bwave with same analytic ICs as Ullrich, Reed, and
% Jablonowski (2015). This program sets the background zonal wind from the
% eta coordinate and phi' coordinate

function u = set_u(x,y,eta, Ly);
%u0 = 55; % m / s
u0 = 35;
b = 2; %dimensionless vertical width parameter
u = zeros(length(y),1);
for jj=1:length(y)
%u(jj) = -u0 * sin(pi*y(jj)/Ly)^2 * log(eta(jj)) .* eta(jj).^( -log(eta(jj))./b^2);
u(jj) = -u0 * sin(pi*y(jj)/Ly)^2 * log(eta) .* eta.^( -log(eta)./b^2);
if y(jj) < 0
    u(jj) = -u(jj);
end

end
