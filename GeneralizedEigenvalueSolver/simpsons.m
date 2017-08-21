function X = simpsons(x, a, b, dx)
ind_a = round(a/dx) +  1;
ind_b = round(b/dx) + 1;
ind_ab = round( 0.5*(a+b)/dx) + 1;

X = (b-a)/6 * (x(ind_a) + 4*x(ind_ab) + x(ind_b));
end