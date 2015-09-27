function GetPTest()
M = 1;
V = 0.5;
x = 1;
deltaX = V*sqrt(3);

[pu, pm, pd] = GetP(M, x, V, deltaX);

Mtest = pu*(x+deltaX) + pm*(x) + pd*(x-deltaX);
varTest = pu*(x+deltaX)^2 + pm*(x)^2 + pd*(x-deltaX)^2;

Mknown = M;
varKnown = V^2 + M^2;

disp(['test M   : ' num2str(Mtest)]);
disp(['known  M : ' num2str(Mknown)]);

disp(['test V   : ' num2str(varTest)]);
disp(['known  V : ' num2str(varKnown)]);
