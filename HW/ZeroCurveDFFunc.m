%ZeroCurveDFFunc
%
% df = ZeroCurveDFFunc(t, dates, rates)
function df = ZeroCurveDFFunc(t, dates, rates)
rate = interp1(dates, rates, t, 'cubic');
%rate = interp1(dates, rates, t, 'linear');
df = exp(-t.*rate);
