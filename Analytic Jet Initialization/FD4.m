function du = FD4(u, dx)
%returns 5th order forward difference first derivative
%input:
%	u - input scalar/vector field
%	bc - Boundary Conditons
%		1 - period
%		2 - antisymmetric

du = zeros(size(u));
J = size(u,3);
du(:,:,1) = 1/dx * ( 1/12 * (u(:,:,3)) - 2/3 * (u(:,:,2)) + 2/3 * u(:,:,2) - 1/12 * u(:,:,3) );
du(:,:,2) = 1/dx * (1/12 * (u(:,:,2)) - 2/3 * u(:,:,1) + 2/3 * u(:,:,3) - 1/12 * u(:,:,4) );
    for j=3:J-2
       du(:,:,j) = 1/dx * ( 1/12 * u(:,:,j-2) - 2/3 * u(:,:,j-1)  +2/3 * u(:,:,j+1) - 1/12 * u(:,:,j-1) );
    end
du(:,:,J-1) = 1/dx * ( 1/12 * u(:,:,J-3) - 2/3 * u(:,:,J-2) + 2/3 * u(:,:,J) - 1/12 * (u(:,:,J-1)) );
du(:,:,J) = 1/dx * ( 1/12 * u(:,:,J-2) - 2/3 * u(:,:,J-1) + 2/3 * (u(:,:,J-1)) - 1/12 * (u(:,:,J-2)) );
end