 Lx = 2500e3; dx = 5000;
Lz = 30e3;
x = 0:dx:Lx-dx;
y = x;

P = P_HYD;

scale = 1.0216e5;

testU = zeros(length(x), length(y), length(P));
testV = zeros(length(x), length(y), length(P));

 interp_mode_1 = interp1(sigma*scale, modes(:,1), flipud(P_HYD), 'spline');
 interp_mode_3 = interp1(sigma*scale, modes(:,3), flipud(P_HYD), 'spline');
% 
 for nn=1:size(testU,3)
     for yy=1:size(testU,2)
        %testU(:,yy,nn) = 35*sin(2*pi/Lx * x) * (interp_mode_1(nn) + interp_mode_3(nn));
        testU(:,yy,nn) = 35*sin(2*pi/Lx * x) * (modes(nn,1) + modes(nn,3));

    end
end
% 
 nx = size(testU,1); ny = size(testU,2);
% [delta, zeta] = rotdiv(testU, testV, nx, ny, Lx);
% 
testUhat = zeros(size(testU));
testVhat = zeros(size(testV));


 for nn=1:size(testU,3)
%    [divE(:,nn), rotE(:,nn), potE(:,nn)] = spec2d(delta(:,:,nn), zeta(:,:,nn), zeros(size(U)), nx, ny, dx, Lz);
     testUhat(:,:,nn) = fftshift(fft2(testU(:,:,nn)))/sqrt(size(testU,1)*size(testU,2));
 end
% 
 %rke = zeros(nx/2,1);
 %dke = zeros(size(rke));
 KE_full = zeros(nx+ny,size(testU,3));
% 
k_vec = -nx/2:nx/2-1; l_vec = -ny/2:ny/2-1;
for nn=1:size(testU,3)
    for ll=1:length(l_vec)
        ky = l_vec(ll);
        ky = nx/(ny) * ky; %scale ky
        for kk=1:length(k_vec)
           kx = k_vec(kk);

           if kx^2 + ky^2 ~= 0
                    i = round(sqrt(kx^2 + ky^2));
                    KE_full(i,nn) = KE_full(i,nn) + 0.5* ( abs(testUhat(kk,ll,nn))^2 + abs(testVhat(kk,ll,nn))^2 );
                    %PE_KH_bins(i) = PE_KH_bins(i) + 1/2*( abs(PHIhat(kk,ll))^2 );
           end
        end
    end
end

KE = zeros(nx/2,1);
dp = diff(sigma)*scale;
for kk=1:nx/2;
    KE(kk) = 1/(2*scale) * sum ( (KE_full(kk,2:end) + KE_full(kk, 1:end-1)) .* dp');
    %KE = dp(1)* sum(KE_full,2);
end
%
 %KE = rke + dke;
% 
[Uhat, Vhat, PHIhat] = project_fields(testU,testV,zeros(size(testU)), flipud(P_HYD), modes, num_modes, sigma);
clear KE_modes;
for nn=1:num_modes
        cn = sqrt(g/lam(nn))
        [E_modes(:,nn), KE_modes(:,nn), PE_modes(:,nn)] = KH_spectrum(Uhat(:,:,nn), Vhat(:,:,nn), PHIhat(:,:,nn)/cn, k_vec, l_vec, nx, ny);
        %% 
end

KE_modes = KE_modes(1:nx/2, :);