function [delta, zeta] = helm(U, V)    
%input: U and V fields from read_single_jet() output
%output: horizontal divergence and vorticity
%first dimension is x, second dimension is y

    % fftshift puts (kx, ky) = (0, 0) in the middle of the matrix rather
    % than top left corner
    nx = size(U,1);
    ny = size(U,2);
    
    Uhat = fftshift(fft2(U))/sqrt(nx*ny); 
    Vhat = fftshift(fft2(V))/sqrt(nx*ny);
    

    Lx = nx*5000;
    Ly = ny*5000;
    delta = zeros(nx,ny);
    zeta = zeros(nx,ny);
    
    kvec = -nx/2:nx/2-1; %make list of kx from [-nx/2, -nx/2 + 1, ... , nx/2-1]
    lvec = -ny/2:ny/2-1; %make list of ky from [-(2*ny)/2, -(2*ny)/2 + 1, ... , (2*ny)/2-1]
    
    for ll = 1:length(lvec);
        ky = lvec(ll) * nx/ny;
        for kk = 1:length(kvec);
            kx = kvec(kk);
            k_dim = 2*pi/Lx * kx; l_dim = 2*pi/Lx * ky; %dimensional k and l
            %1j is imaginary unit in Matlab
            delta(kk,ll) = 1j* k_dim * Uhat(kk,ll) + 1j* l_dim * Vhat(kk,ll);
            zeta(kk,ll) = 1j* k_dim * Vhat(kk,ll) - 1j* l_dim * Uhat(kk,ll);
        end
    end
end
