%HWVarFunc Implements Brigo and Mercurio 3.47
%
% var = HWVarFunc(t, deltaT, sigma, a)
%
% t      : not used, just there to meet function signature requirments
% deltaT : The time in years from t, t_{i} to the next layer of the tree, t_{i+1}
% sigma  :
% a      :
function var = HWVarFunc(t, deltaT, sigma, a)
var = ((sigma*sigma)/(2*a)) * (1 - exp(-2*a*deltaT));