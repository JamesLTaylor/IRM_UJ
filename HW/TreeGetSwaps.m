function [rates, pvbps] = TreeGetSwaps(zBonds)
pvbps = sum(zBonds(:,2:end),2)*0.25;
rates = (zBonds(:,1) - zBonds(:,end))./pvbps;