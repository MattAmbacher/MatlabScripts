%Calculate helmholtz decomposition for each vertical mode or for total
%field

function[delta, zeta] = rotdiv(U,V, nx, ny, Lx)
    k_vec = (-nx/2):(nx/2-1);
    l_vec = (-ny/2):(ny/2-1);
    
    delta = zeros(size(U));
    zeta = zeros(size(U));
    Uhat = zeros(size(U)); Vhat = zeros(size(V));
    
    for nn=1:size(U,3)
       Uhat(:,:,nn) = fftshift(fft2(U(:,:,nn)))/sqrt(size(U,1)*size(U,2));
       Vhat(:,:,nn) = fftshift(fft2(V(:,:,nn)))/sqrt(size(V,1)*size(V,2));
       for ll=1:length(l_vec)
           ky = 2*pi/Lx * nx/ny*l_vec(ll);
           for kk=1:length(k_vec)
               kx = 2*pi/Lx * k_vec(kk);
                delta(kk,ll, nn) = (1j*kx*Uhat(kk,ll,nn) + 1j*ky*Vhat(kk,ll,nn));
                zeta(kk,ll, nn) = (1j*kx*Vhat(kk,ll,nn) - 1j*ky*Uhat(kk,ll,nn));
           end
       end
    end
end