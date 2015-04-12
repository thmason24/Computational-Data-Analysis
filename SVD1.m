clear all; close all; clc;

%low rank approximation

x = linspace(0,1,25);
t = linspace(0,2,50);

[T,X]=meshgrid(t,x);

f = exp(-abs((X-0.5).*(T-1)))+sin(X.*T);

subplot(2,2,1)
%plot original plot
surf(X,T,f)
%take svd
[u,s,v]=svd(f);


for j=1:3
    
    %each j adds another rank to the approximation
    
    ff=u(:,1:j)*s(1:j,1:j)*v(:,1:j)';
    
    subplot(2,2,j+1)
    surf(X,T,ff), 
    set(gca,'Zlim',[0.5 2])
    
    
end


figure(2)
%log plot of the singular values to show how quickly the approximation
%improves
semilogy(diag(s), 'ko')

figure(3)
%plot what the modes look like
plot(x,u(:,1), 'k', x,u(:,2), 'r', x,u(:,3), 'g' )

figure(4)
%plot how the mode move in time
plot(t,v(:,1), 'k', t,v(:,2), 'r', t,v(:,3), 'g' )
