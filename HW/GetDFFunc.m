%GetDFFunc Returns a simple discount factor function for testing.
%
function dfFunc = GetDFFunc()
curve = [0 0.06
    0.25 0.062
    0.5 0.066
    1 0.07
    2 0.069
    5 0.065
    10 0.06];

dfFunc = @(t)ZeroCurveDFFunc(t, curve(:,1), curve(:,2));