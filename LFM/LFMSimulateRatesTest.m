% The tenor structure and dates of interest
tenor = 0.25;
finalDate = 5;

T  = tenor:tenor:finalDate;
initialF = repmat(0.07, size(T));

Talpha = 2;
Tbeta = 4;
Tmeasure = Talpha;

[~, kStart] = min(abs(Talpha-T));
kStart = kStart+1; % we don't need F_alpha
[~, kEnd] = min(abs(Tbeta-T));
[~, measure_i] = min(abs(Tmeasure-T));

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
rho_infinity = 0.3;
eta = 1;

corrMatrix = CorrFunction2Param(i, j, M, rho_infinity, eta);

%Details of simulation
N = 2;
deltaT = 0.1;

% Get the simulated rates
rates = LFMSimulateRates(kStart, kEnd, initialF, T,...
                    corrMatrix, volFunc,... 
                    N, deltaT);