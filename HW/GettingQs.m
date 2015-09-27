t = 0:0.25:1;

% HW parameters
sigma = 0.015;
a = 0.05;

% Mean and Variance
x0 = 0;
meanFunc = @(x, t, deltaT)HWMeanFunc(x, t, deltaT, a);
varFunc = @(t, deltaT)HWVarFunc(t, deltaT,  sigma, a);

tree = BuildDiffusionTree(x0, t, meanFunc, varFunc);

bold{1} = [1 1 1];
bold{2} = [[1 1 1];[1 1 1];[1 1 0]];
bold{3} = [[0 1 1];[1 1 1];[1 1 0];[1 0 0];[0 0 0]];
bold{4} = [[0 0 0];[0 0 1];[0 1 0];[1 0 0];[0 0 0];[0 0 0];[0 0 0]];
PlotTreeWithBold(tree, bold);