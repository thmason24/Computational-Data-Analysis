clear all; close all; clc;

A = imread('Eric_Mason.jpg');
Abw=rgb2gray(A);
Abw = double(Abw(size(A,1):-1:1,:));
Abwt = fftshift(fft2(Abw));

subplot(2,2,1)

pcolor(log(abs(((Abwt))))), shading interp, colormap(hot)

subplot(2,2,2)

imshow(A)

subplot(2,2,3)

pcolor(ifft2(ifftshift(Abwt))), shading interp, colormap(gray)

subplot(2,2,4)

imshow(rgb2gray(A))