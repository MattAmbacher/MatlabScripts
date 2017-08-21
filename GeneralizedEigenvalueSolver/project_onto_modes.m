% project_onto_modes.m
% Script to project WRF output onto vertical modes.
% -------------------------------------------------------------------------
% let v be the basis for the normal modes and let f be the WRF output
% The projection of f onto v is given by:
%
% proj_v f = <v_i,f>/ <v_i, v_i> \vec{v_i}
%
% where <f,g> is the standard inner product given by
%
% int_a^b w(z) fg dz
%
% -------------------------------------------------------------------------

%Name format for modes is mode$K^2
vert_mode = [1,2,3,4,5];
horiz_mode = [0,1,4,9,16,25];

for ii = 1:length(horiz_mode)
    for jj=1:length(horiz_mode)
        if horiz_mode(ii) + horiz_mode(jj) ~= 0 && horiz_mode(ii) + horiz_mode(jj) < 30
            fname = ['mode', num2str(horiz_mode(ii) + horiz_mode(jj)), '.mat'];
            if exist(fname, 'file') == 2
                load(fname);
            end
        end
    end
end
U = ncread('wrfout_d01_0001-01-11_00:00:00', 'U');
V = ncread('wrfout_d01_0001-01-11_00:00:00', 'V');
ph = ncread('wrfout_d01_0001-01-11_00:00:00', 'PH');
phb = ncread('wrfout_d01_0001-01-11_00:00:00', 'PHB');
PHI = ph + phb;

U = squeeze(U(:,:,:,1));
V = squeeze(V(:,:,:,1));
PHI = squeeze(PHI(:,:,:,1));


mode2 = interpolate_modes(mode2);
[U,V,PHI] = interpolate_fields(U,V,PHI);

[Ubar, Vbar, PHIbar] = vert_projection(U,V,PHI,mode2(:,1), 600);

%u_spectrum = zeros(25);
        %[U_final, V_final, ETA_final] = horiz_projection(Ubar, Vbar, PHIbar, 10000e3, 10000e3, 20e3, 20e3, k, l);
        Uhat = fft2(squeeze(U(:,:,27)));
        u_spectrum = abs(Uhat(1:25,1:25));
        