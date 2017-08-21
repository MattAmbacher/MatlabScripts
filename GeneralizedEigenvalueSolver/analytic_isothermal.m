z = 0:100:40000;
zt = 40000;
ps = 1013;

p = ps*exp(-g*z/(R*T0));

F1 = (cos(pi*z/zt) + g*zt/(R*T0*pi)*(kappa - 1/2) *sin(pi*z/zt)) .* exp(g*z/(2*R*T0));
F2 = (cos(2*pi*z/zt) + g*zt/(R*T0*2*pi)*(kappa - 1/2) *sin(2*pi*z/zt)) .* exp(g*z/(2*R*T0));
F3 = (cos(3*pi*z/zt) + g*zt/(R*T0*3*pi)*(kappa - 1/2) *sin(3*pi*z/zt)) .* exp(g*z/(2*R*T0));