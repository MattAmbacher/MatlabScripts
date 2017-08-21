function [dke, rke, pe] = spec2d(delta, zeta, nx, ny, dx)
    Lx = dx*nx;
    
    dke = zeros(nx+ny,1); % throwing away after nx/2 so doesn't matter how big we make dimension 1
    rke = zeros(nx+ny,1); % throwing away after nx/2 so doesn't matter how big we make dimension 1
    pe = zeros(nx+ny,1);
    
    kvec = -nx/2:nx/2-1; % make list of kx from [-nx/2, -nx/2 + 1, ... , nx/2-1]
    lvec = -ny/2:ny/2-1; % make list of ky from [-(2*ny)/2, -(2*ny)/2 + 1, ... , (2*ny)/2-1]
    for ll = 1:length(lvec)
        ky = lvec(ll) * nx/(ny); %non-dimensional k_y, scaled
        for kk = 1:length(kvec)
            kx = kvec(kk); %non-dimensional k_x
            kh = round(sqrt(kx^2 + ky^2));
            if kh ~= 0
                if kh ==0
                   sprintf('spec2d kh = 0. kx = %d, ky = %d', kx, ky)
                end
                kh2 = (2*pi/Lx)^2 * (kx^2 + ky^2); %dimensional k_h^2
                dke(kh) = dke(kh) + 1/(2*kh2) * abs(delta(kk,ll))^2;
                rke(kh) = rke(kh) + 1/(2*kh2) * abs(zeta(kk,ll))^2;
                %pe(kh) = pe(kh) + 1/(9.81*H) * abs(PHhat(kk,ll))^2;
            end
        end
    end
    
    dke = dke(1:nx/2); %throw away wavenumbers where the circle becomes larger than the rectangular domain
    rke = rke(1:nx/2); %throw away wavenumbers where the circle becomes larger than the rectangular domain
    pe = pe(1:nx/2);
end