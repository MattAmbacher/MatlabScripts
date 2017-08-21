function [K_range, slope, bias, R2] = fit_spectra(K, spectrum)
start_K = 6; end_K = 60;

start_ind = find(K >= start_K, 1);
end_ind = find(K >= end_K, 1);
K_range = K(start_ind:end_ind);

X = ones(end_ind - start_ind + 1, 2);
X(:,2) = log10(K(start_ind:end_ind));

Y =  log10(spectrum(start_ind:end_ind));
if size(Y,1) == 1
	Y = Y';
end

A = X'*X;
B = X'*Y;
fit = qmr(A,B);
slope = fit(2);
bias = fit(1);

ssres = 0;
sstot = 0;

Ybar = mean(Y);
for ss=1:end_ind-start_ind+1
    sstot = sstot + (Y(ss) - Ybar)^2;
    ssres = ssres + (Y(ss) - (slope*X(ss,2)+bias))^2;
end

R2 = 1 - ssres/sstot;




