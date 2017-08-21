function vort(U,V,dx,dy)
dUdy = size(U);
dVdx = size(V);
dUdy(1,:,:,:) = (U(2,:,:,:) - U(end-1,:,:,:))/(2*dy);
for jj=2:size(U,1)-1
	dUdy(jj,:,:,:) = ( U(jj+1,:,:,:) - U(jj-1,:,:,:))/(2*dy);
end
dUdy(end,:,:,:) = dUdy(1,:,:,:);

dVdx(:,1,:,:) = (V(:,2,:,:) - V(:,end-1,:,:))/(2*dx);
for ii=2:size(V,2)-1
	dVdx

end

