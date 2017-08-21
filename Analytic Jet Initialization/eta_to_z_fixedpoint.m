function eta_final = eta_to_z_fixedpoint(x,y,z,Ly)
Rd = 287;
eta_array = 1e-7*ones(length(y), length(z));
old_eta = 1;
eta_final = zeros(length(x),length(y), length(z));
g = 9.80616; % m / s^2

for nn = 1:length(z)
    zz = z(nn);
    for jj = 1:length(y)
        eta = eta_array(jj,nn);
        yy = y(jj);
        counter = 0;
        while ( (abs(eta - old_eta) > 1e-6) && (counter < 50))
           old_eta = eta;
           counter = counter + 1;
           
           [phi, phi_prime] = set_geopotential(x,yy,eta,Ly);
           [T, ~] = set_temperature(x, yy, eta, phi_prime);
           
           F = -g*zz + phi;
           dF = -Rd/eta*T;
           eta = eta - F/dF;
        end
        if counter >= 25
            disp('Max Iters reached')
            disp(abs(eta - old_eta))
        end
        eta_final(:,jj,nn) = ones(1,length(x))*eta;
    end    
end
end
