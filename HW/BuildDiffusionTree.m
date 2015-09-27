function tree = BuildDiffusionTree(x0, t, meanFunc, varFunc)
tree.t = t;
tree.x = cell(length(t),1);
tree.alpha = cell(length(t),1);
tree.pu = cell(length(t),1);
tree.pd = cell(length(t),1);
tree.nextInd = cell(length(t),1);

tree.x{1} = x0;
% loop through the time layers in the tree
for i = 1:(length(t)-1)    
    % parameters that are the same for the whole time step
    deltaT = t(i+1) - t(i);
    V2 = varFunc(t(i), deltaT);
    V = sqrt(V2);
    deltaX = sqrt(V2)*sqrt(3);
    % allocate space
    nextK = zeros(size(tree.x{i}));
    tree.pu{i} = zeros(size(tree.x{i}));
    tree.pd{i} = zeros(size(tree.x{i}));
    % loop through the x levels in each time layer
    for j = 1:length(tree.x{i})
        x = tree.x{i}(j);
        M = meanFunc(x, t(i), deltaT);
        k = round(M/deltaX);
        [pu, ~, pd] = GetP(M, x, V, deltaX);
        nextK(j) = k;
        tree.pu{i}(j) = pu;
        tree.pd{i}(j) = pd;        
    end    
    
    % construct the x levels for the next time step
    allK = unique([nextK(:) ; nextK(:)+1 ; nextK(:)-1]);
    tree.x{i+1} = zeros(size(allK));
    for j = 1:length(allK)
       tree.x{i+1}(j) = allK(j)*deltaX;
    end
    % find the indices that the levels at t(i) map to at t(i+1)
    tree.nextInd{i} = zeros(size(tree.x{i}));
    for j = 1:length(nextK)        
        tree.nextInd{i}(j) = find(allK==nextK(j));
    end    
end