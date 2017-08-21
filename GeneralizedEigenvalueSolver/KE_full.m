function KE = KE_full(U,V, sigma, scale)
    nx = size(U,1); ny = size(U,2);
    KE_per_level = zeros(nx + ny, size(U,3));
    k_vec = -nx/2:nx/2-1; l_vec = -ny/2:ny/2-1;

    for nn = 1:size(U,3)
        Uhat = fftshift(fft2(U(:,:,nn)))/sqrt(size(U,1) * size(U,2));
        Vhat = fftshift(fft2(V(:,:,nn)))/sqrt(size(V,1) * size(V,2));
        for ll=1:length(l_vec)
            ky = l_vec(ll);
            ky = nx/(ny) * ky; %scale ky
            for kk=1:length(k_vec)
               kx = k_vec(kk);
                i = round(sqrt(kx^2 + ky^2));
               if i ~= 0
                        %i = round(sqrt(kx^2 + ky^2) + 0.5);
                        KE_per_level(i,nn) = KE_per_level(i,nn) + 0.5* ( abs(Uhat(kk,ll))^2 + abs(Vhat(kk,ll))^2 );
                        %PE_KH_bins(i) = PE_KH_bins(i) + 1/2*( abs(PHIhat(kk,ll))^2 );
               end
            end
        end
    end
    
    KE = zeros(nx/2,1);
    dp = diff(sigma)*scale;
    
    for kk=1:nx/2
       KE(kk) = 1/(2*scale) * sum((KE_per_level(kk,2:end) + KE_per_level(kk, 1:end-1)) .* dp');
    end
    
end