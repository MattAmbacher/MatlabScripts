%test if the anelastic approximations are ok to use with our WRF
%simulations
dx = 15000;
[u,v,w] = unstagger(U, V, W);
rho_bar = get_background(rho);
mass_cont = zeros(size(w,3),1);
theta_check = zeros(size(w,3),1);

ru = zeros(size(u));
rv = zeros(size(v));
rw = zeros(size(w));
for nn=1:length(rho_bar)
    ru(:,:,nn) = rho_bar(nn) .* u(:,:,nn);
    rv(:,:,nn) = rho_bar(nn) .* v(:,:,nn);
    rw(:,:,nn) = rho_bar(nn) .* w(:,:,nn);
end

d_ru_dx = FD6(ru,1,15000);
d_rv_dy = FD6(rv,2,15000);
d_rw_dz = FD4(rw,600);

for nn=1:length(rho_bar)
   mass_cont(nn) = mean(mean( d_ru_dx(:,:,nn) + d_rv_dy(:,:,nn) + d_rw_dz(:,:,nn) )); 
end

theta_bar = get_background(Theta);
for nn=1:length(theta_check)
   theta_check(nn) = mean(mean(Theta(:,:,nn) - theta_bar(nn)))/theta_bar(nn); 
end