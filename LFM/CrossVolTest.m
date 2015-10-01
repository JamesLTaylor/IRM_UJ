function CrossVolTest()

a = 0.191;
b = 0.975;
c = 0.08;
d = 0.013;
Talpha = 2;
Ti = 4;
Tj = 5;

result = crossVolAnalytical(a, b, c, d, Talpha, Ti, Tj)
result2 = crossVolNumerical(a, b, c, d, Talpha, Ti, Tj)

disp('Analytical time:')
tic
for i = 1:1000
    result = crossVolAnalytical(a, b, c, d, Talpha, Ti, Tj);
end
toc

disp('Numerical time:')
tic
for i = 1:1000
    result = crossVolNumerical(a, b, c, d, Talpha, Ti, Tj);
end
toc


a = 0;
b = 0.000001;
c = 1;
d = 0;

result = crossVolAnalytical(a, b, c, d, Talpha, Ti, Tj)
result2 = crossVolNumerical(a, b, c, d, Talpha, Ti, Tj)

function result = crossVolAnalytical(a, b, c, d, Talpha, Ti, Tj)
result = Talpha*c^2 + (-2*Ti*Tj*a^2*b^2 - Ti*a^2*b - 2*Ti*a*b^2*d - ...
    Tj*a^2*b - 2*Tj*a*b^2*d - a^2 - 2*a*b*d - 2*b^2*d^2 - ...
    4*b*c*(Ti*a*b*exp(Tj*b) + Tj*a*b*exp(Ti*b) + a*exp(Ti*b) + a*exp(Tj*b) ...
    + b*d*exp(Ti*b) + b*d*exp(Tj*b)) + (4*b*c*(-Talpha*a*b*exp(Ti*b) - ...
    Talpha*a*b*exp(Tj*b) + Ti*a*b*exp(Tj*b) + Tj*a*b*exp(Ti*b) + ...
    a*exp(Ti*b) + a*exp(Tj*b) + b*d*exp(Ti*b) + b*d*exp(Tj*b)) + ...
    (2*Talpha^2*a^2*b^2 - 2*Talpha*Ti*a^2*b^2 - 2*Talpha*Tj*a^2*b^2 - ...
    2*Talpha*a^2*b - 4*Talpha*a*b^2*d + 2*Ti*Tj*a^2*b^2 + ...
    Ti*a^2*b + 2*Ti*a*b^2*d + Tj*a^2*b + 2*Tj*a*b^2*d + a^2 + ...
    2*a*b*d + 2*b^2*d^2)*exp(Talpha*b))*exp(Talpha*b))*...
    exp(-b*(Ti + Tj))/(4*b^3);



function result = crossVolNumerical(a, b, c, d, Talpha, Ti, Tj)
N=10000;
t = linspace(0,Talpha,N);
sigma_i = (a * (Ti - t) + d) .* exp(-b*(Ti-t)) + c;
sigma_j = (a * (Tj - t) + d) .* exp(-b*(Tj-t)) + c;
result = sum(sigma_i.*sigma_j*Talpha/N);



