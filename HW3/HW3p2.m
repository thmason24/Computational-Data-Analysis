clear all; close all;  clc;
%clean up color photo of derek zoolander
%for octave add image package
%pkg load image


A=imread('derek1.jpg');
Abw=double(A);    %converts from uint8 to double

red = (Abw(:,:,1));
green = (Abw(:,:,2));
blue = (Abw(:,:,3));

redt=fftshift(fft2(red));
greent=fftshift(fft2(green));
bluet=fftshift(fft2(blue));

%denoise 

x=1:size(redt,2);
y=1:size(redt,1);
[X,Y] = meshgrid(x,y);


figure(1)

subplot(3,2,1),imshow(A)
axis ('off')
title('Original')

%widths = [10,100,1000,10000,100000];
widths = linspace(1000,10000,5);

for i = 1:5
	sigma=1/widths(i);
	filter=exp(-sigma*(X-size(x,2)/2).^2-sigma*(Y-size(y,2)/2).^2);
	redtf = redt.*filter;
	greentf = greent.*filter;
	bluetf = bluet.*filter;

	reddn= ifft2(redtf);
	greendn= ifft2(greentf);
	bluedn= ifft2(bluetf);
	if (1==2)
		subplot(3,6,(3*(i-1))+4),pcolor(abs(reddn)), shading interp, colormap(gray), drawnow
		axis ('off')
		subplot(3,6,(3*(i-1))+5),pcolor(abs(greendn)), shading interp, colormap(gray), drawnow
		axis ('off')
		subplot(3,6,(3*(i-1))+6),pcolor(abs(bluedn)), shading interp, colormap(gray), drawnow
		axis ('off')
    end
    
	if (1==2)
		derekDN = zeros(size(A));
		derekDN(:,:,1)=reddn;
		derekDN(:,:,2)=greendn;
		derekDN(:,:,3)=bluedn;
		derekDN = uint8(abs(derekDN));
		subplot(3,2,i+1), imshow(derekDN)
		title(['filter width ' num2str(widths(i))]), drawnow
    end
end


figure(2)
%plot side by side
subplot(1,2,1),imshow(A)
axis ('off')
title('Original')

%filter width
width = 2000
sigma=1/width;
filter=exp(-sigma*(X-size(x,2)/2).^2-sigma*(Y-size(y,2)/2).^2);
redtf = redt.*filter;
greentf = greent.*filter;
bluetf = bluet.*filter;

reddn= ifft2(redtf);
greendn= ifft2(greentf);
bluedn= ifft2(bluetf);

derekDN = zeros(size(A));
derekDN(:,:,1)=reddn;
derekDN(:,:,2)=greendn;
derekDN(:,:,3)=bluedn;
derekDN = uint8(abs(derekDN));
subplot(1,2,2), imshow(derekDN)
title(['filter width ' num2str(width)]), drawnow




%subplot(1,2,1),imshow(A)
%subplot(1,2,2),imshow(uint8(real(Abwdn(size(A,1):-1:1,:))))