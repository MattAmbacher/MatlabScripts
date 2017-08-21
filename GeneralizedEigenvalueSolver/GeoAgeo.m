% computes energy in mode n for both ageostrophic and geostrophic modes
function [Geostrophic_energy, Ageostrophic_energy] = GeoAgeo(Uhat,Vhat,PHI, k_vec, l_vec, lambda, nx, ny)
ghn = 1/(abs(lambda));
cn = sqrt(ghn);
disp(['cn in GeoAGeo is: ', num2str(cn)]);
ETAhat = PHI/cn;
cn2 = ghn;
Omega =7.292e-5;
f0 = 2*Omega*sin(pi/4);
Lx = nx*5000;

Geostrophic_energy = zeros(nx+ny,1);
Ageostrophic_energy = zeros(size(Geostrophic_energy));

for ll=1:length(l_vec)
    ky_nondim_scaled = nx/(ny) * l_vec(ll);
    %ky_nondim_scaled = l_vec(ll);
    ky = 2*pi/Lx * ky_nondim_scaled;
    for kk=1:length(k_vec)
        kx_nondim = k_vec(kk); 
        kx = 2*pi/Lx * kx_nondim;
        i = round(sqrt(kx_nondim^2 + ky_nondim_scaled^2));
        if i ~= 0 
            K2 = (kx^2 + ky^2);
            K = sqrt(K2);
            %i = round(sqrt(kx_nondim^2 + ky_nondim_scaled^2) + 0.5);
            if i ==0
                sprintf('GeoAgeo i = 0. kx = %d, ky = %d', kx, ky)
            end
            %Eigenvectors for Geostrophic (E0) and Ageostrophic (Ep and Em) motion
            E0 = 1/(sqrt(cn2*K2 + f0^2)) * [-1j*cn*ky;...
                                            1j*cn*kx;...
                                            f0];
            Ep = 1/(sqrt(2)*K * sqrt(cn2*K2 + f0^2)) *[1j*f0*ky + kx*sqrt(cn2*K2 + f0^2); ...
                                                       -1j*f0*kx + ky*sqrt(cn2*K2 + f0^2);...
                                                       cn*K2];

            Em = 1/(sqrt(2)*K * sqrt(cn2*K2 + f0^2)) *[1j*f0*ky - kx*sqrt(cn2*K2 + f0^2); ...
                                                       -1j*f0*kx - ky*sqrt(cn2*K2 + f0^2);...
                                                       cn*K2]; 
            %A0 = E0'*[Uhat(kk,ll); Vhat(kk,ll); ETAhat(kk,ll)];
            %Ap =  Ep'*[Uhat(kk,ll); Vhat(kk,ll); ETAhat(kk,ll)];
            %Am = Em'*[Uhat(kk,ll); Vhat(kk,ll); ETAhat(kk,ll)];
            A0 = (1j*cn*ky*Uhat(kk,ll) - 1j*cn*kx*Vhat(kk,ll) + f0*ETAhat(kk,ll))/sqrt(cn2*K2 + f0^2);
            Ap = (Uhat(kk,ll) * (-1j*f0*ky + kx*sqrt(cn2*K2 + f0^2)) + Vhat(kk,ll)*(1j*f0*kx + ky*sqrt(cn2*K2 + f0^2)) + cn*K2*ETAhat(kk,ll))/...
                (sqrt(2)*K*sqrt(cn2*K2+f0^2));
            Am = (Uhat(kk,ll) * (-1j*f0*ky - kx*sqrt(cn2*K2 + f0^2)) + Vhat(kk,ll)*(1j*f0*kx - ky*sqrt(cn2*K2 + f0^2)) + cn*K2*ETAhat(kk,ll))/...
                (sqrt(2)*K*sqrt(cn2*K2+f0^2));
            Geostrophic_energy(i) = Geostrophic_energy(i) + 1/2*norm(A0)^2;
            Ageostrophic_energy(i) = Ageostrophic_energy(i) + 1/2*(norm(Am)^2 + norm(Ap)^2);

        end
 
    end
end

end
