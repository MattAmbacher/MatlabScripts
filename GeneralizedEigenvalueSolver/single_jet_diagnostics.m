%decompose single jet

%first we have to extend the jet in the meridional direction according to
%appropriate BCs. Then we DFT when it's periodic. This is assuming that the given jet
%is periodic in the zonal direction initially, so that no extension is
%needed.

function [div_energy, rot_energy] = single_jet_diagnostics(Ubar, Vbar, PHIbar)
    % This processes the data read in from read_single_jet()
    % Ubar, Vbar, PHIbar are time averaged, vertical averaged data
    
    [delta, zeta] = helm(Ubar, Vbar);
    [div_energy, rot_energy] = spec2d(delta, zeta);
    nx = size(Ubar,1);
    ny = size(Ubar,2)/2;
    div_energy = 1/(nx* 2*ny) * div_energy;
    rot_energy = 1/(nx* 2*ny) * rot_energy;
end
