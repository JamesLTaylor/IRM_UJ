% BM 6.41
% corrFunction2Param(i, j, M, rho_infinity, eta)
function corr = CorrFunction2Param(i, j, M, rho_infinity, eta)
term1 = -log(rho_infinity) + eta .* (M-1-i-j)./(M-2);
corr = exp(- abs(i-j)./(M-1) .* term1);
