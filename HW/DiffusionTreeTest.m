function DiffusionTreeTest()
T = 5;
t = 0:0.25:T;


% HW parameters
sigma = 0.015;
a = 0.05;

% Mean and Variance
x0 = 0;
meanFunc = @(x, t, deltaT)0;
varFunc = @(t, deltaT)HWVarFunc(t, deltaT,  sigma, a);

tree = BuildDiffusionTree(x0, t, meanFunc, varFunc);