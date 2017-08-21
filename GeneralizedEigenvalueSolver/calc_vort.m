function [vorticity, Uy, Vx] = calc_vort(U, V, level)
	%Takes in horizontal velocities U and V and calculates the 2D horizontal vorticity 
	nx = size(U,1); ny = size(U,2);
    
	Uhat = fftshift(fft2(U(:,:,level)));
	Vhat = fftshift(fft2(V(:,:,level)));

	Lx = nx*5000;
	Ly = ny*5000;
	
	kvec = -nx/2:nx/2-1;
	lvec = -ny/2:ny/2-1;

	vorticity = zeros(size(U,1), size(U,2));
    Vx = zeros(size(vorticity));
    Uy = zeros(size(vorticity));
	for ll = 1:length(lvec);
		ky = lvec(ll);
		for kk = 1:length(kvec);
			kx = kvec(kk);
			k_dim = 2*pi/Lx*kx; l_dim = 2*pi/Ly*ky;
            Uy = 1j * l_dim * Uhat(kk,ll);
            Vx = 1j * k_dim * Vhat(kk,ll);
            vorticity(kk,ll) = Vx - Uy;
		end
    end
    vorticity = real(ifft2(fftshift(vorticity)));
    Uy = real(ifft2(fftshift(Uy)));
	Vx = real(ifft2(fftshift(Vx)));
end
