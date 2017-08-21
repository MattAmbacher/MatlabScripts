%barotropic.m

dx = 15000;
dy = 15000;
dz = 50;

Lx = 15000e3;
Ly = 6000e3;
Lz = 1000;
y = 0:dy:Ly;
x = 0:dx:Lx;
z = 0:dz:Lz;
u = zeros(length(y),length(x), length(z));
theta = zeros(length(y), length(x), length(z));
rho = zeros(length(y), length(x), length(z));

eta = eta_to_z_fixedpoint(x,y,z);
eta = squeeze(eta(1,round(length(y)/2),:));
u0 = 30;
yc = Ly/2;
b = 500e3;
p0 = 1e5;

Kappa = 0.286;
Rd = 287;


for zz=1:length(z)
    for yy=1:length(y)
        for ii=1:length(x)
	    	u(yy,ii,zz) = u0 * exp( -(y(yy) - yc).^2 /(2 * b^2) - (z(zz) - 600).^2/(2*100^2));
        end
    end
    th = 1/100 * z(zz) + 300;
    theta(:,:,zz) = ones(length(y), length(x)) .* th;
    rr = eta(zz)^(1+Kappa)*p0/(Rd * th);
    rho(:,:,zz) = ones(length(y),length(x)) .* rr;
end

T = theta;
