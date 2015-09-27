function BermudanSwaptionExperiment()
%% Tree
T = 5;
treeTimes = 0:0.05:T+0.1;
% HW parameters
sigma = 0.015;
a = 0.05;
x0 = 0;
meanFunc = @(x, t, deltaT)HWMeanFunc(x, t, deltaT, a);
varFunc = @(t, deltaT)HWVarFunc(t, deltaT,  sigma, a);
% build the diffusion tree
tree = BuildDiffusionTree(x0, treeTimes, meanFunc, varFunc);
% Adjust the tree to fit a term structure
dfFunc = GetDFFunc();
tree = AdjustDiffusionTree(tree, dfFunc);

%% Swaption
swapDates = 1:0.25:5;
exDates = 1:0.5:4.5;
strike = 0.06; % option to pay fixed
notional = 1000000;

swapInd = TreeGetIndices(treeTimes, swapDates);
exInd = TreeGetIndices(treeTimes, exDates);

%% Valuation
zBonds = ones(size(tree.x{swapInd(end)}));
cv = zeros(size(tree.x{swapInd(end)}));
for i = (swapInd(end)-1):-1:exInd(1)
    % backward step
    zBonds = TreePropogateBack(zBonds, tree, i);
    cv = TreePropogateBack(cv, tree, i);
    
    % on a swap date
    if any(i==swapInd)
        zBonds = [ones(size(zBonds,1),1) zBonds];
    end
    
    % on an exercise date
    if any(i==exInd)
        [rates, pvbps] = TreeGetSwaps(zBonds);
        intrinsic = max(rates-strike,0).*pvbps*notional;
        cv = max(cv, intrinsic);
    end
end

% final step back in the tree using the Q
value = sum(cv.*tree.Q{exInd(1)});
disp(['value of Bermudan swaption is: ' num2str(value)])

