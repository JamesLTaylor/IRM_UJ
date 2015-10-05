% The tenor structure and dates of interest
tenor = 0.25;
finalDate = 5;
T  = tenor:tenor:finalDate;
initialF = repmat(0.07, size(T));
alpha = 8; % 2 years
beta = 16; % 4 years
kStart = alpha+1; % we don't need F_alpha 
kEnd = beta;
% the volatility function
a = 0.191;
b = 0.975;
c = 0.08;
d = 0.013;
volFunc = @(t,i) VolFunc4Param(t, i, T, a, b, c, d);
% The correlation matrix
M = length(T);
i = repmat(1:M,M,1);
j = repmat((1:M)',1,M);
rho_infinity = 0.6;
eta = 0.5;
corrMatrix = CorrFunction2Param(i, j, M, rho_infinity, eta);
%Details of simulation
N = 1000000;
deltaT = 0.1;
% Get the simulated rates
rates = LFMSimulateRates(kStart, kEnd, initialF, T,...
                    corrMatrix, volFunc,... 
                    N, deltaT);

K = 0.04:0.0025:0.1;
notional = 1e6;
value = LFMSwaption(alpha, beta, T, rates, K, notional); 

% for black
dfs = cumprod(1./(1+0.25*initialF));
pvbp = sum(dfs(alpha+1:beta)*0.25);
forwardSwapRate = (dfs(alpha) - dfs(beta))/pvbp;
vol = 0.1317;
valueBlack = Black(forwardSwapRate, K, vol, T(alpha), notional*pvbp, 1);

figure()
plot(K,value,'k', K, valueBlack, 'b')
legend('LFM Monte Carlo','Indicative Black')

modelImpliedVol = zeros(size(value));
for i = 1:length(K)
   modelImpliedVol(i) = BlackImpliedVol(forwardSwapRate, K(i), ...
       T(alpha), notional*pvbp, 1, value(i)); 
end
figure()
plot(K,modelImpliedVol)
axis([K(1) K(end) 0.12 0.14])
grid on
xlabel('strike');
ylabel('model implied volatility')
title('LFM Swaption implied vols, T_{\alpha}=2, T_{\beta}=4')