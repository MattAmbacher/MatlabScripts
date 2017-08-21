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


%%% Toggle for Isothermal case to compare to Daley
%T0 = 250;
%lapse = 0;
%ps = 1013*100;
%pt = 4.3*100;

% Cheb setup
Lz = (ps - pt);
N = 102;
[D,Pcheb] = cheb(N-1);
D2 = D^2;

Pcheb = Lz/2 *(Pcheb+1) + pt; D = 2/Lz*D; D2 = (2/Lz)^2*D2;
%Set up 
T = T0*(Pcheb /ps).^(R*lapse/g);
Gamma = R*T./Pcheb.^2 * (kappa - R*lapse/g);
dGamma = R*T./Pcheb.^3 * (kappa - R*lapse/g) * (R*lapse/g - 2);

%BCs
A = diag(1./Gamma) * D2 - diag(1./Gamma.^2)*diag(dGamma) * D;
E = A(2:end-1,2:end-1);
E0 = A(2:end-1,1);
En = A(2:end-1,end);
beta = -Pcheb(end)*Gamma(end)/(R*T(end)); %right BC corresponds to x = -1 ( P top)
alpha = -Pcheb(1)*Gamma(1)/(R*T(1)); %left BC corresponds to x = +1 (P surface)

B0 = D(1,2:end-1);
BN = D(end,2:end-1);

L = [(D(1,1) - alpha) D(1,end); D(end,1) (D(end,end) - beta)];
pn = -inv(L) * [B0; BN];

%B = R*kappa*T0*eye(size(E));

[Vec,Lam] = eig(E + [E0 En]*pn);


lam = diag(Lam); [foo,ii] = sort(-lam); 
lam = lam(ii); Vec = Vec(:,ii);

num_modes = 30;
modes = Vec(:,1:num_modes);
