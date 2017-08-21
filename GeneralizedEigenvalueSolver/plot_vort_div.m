Uhat = fftshift(fft2(U(:,:,75)));
Vhat = fftshift(fft2(V(:,:,75)));

nx = size(U,1); ny = size(U,2); dx = 5000;
Lx = dx*nx;

k = -nx/2:nx/2-1; l = -ny/2:ny/2-1;
div = zeros(size(Uhat));
vort = zeros(size(Uhat));

for ll=1:length(l)
    ky = 2*pi/Lx * nx/ny* l(ll);
    for kk=1:length(k)
        kx = 2*pi/Lx * k(kk);
        vort(kk,ll) = 1j * kx * Vhat(kk,ll) - 1j * ky * Uhat(kk,ll);
        div(kk,ll) = 1j * kx * Uhat(kk,ll) + 1j * ky * Vhat(kk,ll);
    end
end

div = real(ifft2(fftshift(div)));
vort = real(ifft2(fftshift(vort)));
        
        