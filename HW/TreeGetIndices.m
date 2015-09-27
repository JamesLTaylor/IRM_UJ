% TreeGetIndices - get the time indices in the tree that correspond
%                  to the provided times.
%
% ind = TreeGetIndices(treeTimes, otherTimes)
%
function ind = TreeGetIndices(treeTimes, otherTimes)
ind = zeros(size(otherTimes));
for i = 1:length(otherTimes)
    ind(i) = find(min(abs(otherTimes(i)-treeTimes)) == abs(otherTimes(i)-treeTimes));
end