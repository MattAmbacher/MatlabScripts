

sigma = linspace(0, 1.0, 102);
sigma = sigma(2:end-1);
sigma = sigma';
K = length(sigma);

ds = zeros(size(sigma));
ds(1) = sigma(1);
ds(2:end) = sigma(2:end) - sigma(1:end-1);
ds = [ds; (1 - sigma(end))];

%Constants
R = 287;
g = 9.81;
lapse = 0.005;
kappa = R/1004.5;
TH = 288;

%variables

T = TH * sigma.^(R*lapse/g);
Gamma = T./sigma * (kappa - R*lapse/g);

H00 = 1;
Beta = g*H00./(R*Gamma);


ahat = Gamma(end)/T(end);

C = 1/2 * ((sigma(1:end-1).*Beta(1:end-1)) + (sigma(2:end).*Beta(2:end)))./ds(2:end-1);
C = [C; g*H00/(R*T(end) * ( 1 + 1/2*ahat*ds(end)))];

d = sqrt(1/2*(ds(1:end-1) + ds(2:end)));

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
M(end,end) = (C(end-1) + C(end))/(d(end)^2);

[Vec, lam] = eig(M);

lam = diag(lam); [foo,ii] = sort(lam); 
lam = lam(ii); Vec = Vec(:,ii);

num_modes = 30;
modes = Vec(:,1:num_modes);
scale = 102160;
dp = (sigma(2)-sigma(1))*scale
modes = sqrt(scale/dp(1)) * modes;