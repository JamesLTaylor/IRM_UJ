function PlotTreeWithBold(tree, bold)
if nargin==1
    bold = {};
end
figure;
hold on;
for timeInd = 1:length(tree.t)-1
    xi = tree.x{timeInd};
    xiPlus1 = tree.x{timeInd+1};
    ti = tree.t(timeInd);
    tiPlus1 = tree.t(timeInd+1);
    indices = tree.nextInd{timeInd};
    
    for j = 1:length(xi)
        w1 = 1;
        w2 = 1;
        w3 = 1;
        if timeInd<=length(bold)
            w1 = 1 + 2*(bold{timeInd}(j, 1)==1);
            w2 = 1 + 2*(bold{timeInd}(j, 2)==1);
            w3 = 1 + 2*(bold{timeInd}(j, 3)==1);            
        end
        plot([ti tiPlus1],[xi(j) xiPlus1(indices(j)-1)],'LineWidth',w1);
        plot([ti tiPlus1],[xi(j) xiPlus1(indices(j))],'LineWidth',w2);        
        plot([ti tiPlus1],[xi(j) xiPlus1(indices(j)+1)],'LineWidth',w3);
    end

end
hold off;
xlabel('time')
ylabel('process value')
