Gamma = 0.005;
T0 = 288;

R = 287;
g = 9.80616;
cs2 = 340;

cp = 1004.5;
kappa = R/cp;

mu = R*Gamma/g;

dz = 600;
ztop = 30000;

z = dz:dz:ztop-dz;
z = z';
dx = 20000;
dy = dx;
f = 2*7.292e-5*sin(pi/4);

Na2 = -g*Gamma/T0 * ( 1 - kappa/mu) * (1 - Gamma*z/T0).^(-kappa/mu);
Nb2_over_g = Gamma/T0 * ( 1/mu - 1) * ( 1 - Gamma*z/T0).^(-1);
second_rho_deriv = Gamma/T0 * Gamma/T0 * (1 - Gamma*z/T0).^(-2) * ( 1 - 1/mu) * ( 1/mu - 2);

%Construct FD matrices
d2dz2 = diag(  -2*ones(length(z),1));

for nn=2:length(z)-1
	d2dz2(nn,nn+1) = 1;
end

for nn=2:length(z)
	d2dz2(nn, nn-1)  = 1;
end

ddz = zeros(length(z));

for nn= 2:length(z)-1
	ddz(nn,nn+1) = 1;
	ddz(nn,nn-1) = -1;
end

d2dz2 = 1/dz^2 * d2dz2;
ddz = 0.5/dz * ddz;

dNbdz_over_g = Gamma^2/T0^2 * ( 1/mu - 1) * (1 - Gamma*z/T0).^(-2);

k = 0;
l = 1;
K2 = k^2 + l^2


%Anelastic
A = d2dz2 - 0.5 * ( diag(dNbdz_over_g + 0.5*Nb2_over_g.^2) );
B = f^2 * d2dz2 - f^2/2 * ( diag(dNbdz_over_g + 0.5*Nb2_over_g.^2 - K2*Na2) );

%Compressible, Hydrostatic
%A = d2dz2 - 1/g*(Nb2  + g^2/cs2) * ddz;
%B = f^2*d2dz2 - f^2/g^2*(Nb2 + g^2/cs2)*ddz - K2;

[V,D] = eig(A,B);
