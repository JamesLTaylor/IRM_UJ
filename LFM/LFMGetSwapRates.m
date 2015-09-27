function [swapRates, pvbps] = LFMGetSwapRates(alpha, beta, T, F)
tau = diff([0 T]);
requiredTau = repmat(tau(alpha+1:beta), size(F,1), 1);
forwardDfs = cumprod(1./(1+requiredTau.*F(:,alpha+1:beta)),2);
pvbps = sum((requiredTau.*forwardDfs),2);
swapRates = (1 - forwardDfs(:,end))./pvbps;