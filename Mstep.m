%% Mstep
function [means,covs,priors]=Mstep(Y,gamma_z)
K=size(gamma_z,2);
N_k=sum(gamma_z);
D=size(Y,2);
N=size(Y,1);
means=zeros(K,D);
tempcov=zeros(D,D,N);
covs=zeros(D,D,K);
for i=1:K
    means(i,:)=1/N_k(i).*sum([gamma_z(:,i).*Y(:,1) gamma_z(:,i).*Y(:,2)]);
%     means(i,:)=1/N_k(i).*sum(gamma_z(:,i).*Y);
    for n=1:N
        tempcov(:,:,n)=gamma_z(n,i)*((Y(n,:)-means(i,:))'*(Y(n,:)-means(i,:)));    
    end
    covs(:,:,i)=1/N_k(i).*sum(tempcov,3);
end

priors=N_k/N;
