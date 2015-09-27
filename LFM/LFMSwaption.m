function swaption = LFMSwaption(alpha, beta, T, F, K, notional)
tau = diff([0 T]);
numeraire = prod(1./(1+tau(1:alpha).*F(1,1:alpha)),2); % deterministic numeraire

% get the dfs from the forward rates.  dfs apply from T_alpha.
[swapRates, pvbps] = LFMGetSwapRates(alpha, beta, T, F); % stochastic pvbps
swaption = zeros(size(K));
for i = 1:length(K)
    swaption(i) = mean(max(swapRates-K(i),0).*pvbps*notional*numeraire);
end



