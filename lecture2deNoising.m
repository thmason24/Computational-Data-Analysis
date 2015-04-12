clear all; close all; clc;
T=30;
n=512;
t2 = linspace(-T/2,T/2,n+1); t=t2(1:n);
k=(2*pi/T)*[0:n/2-1 -n/2:-1];
ks=fftshift(k);
u=sech(t);
ut=fft(u);
noise = 20;

utn=ut+noise*(randn(1,n)+i*randn(1,n));
un=ifft(utn);
filter = exp(-((k).^2));
utnf = filter.*utn;
unf=ifft(utnf);
subplot(2,1,1),plot(t,abs(unf),'g',t,0*t+0.5,'k:')
axis([-15 15 0 1])

subplot(2,1,2),plot(...
    ks,abs(fftshift(utn))/max(abs(fftshift(utn))),'m',...
    ks,fftshift(filter),'b', ...
    ks,abs(fftshift(utnf))/max(abs(fftshift(utnf))),'g')
axis([-25 25 0 1])