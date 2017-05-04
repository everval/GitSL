%% Mstep
function [means,covs,priors]=Mstep(Y,gamma_z)
K=size(gamma_z,2);
N_k=sum(gamma_z);
D=size(Y,2);
N=size(Y,1);
means=zeros(K,D);
covs=zeros(D,D,K);
for k=1:K
    means(k,:)=1/N_k(k).*sum(repmat(gamma_z(:,k),1,D).*Y);
end

for k=1:K
    X_demeaned = Y - repmat(means(k,:),N,1);
    covs(:,:,k) = (X_demeaned.*repmat(gamma_z(:,k),1,D))'*X_demeaned;
    covs(:,:,k)=1/N_k(k).*sum(covs,3);
end

priors=N_k/N;
