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
N = 100000;
deltaT = 0.1;
% Get the simulated rates
F = LFMSimulateRates(kStart, kEnd, initialF, T,...
                    corrMatrix, volFunc,... 
                    N, deltaT);

[swapRates, pvbps] = LFMGetSwapRates(alpha, beta, T, F);

hist(swapRates, 100);
