%interpolates the modes from length n-2 to length n-1 vectors where n is
%the number of vertical staggered levels

function interpMode = interpolate_modes(mode)
    interpMode = zeros(size(mode,1)+1, size(mode,2));
    interpMode(1,:) = 0.5*mode(1,:);
    for nn=2:size(mode,1)
       interpMode(nn,:) = 0.5 * (mode(nn-1,:) + mode(nn,:));
    end
    interpMode(end,:) = 0.5*mode(end,:);
end