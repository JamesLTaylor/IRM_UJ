%
%
function vol = VolFunc4Param(t, T, a, b, c, d)
dt = T-t;
vol = (a*dt + d).*exp(-b*dt) + c;