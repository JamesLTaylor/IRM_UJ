function vol = SwapVolApprox(alpha, beta, T, F, corrMatrix, crossVolFunc)
tau = diff([0 T]);
requiredTau = repmat(tau(alpha+1:beta), size(F,1), 1);
forwardDfs = cumprod(1./(1+requiredTau.*F(:,alpha+1:beta)),2);
pvbp = sum((requiredTau.*forwardDfs),2);
swapRate = (1 - forwardDfs(:,end))./pvbp;

runningTotal = 0;
for i = alpha+1:beta
    wi = tau(i) * forwardDfs(i - alpha) / pvbp;    
    for j = alpha+1:beta
        wj = tau(j) * forwardDfs(j - alpha) / pvbp;
        runningTotal = runningTotal + wi*wj*corrMatrix(i, j)*F(i)*F(j)*...
            crossVolFunc(alpha, i, j);
    end    
end
vol = sqrt(runningTotal / (T(alpha)*swapRate*swapRate));
