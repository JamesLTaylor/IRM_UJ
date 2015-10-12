M = 40;
i = repmat(1:M,M,1);
j = repmat((1:M)',1,M);
rho_infinity = 0.6;
eta = 0.2;

corr = CorrFunction2Param(i, j, M, rho_infinity, eta);

surf(i, j, corr);

[V D] = eig(corr);
e = diag(D);

n = 5;
temp = sort(e,1,'descend');
nthLargest = temp(n);

ind = (e>=(nthLargest-1e-8));
P = V(:,ind);
Lambda = sqrt(D(ind,ind));
corrNew = (P*Lambda) * ((P*Lambda)');

for i = 1:size(corrNew,1)
    for j = 1:size(corrNew,2)
        corrNewNormal(i,j) = corrNew(i,j) / sqrt(corrNew(i,i)*corrNew(j,j));
    end
end

figure
subplot(1,2,1);
surf(corr)
title('Rank 40, 2 parameter correlation matrix');

subplot(1,2,2);
surf(corrNewNormal)
title('Rank 5, zeroed eigen value approximation');


