r = 0.07;
sigma = 0.2;
K = 100;
TE = [1 2];
S0 = 100;

N = 10000;
S0 = repmat(S0, N, 1);
deltaT = TE(1) - 0;
S1 = S0.*exp((r-0.5*sigma^2)*deltaT + sigma * sqrt(deltaT)*randn(N,1));
deltaT = TE(2) - TE(1);
S2 = S1.*exp((r-0.5*sigma^2)*deltaT- + sigma * sqrt(deltaT)*randn(N,1));

CV = exp(-r*deltaT).*max(K-S2, 0);
X1 = [ones(N,1) max(K - S1,0) max(K-S1,0).^2 max(K-S1,0).^3];
b1 = regress(CV, X1)

X2 = [ones(N,1) S1 S1.^2 S1.^3];
b2 = regress(CV, X2)

xForPlot = (40:220)';
CV1forPlot = b1(1) * ones(size(xForPlot)) + b1(2)*max(K-xForPlot,0) + b1(3)*max(K-xForPlot,0).^2 + b1(4)*max(K-xForPlot,0).^3;
CV2forPlot = b2(1) * ones(size(xForPlot)) + b2(2)*xForPlot + b2(3)*xForPlot.^2 + b2(4)*xForPlot.^3;

%figure()
%plot(S1, CV, '.')
%hold on
%plot(xForPlot, CV1forPlot,'g','LineWidth',5)
%plot(xForPlot, CV2forPlot,'k','LineWidth',5)
%plot(xForPlot, max(K-xForPlot,0),'r','LineWidth',3)
%legend('Simulated CV', 'Fitted CV (polynomial in intrinsic)', 'Fitted CV (polynomial in spot)', 'Intrinsic')

optimalBoundary = 85:0.25:95;
valueAt1WithBoundary = zeros(size(optimalBoundary));
for i = 1:length(optimalBoundary)
    b = optimalBoundary(i);
    valueAt1WithBoundary(i) = mean(CV.*(S1>b) + max(K-S1,0).*(S1<=b));
end
figure()
plot(optimalBoundary, valueAt1WithBoundary)