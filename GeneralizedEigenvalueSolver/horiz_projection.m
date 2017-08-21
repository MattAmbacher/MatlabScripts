function [Uhat, Vhat, What] = horiz_projection(U,V,W)
Uhat = fftshift(fft2(squeeze(U)))/sqrt(size(U,1) * size(U,2));
Vhat = fftshift(fft2(squeeze(V)))/sqrt(size(U,1) * size(U,2));
What = fftshift(fft2(squeeze(W)))/sqrt(size(U,1) * size(U,2));
end
 