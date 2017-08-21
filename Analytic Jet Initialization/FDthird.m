function du = FD4(u, bc, dx)
%returns 5th order forward difference first derivative
%input:
%	u - input scalar/vector field
%	bc - Boundary Conditons
%		1 - period
%		2 - antisymmetric

du = zeros(length(u),1);
J = length(du);
if (bc == 1)
    du(1)
    for j=2:J-1
       du(j) = 1/dx*(-11/6*u(j) + 3*u(mod(j+1,J-1)) -3/2*u(mod(j+2,J-1)) + 1/3*u(mod(j+3,J-1)));
    end
elseif (bc == 2)
    for j=1:J-3
       du(j) =  1/dx*(-11/6*u(j) + 3*u(j+1) -3/2*u(j+2) + 1/3*u(j+3));
    end
    du(J-2) = 1/dx*(-11/6*u(J-2) + 3*u(J-1) - 3/2 * u(J) + 1/3 * (-u(J-1)));
    du(J-1) = 1/dx*(-11/6*u(J-1) + 3*u(J) - 3/2 * -u(J-1) + 1/3 * (-u(J-2)));
    du(J) = 1/dx*(-11/6*u(J) + 3*(-u(J-1)) - 3/2 * -u(J-2) + 1/3 * (-u(J-3)));
else
    disp('Please set bc = 1 (periodic BC) or 2 (antisymmetric BC')
end