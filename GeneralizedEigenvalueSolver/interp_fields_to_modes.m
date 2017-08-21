function [Uinterp, Vinterp, PHIinterp, P_actual] = interp_fields_to_modes(U,V,PHI, P_HYD, sigma, scale)

%P_actual = P_HYD/scale;
P_actual = P_HYD;

Uinterp = zeros(size(U));
Vinterp = zeros(size(V));
PHIinterp = zeros(size(PHI));

Uinterp(:,:,1) = U(:,:,1);
Vinterp(:,:,1) = V(:,:,1);
PHIinterp(:,:,1) = PHI(:,:,1);

Uinterp(:,:,end) = U(:,:,end);
Vinterp(:,:,end) = V(:,:,end);
PHIinterp(:,:,end) = PHI(:,:,end);

for nn=2:size(U,3)-1
    Uinterp(:,:,nn) = U(:,:,nn) * (1 - (sigma(nn) - P_actual(nn))/(P_actual(nn) - P_actual(nn-1))) ...
        + U(:,:,nn-1) * (sigma(nn) - P_actual(nn-1))/(P_actual(nn) - P_actual(nn-1));
    Vinterp(:,:,nn) = V(:,:,nn) * (1 - (sigma(nn) - P_actual(nn))/(P_actual(nn) - P_actual(nn-1))) ...
        + V(:,:,nn-1) * (sigma(nn) - P_actual(nn-1))/(P_actual(nn) - P_actual(nn-1));
    PHIinterp(:,:,nn) = PHI(:,:,nn) * (1 - (sigma(nn) - P_actual(nn))/(P_actual(nn) - P_actual(nn-1))) ...
        + PHI(:,:,nn-1) * (sigma(nn) - P_actual(nn-1))/(P_actual(nn) - P_actual(nn-1));
end

end

