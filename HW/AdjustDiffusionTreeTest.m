function AdjustDiffusionTreeTest()
T = 5;
%t = 0:0.25:T;
t = [0:0.1:1, 1.25, 1.5, 1.75, 2:(T+1)] ;

% HW parameters
sigma = 0.0035;
a = 0.05;

% Mean and Variance
x0 = 0;
meanFunc = @(x, t, deltaT)HWMeanFunc(x, t, deltaT, a);
varFunc = @(t, deltaT)HWVarFunc(t, deltaT,  sigma, a);

% build the diffusion tree
tree = BuildDiffusionTree(x0, t, meanFunc, varFunc);

% Adjust the tree to fit a term structure
curve = [0 0.06
    0.25 0.062
    0.5 0.066
    1 0.068
    2 0.069
    5 0.065
    10 0.06];

dfFunc = @(t)ZeroCurveDFFunc(t, curve(:,1), curve(:,2));
newTree = AdjustDiffusionTree(tree, dfFunc);

PlotTree(newTree, true);