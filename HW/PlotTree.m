function PlotTree(tree, withAlpha)
if nargin==1
    withAlpha = false;
end
figure;
hold on;
for timeInd = 1:(length(tree.t)-2)
    xi = tree.x{timeInd};
    xiPlus1 = tree.x{timeInd+1};
    ti = tree.t(timeInd);
    tiPlus1 = tree.t(timeInd+1);
    indices = tree.nextInd{timeInd};
    
    if withAlpha
        xi = xi+ tree.alpha{timeInd};
        xiPlus1 = xiPlus1+ tree.alpha{timeInd+1};
    end
    
    for j = 1:length(xi)
        plot([ti tiPlus1],[xi(j) xiPlus1(indices(j)-1)],'LineWidth',1);
        plot([ti tiPlus1],[xi(j) xiPlus1(indices(j))],'LineWidth',1);        
        plot([ti tiPlus1],[xi(j) xiPlus1(indices(j)+1)],'LineWidth',1);
    end

end
hold off;
xlabel('time')
ylabel('process value')
