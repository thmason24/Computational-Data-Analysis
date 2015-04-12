clear all; close all ; clc;


%load('cam1_1.mat')  %sucks
%load('cam1_2.mat')   %sucks
%load('cam1_3.mat')  %sucks
%load('cam1_4.mat')  %sucks
load('cam2_1.mat')   %decent
%load('cam2_2.mat')    %decent
%load('cam2_3.mat')  %good
%load('cam2_4.mat')  %good
load('cam3_1.mat')
%load('cam3_2.mat')
%load('cam3_3.mat')
%load('cam3_4.mat')

video_1=vidFrames2_1;
video_2=vidFrames3_1;

size(video_1)
size(video_2)

videos = { video_1, video_2 };
for i = 1:2
    video=videos{i};
    numFrames = numel(video(1,1,1,:));
    numFrameRec(i)=numFrames;
    for k = 1 : numFrames
       mov(k).cdata = video(:,:,:,k);
       mov(k).colormap = [];
       frames(i,:,:,k)=double(rgb2gray(imresize(frame2im(mov(k)),0.1)));
       DSsize=size(squeeze(frames(i,:,:,1)));
       frameVec(i,:,k)=reshape(frames(i,:,:,k),numel(frames(i,:,:,k)),1); 
       [M,I] = max(frameVec(i,:,k));
       [x(i,k),y(i,k)]=ind2sub(DSsize,I);
    end
end

if numFrameRec(1) > numFrameRec(2)
    x1=x(1,:);
    y1=y(1,:);
    x2=x(2,1:numFrameRec(2));
    y2=y(2,1:numFrameRec(2));
else
    x2=x(2,:);
    y2=y(2,:);
    x1=x(1,1:numFrameRec(1));
    y1=y(1,1:numFrameRec(1));    
end

subplot(2,2,1); plot(x1)
subplot(2,2,2); plot(y1)
subplot(2,2,3); plot(x2)
subplot(2,2,4); plot(y2)

break




%play video
if 1==2
    for j=1:numFrames
        subBG=frameVec(1,:,j);
        thresh=0.999;
        subBGthresh=subBG;
        subBGthresh(subBG<max(subBG(:))*thresh)=0;
        imshow(imresize(uint8(reshape(subBGthresh,DSsize)),10),[]) , drawnow
    end
end

 
%subplot(1,2,1) ; semilogy(s , 'ko')
%subplot(1,2,2) ; plot(s(1:10) , 'ko')