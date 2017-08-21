u = squeeze(u(1,:,:));
u = u(:);

rho = squeeze(rho(1,:,:));
rho = rho(:);

T = squeeze(T(1,:,:));
T = T(:);

save u.txt u -ASCII
save rho.txt rho -ASCII
save T.txt T -ASCII
