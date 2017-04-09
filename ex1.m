%% load data
%cd('C:\Users\Mirone\Desktop\Aarhus Uni\Dropbox\Exe\Exe_matlab')
clc; clear; close all;
pwi=csvread('pwi.csv');
dwi=csvread('dwi.csv');
mask=csvread('mask.csv');
%% show image
% pwiIM=imshow(pwi,[0 33]);
% dwiIM=imshow(dwi,[0 800]);

pwiIM=imagesc(pwi);     %show image in color limit scale to significant values?
figure
dwiIM=imagesc(dwi);     %show image in color limit scale to significant values?
colormap(gray) %set the colormap to gray scale

%% Extract data for analysis
% N = sum(mask(:)==1);
Y=[pwi(mask(:)==1) dwi(mask(:)==1)];
Y_z=zscore(Y);
%% Perform k-means analysis
% K=3;
initial_centroids=[max(Y(:,1)) min(Y(:,2)); min(Y(:,1)) max(Y(:,2)); mean(Y(:,1)) mean(Y(:,2))];
[centroids, idx]=runkMeans(Y,initial_centroids,100,1);


% initial_centroids_std=[max(Y_z(:,1)) min(Y_z(:,2)); min(Y_z(:,1)) max(Y_z(:,2)); mean(Y_z(:,1)) mean(Y_z(:,2))];
initial_centroids_std=[max(Y_z(:,1)) min(Y_z(:,2)); min(Y_z(:,1)) max(Y_z(:,2)); mean(Y_z(:,1)) mean(Y_z(:,2))];
[centroids_std, idx_std]=runkMeans(Y_z,initial_centroids_std,100,1);

%% Create image of the results
segmented=zeros(size(pwi,2),size(dwi,1));
segmented_std=segmented;
segmented(mask==1)=idx;
segmented_std(mask==1)=idx_std;
imagesc(segmented)
figure
imagesc(segmented_std)
colormap(hot)
%% Run EM algorithm
[gamma_z,~,~,~]=EMalgorithm(Y,3,100);

%%Create image of the results
segmented1=zeros(size(pwi,2),size(dwi,1));
segmented2=zeros(size(pwi,2),size(dwi,1));
segmented3=zeros(size(pwi,2),size(dwi,1));
segmented1(mask==1)=gamma_z(:,1);
imagesc(segmented1)
figure
segmented2(mask==1)=gamma_z(:,2);
imagesc(segmented2)
figure
segmented3(mask==1)=gamma_z(:,3);
imagesc(segmented3)

