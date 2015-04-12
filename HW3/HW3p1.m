clear all; close all;  clc;

%for octave add image package
%pkg load image

A=imread('derek2.jpg');


%Abw=rgb2gray(A);
Abw=double(A(size(A,1):-1:1,:));    %converts from uint8 to double
noise = 0;
Abws=Abw; %+ noise*randn(size(Abw));

%figure(1)
%pcolor(Abws),shading interp, colormap(hot)

figure(2)
Abwt=fftshift(fft2(Abws));
pcolor(log(abs((Abwt)))), shading interp, colormap(hot)

%denoise 

x=1:size(Abwt,2);
y=1:size(Abwt,1);
[X,Y] = meshgrid(x,y);
sigma=0.01;
filter=exp(-sigma*(X-size(x,2)/2).^2-sigma*(Y-size(y,2)/2).^2);
Abwtf = Abwt.*filter;



figure(3)
pcolor(log(abs(Abwtf))), shading interp, colormap(hot)


figure(4)
%Abwdn = ifft2((Abwtf));
%pcolor((abs(Abwdn))), shading interp, colormap(hot)

subplot(2,6,1),imshow(A)
axis ('off')
subplot(2,6,2),pcolor(log(abs((Abwt)))), shading interp, colormap(hot)
axis ('off')

%widths = [10,100,1000,10000,100000];
widths = linspace(1000,10000,5);

for i = 1:5

sigma=1/widths(i);
filter=exp(-sigma*(X-size(x,2)/2).^2-sigma*(Y-size(y,2)/2).^2);
Abwtf = Abwt.*filter;
Abwdn = ifft2((Abwtf));
subplot(2,6,(2*(i-1))+3),pcolor((abs((Abwdn)))), shading interp, colormap(gray)
axis ('off')
subplot(2,6,(2*(i-1))+4),pcolor(log(abs((Abwtf)))), shading interp, colormap(gray)
axis ('off')
end

%subplot(1,2,1),imshow(A)
%subplot(1,2,2),imshow(uint8(real(Abwdn(size(A,1):-1:1,:))))
