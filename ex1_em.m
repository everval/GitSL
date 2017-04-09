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

%% Run EM algorithm
K = 3;
[gamma_z,~,~,~]=EMalgorithm(Y,K,100);

%%Create image of the results
segmented1=zeros(size(pwi,2),size(dwi,1));
segmented2=zeros(size(pwi,2),size(dwi,1));

figure
segmented1(mask==1)=gamma_z(:,1);
imagesc(segmented1)
figure
segmented2(mask==1)=gamma_z(:,2);
imagesc(segmented2)

if K == 3
    segmented3=zeros(size(pwi,2),size(dwi,1));
    figure
    segmented3(mask==1)=gamma_z(:,3);
    imagesc(segmented3)
end