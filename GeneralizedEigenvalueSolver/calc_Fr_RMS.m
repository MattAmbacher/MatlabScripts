function RMS = calc_Fr_RMS(f, dz, Lz)
 RMS = 0;
for zz = 39:79
    RMS = RMS + f(:,end/2:end,zz).^2 * dz(zz);
end

RMS = sqrt(sum(RMS(:))/(size(f,1)*size(f,2)/2 * Lz));
