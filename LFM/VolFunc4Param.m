%
% Gets the volatility of forward rate index at time t<=T(index-1)
%
% T - starts at T_1, assumes T_0 = 0
function vol = VolFunc4Param(t, index, T, a, b, c, d)
dt = T(index-1)-t;
vol = (a*dt + d).*exp(-b*dt) + c;