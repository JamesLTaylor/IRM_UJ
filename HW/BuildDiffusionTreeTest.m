function BuildDiffusionTreeTest()
T = 5;
%t = 0:0.25:T;
t = [0:0.05:1, 1.25, 1.5, 1.75, 2:T] ;

% HW parameters
sigma = 0.015;
a = 0.05;

% Mean and Variance
x0 = 0;
meanFunc = @(x, t, deltaT)HWMeanFunc(x, t, deltaT, a);
varFunc = @(t, deltaT)HWVarFunc(t, deltaT,  sigma, a);

tree = BuildDiffusionTree(x0, t, meanFunc, varFunc);
PlotTree(tree);