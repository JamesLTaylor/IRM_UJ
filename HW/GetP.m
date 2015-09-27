%GetP  implements equation (5.2)
% 
% [pu, pm, pd] = GetP(M, x, V, deltaX)  
%
% M      - the mean over the next time step
% x      - the central value at t(i+1)
% V      - the variance over the next time step
% deltaX - the spacing between the x nodes at t(i+1)
function [pu, pm, pd] = GetP(M, x, V, deltaX)
eta = M - x;
t1 = V*V/(2*deltaX*deltaX);
t2 = eta*eta/(2*deltaX*deltaX);
t3 = eta/(2*deltaX);
pu = t1 + t2 + t3;
pm = 1 - 2*t1 - 2*t2;
pd = t1 + t2 - t3;
