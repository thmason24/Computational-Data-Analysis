clear all; close all; clc;

x=linspace(-10,10,100);
t=linspace(0,10,30);
[X,T]=meshgrid(x,t);

f=sech(X).*(1-0.5*cos(2*T))+(sech(X).*tanh(X)).*(1-0.5*sin(2*T));

subplot(2,2,1)
waterfall(X,T,f), colormap([0,0,0])

[u,s,v]=svd(f');


for j=1:3
    ff=u(:,1:j)*s(1:j,1:j)*v(:,1:j)';
    
    subplot(2,2,j+1)
    waterfall(X,T,ff'), colormap([0,0,0])
end


figure(2)

%is it low dimensional?  plot diag of s
plot(diag(s),'ko')

figure(3)
%what do modes look like?
plot(x,u(:,1), 'k',  x , u(:,2), 'r')

figure(4)
%what are modes doing in time?
plot(t,v(:,1), 'k',  t , v(:,2), 'r')
