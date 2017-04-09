%% EM algorithm
function [gamma_z,means,covs,priors]=EMalgorithm(Y,K,MaxIts)
%% Initilaise the mixture
D=size(Y,2);
% means = mean(Y)+randn(K,D);
means =repmat(mean(Y),K,1) + randn(K,D);
covs=zeros(D,D,K);
for k = 1:K
    covs(:,:,k) = rand*cov(Y).*eye(D);
end
priors = repmat(1/K,1,K);
% tol = 1e-4;
conv=0;
count=1;
while count<=MaxIts && conv~=1
    gamma_z=Estep(Y,means,covs,priors);
%     means_lag=means;
    [means,covs,priors]=Mstep(Y,gamma_z);
    count=count+1;
%     if all(means-means_lag)<=tol
%         conv=1;
%     end
end
