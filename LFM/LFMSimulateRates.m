%
% Simulates forward rates under a Lognormal forward rate model. Assumes 
% measure date is T(kStart-1) so all required rates are after the measure
% date.
% 
% LFMSimulateRates(kStart, kEnd, initialF, T,...
%                    corrMatrix, volFunc,... 
%                    N, deltaT)
%
% kStart, kEnd  - the indices in T of the first and last required rates.
%                 To save time not all rates are simulated.
% initialF      - row vector of forward rates
% T             - row vector of tenor structure starting at T_1.  Assumes
%                 T_0 = 0
function rates = LFMSimulateRates(kStart, kEnd, initialF, T,...
                    corrMatrix, volFunc,... 
                    N, deltaT)
              
subMat = corrMatrix(kStart:kEnd, kStart:kEnd);
C = chol(subMat);
oldF = repmat(initialF,N,1);
logF = log(oldF);
tau = diff([0 T]);
t = 0;

while t<=T(kStart-1)    
    indIncrement = randn(N,(kEnd-kStart)+1);
    Z = indIncrement*C;
    for k = kStart:kEnd    
        sigmaK = volFunc(t, k);

        drift = 0;
        for j = kStart:k
            newDriftTerm = corrMatrix(k, j)*tau(j)*volFunc(t, j)*oldF(:,j);
            newDriftTerm = newDriftTerm ./ (1+tau(j) * oldF(:,j));
            drift = drift + newDriftTerm;
        end
        drift = drift * sigmaK;
        logF(:,k) = logF(:,k) + drift * deltaT - 0.5*sigmaK^2*deltaT + sigmaK*sqrt(deltaT)*Z(:, k-kStart+1);    
    end
    oldF = exp(logF);
    t = t + deltaT;
end
rates = oldF;