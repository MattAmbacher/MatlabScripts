function [Uhat, Vhat, PHIhat] = project_fields(U,V,PHI,P_HYD, modes, num_modes, sigma, scale)
    %[dummyU, dummyV, dummyPHI] = vert_projection(U,V,PHI,P_HYD);


    % Uhat = zeros(size(dummyU,1), size(dummyU,2), num_modes);
    % Vhat = zeros(size(dummyV,1), size(dummyV,2), num_modes);
    % PHIhat = zeros(size(dummyPHI,1), size(dummyPHI,2), num_modes);
% 
%     vert_proj_U = zeros(size(U,1), size(U,2), num_modes);
%     vert_proj_V = zeros(size(V,1), size(V,2), num_modes);
%     vert_proj_PHI = zeros(size(PHI,1), size(PHI,2), num_modes); 

    %horiz_proj_U = zeros(size(U,1), size(U,2), num_modes);
    %horiz_proj_V = zeros(size(V,1), size(V,2), num_modes);
    %horiz_proj_PHI = zeros(size(PHI,1), size(PHI,2), num_modes); 
    
    Uhat = zeros(size(U,1), size(U,2), num_modes);
    Vhat = zeros(size(V,1), size(V,2), num_modes);
    PHIhat = zeros(size(PHI,1), size(PHI,2), num_modes);
    
    %for n=1:size(U,3)
    %    [horiz_proj_U(:,:,n), horiz_proj_V(:,:,n), horiz_proj_PHI(:,:,n)] = horiz_projection(U(:,:,n),V(:,:,n),PHI(:,:,n)); 
    %end
    
    for n=1:num_modes
       %interp_mode = interp1(sigma*scale, modes(:,n), P_HYD, 'spline');
       interp_mode = modes(:,n);
       %[horiz_proj_U(:,:,n), horiz_proj_V(:,:,n), horiz_proj_PHI(:,:,n)] = horiz_projection(U(:,,V,PHI, P_HYD, interp_mode); 
       [vert_proj_U, vert_proj_V, vert_proj_PHI] = vert_projection(U,V,PHI, sigma*scale, interp_mode);  
       %[vert_proj_U, vert_proj_V, vert_proj_PHI] = vert_projection(U,V,PHI, p, interp_mode);  
       [Uhat(:,:,n), Vhat(:,:,n), PHIhat(:,:,n)] = horiz_projection(vert_proj_U, vert_proj_V, vert_proj_PHI);
       %[Uhat(:,:,n), Vhat(:,:,n), PHIhat(:,:,n)] = vert_projection(horiz_proj_U, horiz_proj_V, horiz_proj_PHI, sigma, interp_mode);
    end

end