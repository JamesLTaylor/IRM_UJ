function ZeroCouponBondPricesExperiment
T = 5;
treeTimes = 0:0.1:T+0.1;
% HW parameters
sigma = 0.0035;
a = 0.05;
x0 = 0;
meanFunc = @(x, t, deltaT)HWMeanFunc(x, t, deltaT, a);
varFunc = @(t, deltaT)HWVarFunc(t, deltaT,  sigma, a);
% build the diffusion tree
tree = BuildDiffusionTree(x0, treeTimes, meanFunc, varFunc);
% Adjust the tree to fit a term structure
dfFunc = GetDFFunc();
tree = AdjustDiffusionTree(tree, dfFunc);

% check the 2 year bond in 3 years time
t = 3;
T = 5;

t_i = find(min(abs(t-treeTimes)) == abs(t-treeTimes));
T_i = find(min(abs(T-treeTimes)) == abs(T-treeTimes));
v = ones(size(tree.x{T_i}));

% forward bond price off tree
for i = (T_i-1):-1:t_i
    dt = treeTimes(i+1) - treeTimes(i);
    fwdDfs = exp(-(tree.x{i}+tree.alpha{i})*dt);
    newV = tree.pu{i} .* v(tree.nextInd{i}-1) .* fwdDfs;
    newV = newV + tree.pd{i} .* v(tree.nextInd{i}+1) .* fwdDfs;
    newV = newV +(1-tree.pu{i}-tree.pd{i}) .* v(tree.nextInd{i}) .* fwdDfs;
    v = newV;
end

% "closed form forward bond price"
newBonds = zeros(size(tree.x{t_i}));
alpha_t = tree.alpha{t_i};
for level = 1:length(newBonds)    
    r = tree.x{t_i}(level) + alpha_t;
    newBonds(level) = PtT(r, alpha_t, a, t, T, dfFunc, sigma);
end


% PtT
%
% ptT = PtT(r, alpha_t, a, t, T, dfFunc, sigma)
function ptT = PtT(r, alpha_t, a, t, T, dfFunc, sigma)
BtT = (1/a) * (1 - exp(-a*(T-t)));
fMt = alpha_t - (sigma^2)/(2*a^2)*((1-exp(-a*t))^2);
AtT = dfFunc(T)/dfFunc(t);
AtT = AtT * exp(BtT*fMt - ((sigma^2)/(4*a))*(1 - exp(-2*a*t))*(BtT^2));
ptT = AtT * exp(-BtT*r);

%GetDFFunc Returns a discount factor function.
%
function dfFunc = GetDFFunc()
curve = [0 0.06
    0.25 0.062
    0.5 0.066
    1 0.07
    2 0.069
    5 0.065
    10 0.06];

dfFunc = @(t)ZeroCurveDFFunc(t, curve(:,1), curve(:,2));