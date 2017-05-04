%% load data
%cd('C:\Users\Mirone\Desktop\Aarhus Uni\Dropbox\Exe\Exe_matlab')
clc; clear; close all;

anatomical=csvread('anatomical.csv',1,1);
anatomical=reshape(anatomical,256,256,256);
%% show image
S=input('Choose slice for the analysis S:\n');

imagesc(anatomical(:,:,S));

%% Extract data for analysis
slice=anatomical(:,:,S);
Y=slice(slice>0);
Y_z=zscore(Y);
%% Perform k-means analysis
for K=10:-1:1
    [~,~,sumDK_z]=kmeans(Y_z,K);
    sumD_z(K)=sum(sumDK_z);
end
plot(1:10,sumD_z,'.-','markersize',12)
K=input('Choose the number of clusters K:\n');
if ~isnumeric(K)||K<2
    error('K must be an integer bigger than 1')
end
[idx,centroid]=kmeans(Y,K);
[idx_z,centroid_z]=kmeans(Y_z,K);


%% Create image of the results
segmented=zeros(size(slice));
segmented_std=segmented;
segmented(slice>0)=idx;
segmented_std(slice>0)=idx_z;
imagesc(segmented)
figure
imagesc(segmented_std)
% colormap(hot)
%% Run EM algorithm
[gamma_z,means,covs,posteriors]=EMalgorithm(Y,K,100);

%%Create image of the results
for i=1:K
    figure
    segmented1=zeros(size(slice));
    segmented1(slice>0)=gamma_z(:,i);
    imagesc(segmented1)
end
N=input('Choose the new slice S:\n');

slice2=anatomical(:,:,N);
Y2=slice2(slice2>0);
gamma_z2=Estep(Y2,means,covs,posteriors);
for i=1:K
    figure
    segmented1=zeros(size(slice2));
    segmented1(slice2>0)=gamma_z2(:,i);
    imagesc(segmented1)
end