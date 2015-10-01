tenor = 0.25;
finalDate = 5;
T  = tenor:tenor:finalDate;
initialF = repmat(0.07, size(T));
% the volatility function
a = 0.191;
b = 0.975;
c = 0.08;
d = 0.013;
crossVolFunc = @(alpha,i, j) VolFunc4ParamCross(alpha, i, j, T, a, b, c, d);
volFunc = @(t,i) VolFunc4Param(t, i, T, a, b, c, d);
% The correlation matrix
M = length(T);
i = repmat(1:M,M,1);
j = repmat((1:M)',1,M);
rho_infinity = 0.6;
eta = 0.2;
corrMatrix = CorrFunction2Param(i, j, M, rho_infinity, eta);
%Details of simulation
N = 1000000;
deltaT = 0.1;

K = 0.07;
notional = 1e6;

% Swap details
alphaBeta = [4 8
    4 20
    8 9
    8 16
    16 20];

result = [alphaBeta zeros(size(alphaBeta,1),2)];

for row = 1:size(alphaBeta,1)
    alpha = alphaBeta(row,1);
    beta = alphaBeta(row,2);
    kStart = alpha+1; % we don't need F_alpha 
    kEnd = beta;

    % Get the simulated rates and swaption value
    rates = LFMSimulateRates(kStart, kEnd, initialF, T,...
                        corrMatrix, volFunc,... 
                        N, deltaT);
    mcValue = LFMSwaption(alpha, beta, T, rates, K, notional);
    % get the forward swap rate
    dfs = cumprod(1./(1+0.25*initialF));
    pvbp = sum(dfs(alpha+1:beta)*0.25);
    forwardSwapRate = (dfs(alpha) - dfs(beta))/pvbp;
    % Black implied vol
    result(row,3) = BlackImpliedVol(forwardSwapRate, K, T(alpha), notional*pvbp, 1, mcValue);
    % Approx vol
    result(row,4) = SwapVolApprox(alpha, beta, T, initialF, corrMatrix, crossVolFunc);
end
