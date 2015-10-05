function LFMCalibrate()
tenor = 0.25;
finalDate = 21;
T  = tenor:tenor:finalDate;
[days, rates] = GetZeroCurve();
df = [1 exp(-interp1(days/365, rates, T).*T)];
initialF = (df(1:end-1)./df(2:end)-1)/tenor;

[maturities, vols] = GetCapletVols();
[a, b, c, d] = VolFunc4ParamCalibrate(maturities, vols);
[Talpha, Tbeta, vols] = GetSwaptions();
alphas = round(Talpha/tenor);
betas = round(Tbeta/tenor);

crossVolFunc = @(alpha,i, j) VolFunc4ParamCross(alpha, i, j, T, a, b, c, d);

[rho_infinity, eta] = CorrFunction2ParamCalibrate(T, initialF, alphas, betas, vols, crossVolFunc)

% returns days and rates.  Rates are NACC
function [days, rates] = GetZeroCurve()
daysAndRates = [91	0.062510355
182	0.064084994
274	0.065239071
366	0.066479969
457	0.067549785
547	0.06859826
639	0.069574567
733	0.070455323
1097	0.073676497
1461	0.07638908
1827	0.078362903
2192	0.079937407
2557	0.081332958
2924	0.082393101
3288	0.083446679
3653	0.084410433
4383	0.086192203
5479	0.088474368
7306	0.088791931
9133	0.086997669
10960	0.083035916
14610	0.083389159
18263	0.083596991];
days = daysAndRates(:,1);
rates = daysAndRates(:,2);

function [maturity, vol] = GetCapletVols()
maturityAndVols = [0.25	0.1
0.5	0.12
0.75	0.14
1	0.1869855
2	0.1992731
3	0.2022026
4	0.2026988
5	0.2026148
6	0.2024321
7	0.202263
8	0.1997684
9	0.2020147
10	0.2019259
11	0.2019259
12	0.2019259
20	0.2019259];
maturity = maturityAndVols(:,1);
vol = maturityAndVols(:,2);


function [Talpha, Tbeta, vol] = GetSwaptions()
datesAndVols = [1	1	0.1792667
1	2	0.1884
1	3	0.1858444
1	5	0.1807333
1	7	0.1795333
1	10	0.1777333
2	1	0.1973667
2	2	0.1998333
2	3	0.1939333
2	5	0.1821333
2	7	0.1813333
2	10	0.1801333
3	1	0.2
3	2	0.1975
3	3	0.1931667
3	5	0.1845
3	7	0.1841
3	10	0.1835
5	1	0.1972
5	2	0.1885333
5	3	0.1866556
5	5	0.1829
5	7	0.1829
5	10	0.1829
7	1	0.1858667
7	2	0.1826667
7	3	0.1804444
7	5	0.176
7	7	0.176
7	10	0.176
10	1	0.1858667
10	2	0.1826667
10	3	0.1804444
10	5	0.176
10	7	0.176
10	10	0.176];

Talpha = datesAndVols(:,1);
Tbeta = datesAndVols(:,1) + datesAndVols(:,2);
vol = datesAndVols(:,3);
