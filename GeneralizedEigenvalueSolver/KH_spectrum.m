function [varargout] = KH_spectrum(varargin)
    if nargin == 7
        Uhat = varargin{1}; Vhat = varargin{2}; PHIhat = varargin{3};
        k = varargin{4}; l = varargin{5}; nx = varargin{6}; ny = varargin{7};

        KE_KH_bins = zeros(ny+nx,1);
        PE_KH_bins = zeros(size(KE_KH_bins));
        %l = nx/(2*ny) * l;
        %[kx, ky] = meshgrid(k, l);
       % KE = 1/2 * (Uhat*conj(Uhat) + Vhat*conj(Vhat));
        %PE = 1/2 * (PHIhat*conj(PHIhat));
        for ll=1:length(l)
            ky = l(ll);
            ky = nx/(ny) * ky; %scale ky
            for kk=1:length(k)
               kx = k(kk);
               i = round(sqrt(kx^2 + ky^2));
               if i ~= 0
                        %i = round(sqrt(kx^2 + ky^2) + 0.5);
                        %disp(i)
                        KE_KH_bins(i) = KE_KH_bins(i) + 0.5* ( abs(Uhat(kk,ll))^2 + abs(Vhat(kk,ll))^2 );
                        PE_KH_bins(i) = PE_KH_bins(i) + 1/2*( abs(PHIhat(kk,ll))^2 );
               end
            end
        end
        E_bins = KE_KH_bins + PE_KH_bins;
        
        varargout{1} = E_bins;
        varargout{2} = KE_KH_bins;
        varargout{3} = PE_KH_bins;
        
    elseif nargin ==1
        Uhat = varargin{1};
        ny = size(Uhat,2);
        nx = size(Uhat,1);

        k = -ny/2:(ny/2-1);
        l = -nx/2:(nx/2-1);
        KE_KH_bins = zeros(round(sqrt(max(abs(k))^2 + max(abs(l))^2)) + 1,1);
        for kk=1:length(k)
            for ll=1:length(l)
               kx = k(kk);
               ky = l(ll);
               i = round(sqrt(kx^2 + ky^2)) + 1;
               KE_KH_bins(i) = KE_KH_bins(i) + 0.5/(kx^2 +ky^2) * ( norm(Uhat(kk,ll))^2 );
            end
        end
        varargout{1} = KE_KH_bins;

    elseif nargin == 4 %curl and divergence
        delta = varargin{1}; zeta = varargin{2};
        Lx = varargin{3}; Ly = varargin{4};
        ny = (size(delta,2))/2;
        nx = size(delta,1);
    
        num_modes = size(delta,3);
        %div_bins = zeros(round(sqrt(max(k.^2) + max((Lx/Ly)^2*l.^2)))+1,num_modes);
        %rot_bins = zeros(round(sqrt(max(k.^2) + max((Lx/Ly)^2*l.^2)))+1,num_modes);
%         for modes=1:num_modes %num_modes = 1 if not given vertical projection
%             for ll=1:length(k)
%                 for ll=1:length(l)
%                     k_ind = k(kk); l_ind = l(ll); Kh2 = (2*pi/Lx)^2*k_ind^2 + (2*pi/Ly)^2*(l_ind/2)^2;
%                     if Kh2 ~= 0
%                         i = round(sqrt(k_ind^2 + (Lx/Ly)^2*(l_ind/2)^2)) + 1; %MATLAB indices start at 1, so have to add +1
%                         div_bins(i,modes) = div_bins(i,modes) + 1/(2*Kh2) * norm(delta(kk,ll,modes))^2;
%                         rot_bins(i,modes) = rot_bins(i,modes)  + 1/(2*Kh2) * norm(zeta(kk,ll,modes))^2;
%                             
%                     end
%                 end
%             end
%         end
        div_bins = zeros(round(sqrt(2*(nx/2)^2))+1, num_modes); 
        rot_bins = zeros(round(sqrt(2*(nx/2)^2))+1, num_modes); 
        k_vec = -nx/2:nx/2-1;
        l_vec = -ny:ny-1;
        for modes=1:num_modes %num_modes = 1 if not given vertical projection
            for jj = 1:length(l_vec);
                %scale ky
                ky = nx/(2*ny) * l_vec(jj);
                for ii = 1:length(k_vec)
                    kx = k_vec(ii);
                    kh = floor(sqrt(kx^2 + ky^2) + 0.5);
                    if (kh ~= 0)
                        Kh2 = (2*pi/Lx)^2 * (kx^2 + ky^2);
                        div_bins(kh,modes) = div_bins(kh,modes) + 1/(2*Kh2) * norm(delta(ii,jj,modes))^2;
                        rot_bins(kh,modes) = rot_bins(kh,modes)  + 1/(2*Kh2) * norm(zeta(ii,jj,modes))^2;
                    end
                end
            end
        end
        div_bins = div_bins(1:nx/2, :);
        rot_bins = rot_bins(1:nx/2, :);
        varargout{1} = div_bins;
        varargout{2} = rot_bins;
    end
end
