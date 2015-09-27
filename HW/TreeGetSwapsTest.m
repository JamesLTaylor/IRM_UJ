function TreeGetSwapsTest
%% Tree
T = 5;
treeTimes = 0:0.05:T+0.1;
% HW parameters
sigma = 0.01;
a = 0.05;
x0 = 0;
meanFunc = @(x, t, deltaT)HWMeanFunc(x, t, deltaT, a);
varFunc = @(t, deltaT)HWVarFunc(t, deltaT,  sigma, a);
% build the diffusion tree
tree = BuildDiffusionTree(x0, treeTimes, meanFunc, varFunc);
% Adjust the tree to fit a term structure
dfFunc = GetDFFunc();
tree = AdjustDiffusionTree(tree, dfFunc);

%
swapDates = 0:0.25:5;
swapInd = TreeGetIndices(treeTimes, swapDates);

%% Valuation
zBonds = ones(size(tree.x{swapInd(end)}));
for i = (swapInd(end)-1):-1:swapInd(1)
    % backward step
    zBonds = TreePropogateBack(zBonds, tree, i);
    if any(i==swapInd)
        zBonds = [ones(size(zBonds,1),1) zBonds];
    end
end

[treeRate, treePvbp] = TreeGetSwaps(zBonds);
t0Dfs = dfFunc(swapDates);
pvbp0 = 0.25*sum(t0Dfs(2:end));
rate0 = (1-t0Dfs(end))/pvbp0;

disp(['pvbp from tree   : ' num2str(treePvbp)]);
disp(['pvbp off curve   : ' num2str(pvbp0)]);

disp(['rate from tree   : ' num2str(treeRate)]);
disp(['rate off curve   : ' num2str(rate0)]);

