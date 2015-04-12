%clear all; close all ; clc;

close all;
clc;

load('cam2_1.mat')
%load('cam2_2.mat')
%load('cam2_3.mat')
%load('cam2_4.mat')
%load('cam3_1.mat')
%load('cam3_2.mat')
%load('cam3_3.mat')
%load('cam3_4.mat')




numFrames = numel(vidFrames2_1(1,1,1,:));

for k = 1 : numFrames
       mov(k).cdata = vidFrames2_1(:,:,:,k);
       mov(k).colormap = [];
       frames(:,:,:,k)=double(rgb2gray(imresize(frame2im(mov(k)),0.1)));  
       frameVec(:,k)=reshape(frames(:,:,k),numel(frames(:,:,k)),1);  
end

DSsize=size(frames(:,:,1));

%first use SVD to find modes to subtract
%pcolor(frames(:,:,1,1)) , shading interp, colormap(gray)

%for j=1:numFrames
 %   pcolor(frames(:,:,1,j)) , shading interp, colormap(gray), drawnow
%end

[u,s,v]=svd(frameVec,0);

%subplot(1,2,1) ; semilogy(s , 'ko')
%subplot(1,2,2) ; plot(s(1:10) , 'ko')

modes=u*s;
%modes=modes-min(modes(:));
%modes=255*(modes/max(modes(:)));

%low rank approximatio

for j=1:4
rank=j;
approx = u(:,1:rank)*s(1:rank,1:rank)*v(:,1:rank)';
subplot(2,2,j)
imshow(uint8(reshape(frameVec(:,1)-approx(:,1),DSsize))) , drawnow
end

rank=10;
approx = u(:,1:rank)*s(1:rank,1:rank)*v(:,1:rank)';
aveImage=mean(frameVec,2);


fig=figure(2);
for j=1:numFrames/4
    % resize the figure window
    %set(fig,'units','inches','position', [5 5 20 30])
    %subplot(1,2,1)
    subBG=frameVec(:,j)-approx(:,j);
    subBG=frameVec(:,j);
    thresh=0.995;
    subBGthresh=subBG;
    subBGthresh(subBG<max(subBG(:))*thresh)=0;
    imshow(imresize(uint8(reshape(subBGthresh,DSsize)),10),[]) , drawnow
    %imshow(imresize(uint8(reshape(frameVec(:,j),DSsize)),10),[]) , drawnow
        
    %subplot(1,2,2)
    %imshow(imresize(uint8(reshape(frameVec(:,j)-aveImage,DSsize)),10),[]) , drawnow
end

break


for j=1:numFrames
 X=frame2im(mov(j));
 imshow(X); 
 Xbw=rgb2gray(X);
 %take SVD of each frame and remove the major modes
 Xd=double(Xbw(size(X,1):-1:1,:));
 nw=numel(Xd);
 [u,s,v] = svd(reshape(Xd,nw));
 subplot(1,3,1)
 pcolor(Xd) , shading interp, colormap(gray)
 subplot(1,3,2)
 pcolor(u) , shading interp, colormap(gray)
 subplot(1,3,3)
 pcolor(Xd) , shading interp, colormap(gray)

 
  break
end
break
%trim image


for j=2:numFrames
 X=frame2im(mov(j));
 G=rgb2gray(X);
 xdir=sum(G,1);
 ydir=sum(G,2);
 subplot(1,2,1)
 plot(xdir); drawnow
 subplot(1,2,2)
 plot(ydir); drawnow
end



