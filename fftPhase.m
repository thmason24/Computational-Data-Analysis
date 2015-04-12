clear all; close all; clc;

T=30;
n=128;
freq=2;
t2=linspace(-T/2,T/2,n+1); t=t2(1:n);

phase = pi;

u=zeros(size(t));
u(freq)=1;
%set first bin to 1 with phase

subplot(4,1,1)
plot(u)

subplot(4,1,2)
plot(t,real((ifft(u))))

%add phase
g=u;
u(freq)=1*exp(i * phase);

subplot(4,1,3)
plot(t,real(ifft(u)))

subplot(4,1,4)
plot(t,real(ifft(g+u)))


