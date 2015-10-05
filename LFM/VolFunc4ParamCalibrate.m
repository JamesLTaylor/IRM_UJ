function [a, b, c, d] = VolFunc4ParamCalibrate(maturities, vols)

myfun = @(x)penalty(x, maturities, vols);
x0 = [0.14, 10, vols(end), 0.01];
options = optimset('display', 'iter');
param = fminsearch(myfun, x0, options);
a = param(1);
b = param(2);
c = param(3);
d = param(4);

fittedVols = zeros(size(vols));
for i = 1:length(maturities)
    Ti = maturities(i);
    fittedVols(i) = sqrt(IntVolFuncSquared(a, b, c, d, Ti)/Ti);
end
plot(maturities, vols, 'k', maturities, fittedVols, 'r');
legend('Market vols', 'Fitted vols')
xlabel('Time to maturity in years')


function value = penalty(param, maturities, vols)
value = 0;
for i = 1:length(maturities)
    Ti = maturities(i);
    value = value + ((1/Ti) * ...
        IntVolFuncSquared(param(1), param(2), param(3), param(4), Ti)...
        - vols(i)^2)^2;
end
    

%
% Brigo Mercurio equation 6.26, expanded.  
%
% Note, Ti is acually T_{i-1}, the reset time for forward rate i
function v2 = IntVolFuncSquared(a, b, c, d, Ti) 
v2 = Ti*c^2 + (-2*Ti^2*a^2*b^2 - 2*Ti*a^2*b - 4*Ti*a*b^2*d - ...
    a^2 - 2*a*b*d - 2*b^2*d^2 - 8*b*c*(Ti*a*b + a + b*d)*exp(Ti*b) ...
    + (a^2 + 8*a*b*c + 2*a*b*d + 8*b^2*c*d + ...
    2*b^2*d^2)*exp(2*Ti*b))*exp(-2*Ti*b)/(4*b^3);