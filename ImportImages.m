clear all; close all;  clc;

A=imread('Lena.jpg');
%Abw=rgb2gray(A);
Abw=double(A(size(A,1):-1:1,:));    %converts from uint8 to double
noise = 0;
Abws=Abw + noise*randn(size(Abw));

figure(1)
pcolor(Abws),shading interp, colormap(hot)

figure(2)
Abwt=fftshift(fft2(Abws));
pcolor(log(abs((Abwt)))), shading interp, colormap(hot)

%denoise 

x=1:size(Abwt,2);
y=1:size(Abwt,1);
[X,Y] = meshgrid(x,y);
sigma=0.0001;
filter=exp(-sigma*(X-size(x,2)/2).^2-sigma*(Y-size(y,2)/2).^2);
Abwtf = Abwt.*filter;



figure(3)
pcolor((abs(Abwtf))), shading interp, colormap(hot)


figure(4)
Abwdn = ifft2((Abwtf));
pcolor((abs(Abwdn))), shading interp, colormap(hot)

subplot(2,2,1),imshow(A)
subplot(2,2,2),imshow(uint8(real(Abws(size(A,1):-1:1,:))))
subplot(2,2,3),imshow(uint8(real(Abwdn(size(A,1):-1:1,:))))


