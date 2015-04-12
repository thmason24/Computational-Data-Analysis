%clear all; close all ; clc;
close all;
clc;

load('cam2_1.mat')

numFrames = numel(vidFrames2_1(1,1,1,:));

for k = 1 : numFrames
       mov(k).cdata = vidFrames2_1(:,:,:,k);
       mov(k).colormap = [];
       frames(:,:,:,k)=double(rgb2gray(imresize(frame2im(mov(k)),0.1)));  
       frameVec(:,k)=reshape(frames(:,:,k),numel(frames(:,:,k)),1);  
end

DSsize=size(frames(:,:,1));

[u,s,v]=svd(frameVec,0);

modes=u*s;
%modes=modes-min(modes(:));
%modes=255*(modes/max(modes(:)));

%low rank approximatio
rank=1;
approx = u(:,1:rank)*s(1:rank,1:rank)*v(:,1:rank)';
vector1 = u(:,1:rank)*s(1:rank,1:rank).^2;
aveImage=mean(frameVec,2);

size(u(:,1:rank))
size(vector1)
size(s(1:rank,1:rank))
size(v(:,1:rank)')
size(approx)
size(aveImage)



fig=figure(2);
for j=1:numFrames/4
    % resize the figure window
    %set(fig,'units','inches','position', [5 5 20 30])
    %subplot(1,2,1)
    subBG=frameVec(:,j)-approx(:,j);
end

