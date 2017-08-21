%helmholtz decomposition
%uses 2D FFT to break up (u,v) into curl and divergence

function [KE, u_helm, v_helm] = helm_decomp(u,v,dx,dy)
[u,v] = unstagger(u,v);
U = fft2(u);
V = fft2(v);

N = size(u,2);
M = size(u,1);

ax = 0;
bx = N*dx;

ay = 0;
by = M*dy;

k = 2*pi/(bx - ax) * [0:N/2-1 0 -N/2+1:-1];
l = 2*pi/(by - ay) * [0:M/2-1 0 -M/2+1:-1]';

V_x = zeros(M,N);
V_y = zeros(M,N);
U_x = zeros(M,N);
U_y = zeros(M,N);

for mm=1:M
    V_x(mm,:) = (1i*k.*V(mm,:));
    U_x(mm,:) = (1i*k.*U(mm,:));
end

for nn=1:N
    V_y(:,nn) = (1i*l.*V(:,nn));
    U_y(:,nn) = (1i*l.*U(:,nn));
end

zeta2 = (abs(V_x - U_y)).^2;
delta2 = (abs(U_x + V_y)).^2;

KE = 0;

for kk=1:length(k)
    for ll=1:length(l)
        if k(kk) ~= 0 || l(ll)~=0
            KE = KE + (zeta2(ll,kk) + delta2(ll,kk))/(k(kk).^2 + l(ll).^2);
        end
    end
end
KE = KE/(M*N);
end
