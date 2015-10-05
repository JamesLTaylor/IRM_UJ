function [rho_infinity, eta] = CorrFunction2ParamCalibrate...
    (T, initialF, alphas, betas, vols, crossVolFunc)

rho_infinity = 0.1;
eta = 0.2;

myfun = @(x)penalty(x, T, initialF, alphas, betas, vols, crossVolFunc);
x0 = [rho_infinity, eta];
options = optimset('display', 'iter');
param = fminsearch(myfun, x0, options)

rho_infinity = param(1);
eta = param(2);
M = length(T);
i = repmat(1:M,M,1);
j = repmat((1:M)',1,M);
corrMatrix = CorrFunction2Param(i, j, M, rho_infinity, eta);

modelApproxVols = zeros(size(vols));
for i = 1:length(alphas)
    alpha = alphas(i);
    beta = betas(i);    
    modelApproxVols(i) = SwapVolApprox(alpha, beta, T, initialF, corrMatrix, crossVolFunc);     
end
[xq,yq] = meshgrid(T(alphas(1)):T(alphas(end)), ...
                   (T(alphas(1))+T(betas(1))):(T(alphas(end))+T(betas(end))));
               
zq = griddata(T(alphas),T(betas),vols,xq,yq);
surf(xq, yq, zq); 
hold on;
zq2 = griddata(T(alphas),T(betas),modelApproxVols,xq,yq);
mesh(xq, yq, zq2,'facecolor','none'); 

xlabel('T_\alpha')
ylabel('T_\beta')
plot3(T(alphas),T(betas),vols,'LineStyle','none','Marker','s','MarkerFaceColor','g')
plot3(T(alphas),T(betas),modelApproxVols,'LineStyle','none','Marker','o','MarkerFaceColor','k')
legend('interpolated market vols','interpolated model vols',...
    'market vols', 'fitted model vols');


function value = penalty(param, T, initialF, alphas, betas, vols, crossVolFunc)
rho_infinity = param(1);
eta = param(2);
M = length(T);
i = repmat(1:M,M,1);
j = repmat((1:M)',1,M);
corrMatrix = CorrFunction2Param(i, j, M, rho_infinity, eta);

value = 0;
for i = 1:length(alphas)
    marketVol = vols(i);
    alpha = alphas(i);
    beta = betas(i);    
    modelVol = SwapVolApprox(alpha, beta, T, initialF, corrMatrix, crossVolFunc);
    value = value + (modelVol - marketVol)^2;
end