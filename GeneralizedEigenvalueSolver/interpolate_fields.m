%interpolate U and V and Phi to mass points

function [Ubar, Vbar, Phibar] = interpolate_fields(U,V, Phi)
Ubar = zeros(size(U,1)-1,size(U,2), size(U,3));
Vbar = zeros(size(V,1), size(V,2)-1, size(V,3));
Phibar = zeros(size(Phi,1), size(Phi,2), size(Phi,3)-1);
for col=1:size(U,1)-1
   Ubar(col,:,:) = 0.5 * (U(col,:,:) + U(col+1,:,:));
end
for row=1:size(V,2)-1
   Vbar(:,row,:) = 0.5 * (V(:,row,:) + V(:,row+1,:)); 
end

for vert=1:size(Phi,3)-1
    Phibar(:,:,vert) = 0.5*( Phi(:,:,vert) + Phi(:,:,vert+1));
end
end