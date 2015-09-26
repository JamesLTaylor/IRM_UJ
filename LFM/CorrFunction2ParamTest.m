M = 40;
i = repmat(1:M,M,1);
j = repmat((1:M)',1,M);
rho_infinity = 0.3;
eta = 1;

corr = CorrFunction2Param(i, j, M, rho_infinity, eta);

surf(i, j, corr);
