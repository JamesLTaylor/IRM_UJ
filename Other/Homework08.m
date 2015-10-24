F = rates;
tau = diff([0 T]);
requiredTau = repmat(tau(alpha+1:beta), size(F,1), 1);
forwardDfs = cumprod(1./(1+requiredTau.*F(:,alpha+1:beta)),2);

deterministicDFs = cumprod(1./(1+tau(alpha+1:beta).*initialF(:,alpha+1:beta)),2); 
deterministicDFs = repmat(deterministicDFs,size(F,1),1);

test = rates(:,alpha+1:beta).*forwardDfs./deterministicDFs;
plot(mean(test,1)-0.07)
hold on
plot(mean(rates(:,alpha+1:beta)-0.07,1))
