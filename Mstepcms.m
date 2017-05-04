%% Mstep
function [means,covs,priors]=Mstep(Y,gamma_z)
K=size(gamma_z,2);
N_k=sum(gamma_z);
D=size(Y,2);
N=size(Y,1);
means=zeros(K,D);
tempcov=zeros(D,D,N);
covs=zeros(D,D,K);
for k=1:K
    means(k,:)=1/N_k(k).*sum([gamma_z(:,k).*Y(:,1) gamma_z(:,k).*Y(:,2)]);
    X_demaned = Y - repmat(means(k,:),N,1);
    covs(:,:,k) = (X_demaned.*repmat(q(:,k),1,D))'*X_demaned
%     means(i,:)=1/N_k(i).*sum(gamma_z(:,i).*Y);
    for n=1:N
        tempcov(:,:,n)=gamma_z(n,k)*((Y(n,:)-means(k,:))'*(Y(n,:)-means(k,:)));    
    end
    covs(:,:,k)=1/N_k(k).*sum(tempcov,3);
end

priors=N_k/N;
