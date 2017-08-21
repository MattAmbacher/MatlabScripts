ps = 1.0134e5;

K = 100;
p = linspace(0, ps*1.0, K+1);
p = p';

phalf = 0.5* (p(1:end-1) + p(2:end));

dp = zeros(size(p));
dp(1) = 2*phalf(1);
dp(2:end-1) = phalf(2:end) - phalf(1:end-1);
dp(end) = 2*(ps-phalf(end));

p = p(2:end);
%Constants
R = 287;
g = 9.81;
lapse = 0.005;
kappa = R/1004.5;
TH = 288;

%variables

T = TH * (p/ps).^(R*lapse/g);
Gamma = R*T./(p.^2) * (kappa - R*lapse/g);

H00 = 1;
%Beta = g*H00./(R*Gamma);
Beta = 1./Gamma;

ahat = ps*Gamma(end)/(R*T(end));

%C = Beta(1:end-1)./dp(2:end-1);
%C = [C; Beta(end)/( 1 + 0.5*ahat*dp(end))];
C = Beta(1:end)./dp(2:end);
d = sqrt(0.5*(dp(1:end-1) + dp(2:end)));
%Assemble matrix M

M = zeros(K,K);

for j=2:K-1
   M(j,j) = (C(j-1) + C(j))/(d(j)^2);
   M(j,j-1) = -C(j-1)/(d(j-1)*d(j));
   M(j,j+1) = -C(j)/(d(j)*d(j+1));
end

%First row
M(1,1) = C(1)/d(1)^2;
M(1,2) = -C(1)/(d(1)*d(2));

%Last row
M(end,end-1) = -C(end-1)/(d(end-1)*d(end));
%M(end,end) = (C(end-1) + C(end))/(d(end)^2);
M(end,end) = ( (ahat*dp(end))/(1 + 0.5*ahat*dp(end)) * C(end) + C(end-1))/(d(end)^2);

[Vec, lam] = eig(M);

lam = diag(lam); [foo,ii] = sort(lam); 
lam = lam(ii); Vec = Vec(:,ii);

num_modes = 31;
modes = Vec(:,1:num_modes);
scale = 100;
modes = sqrt(scale) * modes;
