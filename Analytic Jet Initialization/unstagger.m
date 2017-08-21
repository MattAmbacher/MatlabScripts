%unstagger.m

%Takes C-grid staggered u and v fields and finds u,v at mass points using
% (u(n) + u(n+1))/2

function [u_centered, v_centered, w_centered] = unstagger(u,v,w)
m = size(u,1);
n = size(v,2);
l = size(w,3) - 1;

u_centered = zeros(m,n,l);
v_centered = zeros(m,n,l);
w_centered = zeros(m,n,l);

for mm=1:m
    for nn=1:n
        for ll=1:l
            u_centered(mm,nn,ll) = 0.5* ( u(mm,nn,ll) + u(mm,nn+1,ll));
        end
    end
end

for mm=1:m
    for nn=1:n
        for ll=1:l
            v_centered(mm,nn,ll) = 0.5 * (v(mm,nn,ll) + v(mm+1,nn,ll)); 
        end
    end
end

for mm=1:m
    for nn=1:n
        for ll=1:l
            w_centered(mm,nn,ll) = 0.5 * (w(mm,nn,ll) + w(mm,nn,ll+1));
        end
    end
end


end