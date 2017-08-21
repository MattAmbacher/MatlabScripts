function [Ubar, Vbar, Wbar] = vert_projection(U,V,W, p, mode)
    %want to compute <mode, f>/ <mode, mode> \vec{mode}
    %Let 'g' be the mode and let f_g = <f,g>, g_g = <g, g>
    
   

    

F = repmat(mode, 1, size(U,1), size(U,2));
dp = diff(p);
P = repmat(dp, 1, size(U,1), size(U,2));
P = permute(P, [2,3,1]);
F = permute(F, [2,3,1]);
%Ubar = zeros(size(U,1), size(U,2));
%Vbar = zeros(size(V,1), size(V,2));
%Wbar = zeros(size(W,1), size(W,2));
Lz = max(p) - min(p);

Um = U.*F;
Vm = V.*F;
Wm = W.*F;
%scale = 1.0216e5;
scale = max(p);
%integrate using trapezoidal rule
% Ubar = 1/Lz * 1/2 * sum( (Um(:,:,2:end) + Um(:,:,1:end-1)) .* P, 3);
% Vbar = 1/Lz * 1/2 * sum( (Vm(:,:,2:end) + Vm(:,:,1:end-1)) .* P, 3);
% Wbar = 1/Lz * 1/2 * sum( (Wm(:,:,2:end) + Wm(:,:,1:end-1)) .* P, 3);
Ubar =  1/(2 * scale) * sum( (Um(:,:,2:end) + Um(:,:,1:end-1)) .* P, 3);
Vbar =  1/(2 * scale) * sum( (Vm(:,:,2:end) + Vm(:,:,1:end-1)) .* P, 3);
Wbar =  1/(2 * scale) * sum( (Wm(:,:,2:end) + Wm(:,:,1:end-1)) .* P, 3);


%Ubar = scale/dp(1) * Ubar;
%Vbar = scale/dp(1) * Vbar;
%Wbar = scale/dp(1) * Wbar;
% 
%     for row=1:size(U,1)
%         for col=1:size(U,2)
%             Ubar(row,col) = 1/Lz * (1/2 * sum(squeeze(U(row,col,2:end) + U(row, col, 1:end-1)).* (mode(2:end) + 2 * (P(2:end) - P(1:end-1))));
%         end
%     end

%Ubar = 1/(max(P) - min(P)) * sum((squeeze(U) .* F .*, 3);


%     for row=1:size(V,1)
%         for col=1:size(V,2)
%             Vbar(row,col) = 1/Lz * (1/2 * sum(squeeze(V(row,col,2:end) + V(row, col, 1:end-1)).* mode * (P(2:end) - P(1:end-1))));
%         end
%     end
%Vbar = 1/(max(P) - min(P)) * sum(squeeze(V) .* F, 3);
%     for row=1:size(W,1)
%         for col=1:size(W,2)
%             Wbar(row,col) = 1/Lz * (1/2 * sum(squeeze(W(row,col,2:end) + W(row, col, 1:end-1)).* mode * (P(2:end) - P(1:end-1))));
%         end
%     end
%Wbar = 1/(max(P) - min(P)) * sum(squeeze(W) .* F, 3);
end
