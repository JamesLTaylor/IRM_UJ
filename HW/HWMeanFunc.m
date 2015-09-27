%HWMeanFunc Implements Brigo and Mercurio 3.47
%
% M = HWMeanFunc(x, t, deltaT, a)
%
% x      : The value of the process at t
% t      : not used, just there to meet function signature requirments
% deltaT : The time in years from t, t_{i} to the next layer of the tree, t_{i+1}
% a      :
function M = HWMeanFunc(x, t, deltaT, a)
M = x * exp(-a*deltaT);