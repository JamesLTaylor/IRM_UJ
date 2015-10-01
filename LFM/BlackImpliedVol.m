function v = BlackImpliedVol(F, K, T, multiplier, omega, price)
fun = @(vol) (Black(F, K, vol, T, multiplier, omega) - price)^2;
v = fminbnd(fun,1e-6,1);