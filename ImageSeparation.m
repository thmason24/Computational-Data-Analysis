clear all; close all; clc;

S1=imread('Eric_mason.jpg');
S2=imread('derek3.jpg');
S1=S1(1:size(S2,1),1:size(S2,2),:);

subplot(3,2,1), imshow(S1)
subplot(3,2,2), imshow(S2)

beta = 3/5;
A=[4/5 beta; 1/2 2/3];

X1=double(A(1,1)*S1+A(1,2)*S2);
X2=double(A(2,2)*S1+A(2,2)*S2);

subplot(3,2,3), imshow(uint8(X1));
subplot(3,2,4), imshow(uint8(X2));

% first find inverse U vector by finding the angle of maximum variance

[m,n]=size(X1);
x1=reshape(X1,m*n,1);
x2=reshape(X2,m*n,1);

x1=x1-mean(x1);
x2=x2-mean(x2);

theta0=0.5*atan( -2*sum(x1.*x2)/sum(x1.^2-x2.^2));
Us=[cos(theta0) sin(theta0);-sin(theta0) cos(theta0)];

% find inverse Z matrix by scaling by by the maximum variance

sig1=sum((x1*cos(theta0) + x2*sin(theta0)).^2);
sig2=sum((x1*cos(theta0-pi/2) + x2*sin(theta0-pi/2)).^2);
Sigma = [1/sqrt(sig1) 0 ;0 1/sqrt(sig2)];

% undo V matrix by enforcing statistical independence between the two
% images by forcing the kertosis to be minimum.
X1bar = Sigma(1,1)*(Us(1,1)*X1+Us(1,2)*X2);
X2bar = Sigma(2,2)*(Us(2,1)*X1+Us(2,2)*X2);

x1bar=reshape(X1bar,m*n,1);
x2bar=reshape(X2bar,m*n,1);

% forumula for minimized Kertosis from class notes
phi0=0.25*atan(-sum (2*(x1bar.^3).*x2bar -2*x1bar.*(x2bar.^3)) ...
    / sum(3*(x1bar.^2).*(x2bar.^2) - 0.5*(x1bar.^4)-0.5*(x2bar.^4)))

%kertosis explicitly
theta = -pi:0.01:pi;
for i = 1:numel(theta)
    kurt(i)=sum((([x1bar x2bar]*[cos(theta(i)) ; sin(theta(i))])).^4);
end
figure(2)
plot(theta,kurt)

[minkurt, index] = min(kurt)
phi0=theta(index)
break
V = [cos(phi0) sin(phi0); -sin(phi0) cos(phi0) ];

S1bar=V(1,1)*X1bar+V(1,2)*X2bar;
S2bar=V(2,1)*X1bar+V(2,2)*X2bar;

min1=min(S1bar(:)); 
S1bar=S1bar-min1; 
max1=max(S1bar(:)); 
S1bar=S1bar*(255/max1);

min2=min(S2bar(:)); 
S2bar=S2bar-min2; 
max2=max(S2bar(:)); 
S2bar=S2bar*(255/max2);

subplot(3,2,5), imshow(uint8(S1bar)) 
subplot(3,2,6), imshow(uint8(S2bar))

