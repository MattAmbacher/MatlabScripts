function du = FDfifth(u, bc)
%returns 5th order central difference first derivative
%input:
%	u - input scalar/vector field
%	bc - Boundary Conditons
%		1 - period
%		2 - symmetric

du = zeros(length(u),1)
if (bc == 1)
	J = length(u);
	du(1) = 1/12 * u(J-2) -2/3 * u(J-1) + 2/3 * u(2) -1/12 * u(3);
	du(2) = 1/12 * u(J-1) -2/3 * u(1) + 2/3 * u(3) -1/12 * u(4);
	for j=3:J-2
		du(j) = 1/12*u(j-2) -2/3 * u(j-1) + 2/3 u(j+1) - 1/12 * u(j+2);
	end
	du(J-1) = 1/12 * u(J-3) -2/3 * u(J-2) + 2/3* u(1) -1/12 * u(2);
	du(J) = 1/12 * u(J-2) - 2/3 * u(J-1) + 2/3 * u(2) - 1/12 * u(3);
end
end
