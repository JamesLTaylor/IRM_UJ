a = 0.191;
b = 0.975;
c = 0.08;
d = 0.013;

% forward rate vol as function of time to maturity
startDates = 0:0.25:9.75;
endDates = 0.25:0.25:10;
requiredIndex = [4 20 40];
figure();
hold all;
for i = requiredIndex
    t = 0:0.01:startDates(i);
    vol = VolFunc4Param(t, i, startDates, a, b, c, d);
    plot(t, vol);
    axis([0 10, 0 0.2]);
end
title('forward rate vol as function of time to maturity')
legend('1 year forward','5 year forward', '10 year forward')
    

