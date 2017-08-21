function RMS = calc_Ro_RMS(zeta)
 
    RMS = f.^2;
    RMS = sqrt(sum(RMS(:))/(size(f,1)*size(f,2)*40));
end

