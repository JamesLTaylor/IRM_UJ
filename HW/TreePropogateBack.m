function newV = TreePropogateBack(v, tree, i)
newV = PropogateBackVec(v(:,1), tree, i);
for col = 2:size(v,2)
    newV = [newV PropogateBackVec(v(:,col), tree, i)];
end

function newV = PropogateBackVec(v, tree, i)
dt = tree.t(i+1) - tree.t(i);
fwdDfs = exp(-(tree.x{i}+tree.alpha{i})*dt);
newV = tree.pu{i} .* v(tree.nextInd{i}-1) .* fwdDfs;
newV = newV + tree.pd{i} .* v(tree.nextInd{i}+1) .* fwdDfs;
newV = newV +(1-tree.pu{i}-tree.pd{i}) .* v(tree.nextInd{i}) .* fwdDfs;
