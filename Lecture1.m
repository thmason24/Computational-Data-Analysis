clear all; close all; clc;

L=20;
n=128;

x2 = linspace(-L/2,L/2,n+1); x=x2(1:n);
k=(2*pi/L)*[0:n/2-1 -n/2:-1];

u=exp(-x.^2);
ut=fft(u);

plot(fftshift(k),abs(fftshift(ut)))

