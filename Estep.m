function [gamma_z]=Estep(Y,means,covs,priors)
N=size(Y,1);
K=numel(priors);
pdf_k=zeros(N,K);

for i=1:K
    pdf_k(:,i)=mvnpdf(Y,means(i,:),covs(:,:,i));
end
% gamma_z=(priors.*pdf_k)./sum(priors.*pdf_k,2);
gamma_z=(repmat(priors,N,1).*pdf_k)./repmat(sum(repmat(priors,N,1).*pdf_k,2),1,K);
% Minor hack for numerical issues - stops the code crashing when
% clusters are empty
gamma_z(gamma_z<1e-60) = 1e-60;
gamma_z(gamma_z>1-1e-60) = 1e-60;
