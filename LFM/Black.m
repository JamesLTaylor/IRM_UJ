%
% multiplier  - df*tau for a caplet and pvbp(t) for a swaption
function value = Black(F, K, vol, T, multiplier, omega)
d1 = (log(F./K) + 0.5*vol^2*T)/(vol*sqrt(T));
d2 = d1 - vol*sqrt(T);
value = multiplier .* (F.*normcdf(d1) - K.*normcdf(d2));