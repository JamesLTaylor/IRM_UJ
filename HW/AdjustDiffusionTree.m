function newTree = AdjustDiffusionTree(tree, dfFunc)
newTree = tree;
newTree.Q = cell(size(tree.x));
newTree.alpha = cell(size(tree.x));
newTree.Q{1} = 1; 

for i = 1:(length(tree.t)-1)
    P0t = dfFunc(tree.t(i+1));
    deltaT = tree.t(i+1) - tree.t(i);
    total = 0;
    prevQ = newTree.Q{i};
    x = tree.x{i};
    for j = 1:length(prevQ)
        total = total + prevQ(j) * exp(-x(j)*deltaT);
    end    
    alpha = (1/deltaT) * log(total/P0t);
    
    pu = tree.pu{i};
    pd = tree.pd{i};
    nextInd = tree.nextInd{i};
    newQ = zeros(size(tree.x{i+1}));
    for j = 1:length(prevQ)
        fwdAdjust = exp(-(x(j) + alpha)*deltaT);
        
        newQ(nextInd(j)-1) = newQ(nextInd(j)-1) + ... 
                             prevQ(j)*pu(j)*fwdAdjust;
                         
        newQ(nextInd(j)) = newQ(nextInd(j))+ ... 
                             prevQ(j)*(1 - pu(j) - pd(j))*fwdAdjust;
                         
        newQ(nextInd(j)+1) = newQ(nextInd(j)+1)+ ... 
                             prevQ(j)*pd(j)*fwdAdjust;
    end
    newTree.Q{i+1} = newQ;
    newTree.alpha{i} = alpha;
end