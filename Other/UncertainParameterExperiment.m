function UncertainParameterExperiment
% solved params =     0.1509    0.3064    0.7837
sigmas = [0.12 0.24];
lambdas = [0.5 0.5];

F = 0.0725;
T = 1;
DFtau = 1000000*0.9357*0.25;

[moneyness, mktVols] = GetMarketSmile();
K = F - moneyness;
myfun = @(x)penalty(x, moneyness, mktVols, F, T, DFtau);
x0 = [0.12, 0.24, 0.5];
options = optimset('display', 'iter');
param = fminsearch(myfun, x0, options);
sigmas(1) = param(1);
sigmas(2) = param(2);
lambdas(1) = param(3);
lambdas(2) = 1 - param(3);

v = zeros(size(K));
for i = 1:length(sigmas)
    v = v + lambdas(i) * Black(F, K(i), sigmas(i), T, DFtau, 1);
end

impliedVols = zeros(size(v));
for i = 1:length(v)
    impliedVols(i) = BlackImpliedVol(F, K(i), T, DFtau, 1, v(i));
end
plot(F - K, impliedVols, 'k', F - K, mktVols, 'b');
xlabel('Forward - Strike')
legend('Fitted Model Smile','Market Smile')

function squareDiff = penalty(param, moneyness, mktVols, F, T, DFtau)
vol1 = param(1);
vol2 = param(2);
lambda1 = param(3);
lambda2 = 1 - lambda1;

value = lambda1 * Black(F, F-moneyness, vol1, T, DFtau, 1)...
    + lambda2 * Black(F, F-moneyness, vol2, T, DFtau, 1);

squareDiff = 0;
for i = 1:length(moneyness)
    squareDiff = squareDiff + ...
        (BlackImpliedVol(F, F - moneyness(i), T, DFtau, 1, value(i))...
        - mktVols(i))^2;
end

function [moneyness, vols] = GetMarketSmile()
mAndVol = [-0.0500	0.236
-0.0200	0.168
-0.0100	0.169
-0.0050	0.177
-0.0025	0.182
0.0000	0.187
0.0025	0.192
0.0050	0.198
0.0100	0.210
0.0200	0.233
0.0500	0.282];
moneyness = mAndVol(:,1);
vols = mAndVol(:,2);
