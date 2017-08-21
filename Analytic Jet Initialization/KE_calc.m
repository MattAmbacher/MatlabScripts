%KE_calc.m

% Calculate scaled KE as 1/(L_x * L_y) * 1/2 * (u^2 + v^2), where L_x and
% L_y are domain sizes in x and y respectively

function KE = KE_calc(u,v)
[u,v] = unstagger(u,v);
KE = 0.5 * sum((u(:).^2 + v(:).^2));
end