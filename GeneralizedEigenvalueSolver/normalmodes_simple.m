%------------------------------
% constants 
%------------------------------
g = 9.81;
R = 287;
T0 = 288;
cp = 1004.5;
kappa = R/cp;
lapse = 0.005;

ps = max(P_HYD);
pt = min(P_HYD);
%ps = 1013*100;
%pt = 4.3*100;
zt = 40000;
%-------------------------------
% Set up the Analytic solution for the isothermal case
%-------------------------------
z = linspace(0, zt, 2000);
p = ps * exp(-g*z/(R*T0) );
dp = diff(p);
%p = p(2:end-1);
k = 1;
F1 = exp(g*z/(2*R*T0)) .* (cos(k*pi*z/zt) + g*zt/(R*T0*k*pi) * (kappa - 1/2) * sin(k*pi*z/zt));
k = 2;
F2 = exp(g*z/(2*R*T0)) .* (cos(k*pi*z/zt) + g*zt/(R*T0*k*pi) * (kappa - 1/2) * sin(k*pi*z/zt));
k = 3;
F3 = exp(g*z/(2*R*T0)) .* (cos(k*pi*z/zt) + g*zt/(R*T0*k*pi) * (kappa - 1/2) * sin(k*pi*z/zt));

% Numerical Solver
%-------------------------------
% k=1 corresponds to Ptop, k = K+1 corresponds to Psurface
P = linspace(pt, ps, 2000); 
DP = P(2) - P(1);
K = length(P) - 1;

T = T0*(P /ps).^(R*lapse/g);
TGamma = T0* ( (P + DP/2)/ps).^(R*lapse/g);
Gamma = R*TGamma*kappa ./ (P + DP/2).^2 * (kappa - R*lapse/g);

%Build the matrix for Z = (Z_1, Z_2, ... , Z_K, Z_S)^T, then discard first
%and last row and column to solve for (A - lambda * I) (Z_2, ..., Z_K)^T
A = zeros(K+1);
for k=3:K-1
   A(k,k-1) = 1/Gamma(k-1);
   A(k,k) = -1/Gamma(k) - 1/Gamma(k-1);
   A(k,k+1) = 1/Gamma(k);
end
%k = 2 row
%-----------
%This next line is for p_top = 0, uncomment to follow the exercise exactly;
A(2,2) = -1/Gamma(2);

%This next line is for p_top != 0, to compare to the analytic
%isothermal case, comment to follow exercise 
A(2,2) = -1/Gamma(2) -1/Gamma(1)*(1 - 1/(1 - DP*P(1)*Gamma(1)/(R*T(1))));

%This next line is the same 
A(2,3) = 1/Gamma(2);

%-----------
%k = K row
A(K,K) = 1/Gamma(K) * (1/(1 + ((DP *ps * Gamma(K))/(R*T(K))) ) ) - 1/Gamma(K) - 1/Gamma(K-1);
A(K,K-1) = 1/Gamma(K-1);

%Throw out first and last row and column
A = A(2:end-1, 2:end-1);
A = A/(DP.*DP);

%------------------------------

%Solve the eigenvalue problem and sort the eigenvalues
[Vec,Lam] = eig(A); lam = diag(Lam);
[foo, ii] = sort(-lam);
lam = -lam(ii); Vec = Vec(:,ii);

%ensure eigenvectors have correct orientation because matlab sometimes
%plots e.g. mode1 as -1*mode1
if (Vec(1,2) > 0)
    Vec(:,2) = -Vec(:,2);
end
if (Vec(1,3)  < 0)
    Vec(:,3) = - Vec(:,3);
end
if Vec(1,4) > 0
    Vec(:,4) = -Vec(:,4);
end

num_modes = 10;
modes = Vec(:,2:num_modes+1);
