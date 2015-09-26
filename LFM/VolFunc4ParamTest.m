a = 0.191;
b = 0.975;
c = 0.08;
d = 0.013;

% forward rate vol as function of time to maturity
allT = [1 5 10];
figure();
hold all;
for T = allT
    t = 0:0.01:T;
    vol = VolFunc4Param(t, T, a, b, c, d);
    plot(t, vol);
    axis([0 10, 0 0.2]);
end
title('forward rate vol as function of time to maturity')
legend('1 year forward','5 year forward', '10 year forward')
    

