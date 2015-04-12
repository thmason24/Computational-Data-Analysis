clear all ;   close all ; clc; 
load marble.mat

%marble = zeros(size(marble));

L=15; % spatial domain 
n=64; % Fourier modes 
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x; 
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k); 

[X,Y,Z]=meshgrid(x,y,z); 
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);  %fftshifted grid

%generate UNData from marble location and added noise
noise=0;
width=0.5;
UnData=zeros(20,64,64,64);
for j=1:20
%add marble location
UnData(j,:,:,:)=ones(64,64,64).*exp(-((X-marble(j,1)).^2 + (Y-marble(j,2)).^2 + (Z-marble(j,3)).^2)/width);
end

UTsum=zeros(64,64,64);
for j=1:20
Un=squeeze(UnData(j,:,:,:)); 
% add noise
Unf = fftn(Un) + noise*(randn(size(Un)) + i*randn(size(Un)));;
UTsum = UTsum + Unf;
end
UTsum = fftshift(UTsum);
UTsum = UTsum/max(abs(UTsum(:)));
%figure('units','normalized','outerposition',[0 0 1 1])
%subplot(2, 2, 1)

for isoValue = 0.4
    subplot(2,2,1)
    isosurface(Kx,Ky,Kz,(abs(UTsum)),isoValue)
    axis([-7 7 -7 7 -7 7]), grid on , view(0,0), drawnow
    xlabel('kx'); ylabel('ky'), zlabel('kz')
    
    subplot(2,2,2)
    isosurface(Kx,Ky,Kz,(abs(UTsum)),isoValue)
    axis([-7 7 -7 7 -7 7]), grid on , view(0,90), drawnow
    xlabel('kx'); ylabel('ky'), zlabel('kz')    
    
    subplot(2,2,3)
    isosurface(Kx,Ky,Kz,(abs(UTsum)),isoValue)
    axis([-7 7 -7 7 -7 7]), grid on , view(90,0), drawnow
    xlabel('kx'); ylabel('ky'), zlabel('kz')    
    
    subplot(2,2,4)
    isosurface(Kx,Ky,Kz,(abs(UTsum)),isoValue)
    axis([-7 7 -7 7 -7 7]), grid on , view(90,90), drawnow
    xlabel('kx'); ylabel('ky'), zlabel('kz')    
end

break

%filter location from using data cursor on the blob from the isosurface
%plot

centerKx=1.92;
centerKy=-1;
centerKz=-0;

%generate filter and denoise data
%filter size should be the resolution which is the domain size divided by the number of fourier modes 
filterSize=2*max(k)/numel(k);
filterSize = 0.5;
fprintf('Center Frequency %d %d %d\n', centerKx, centerKy, centerKz)
fprintf('fourier domain %d %d\n', min(k), max(k))
fprintf('filter size %f \n', filterSize)

%filter values came from visually inspecting isosurface of average spectum
filter = exp(-(((Kx-centerKx).^2)+((Ky-centerKy).^2)+((Kz-centerKz).^2))/filterSize);


figure(2)
%subplot(2, 2, 3)
marble = zeros([20 3]);
for i=1:20
    Un(:,:,:)=squeeze(UnData(i,:,:,:)); 
    %denoise
    UTnf = (ifftn(ifftshift(filter.*fftshift(fftn(Un)))));  
    UTnf = UTnf / max(UTnf(:));
    [maxVal ind] = max(abs(UTnf(:)));
    [mx my mz] = ind2sub(size(UTnf),ind);
    isoValue = 0.95 * maxVal;
    marble(i,:)=[X(ind) Y(ind) Z(ind)];
    selected=(abs(UTnf)>0.99);
    size(UTnf(selected));
    scatter3(X(selected),Y(selected),Z(selected),20,abs(UTnf(selected)))
    view(90,0)
    xlabel('X'); ylabel('Y'), zlabel('Z')
    axis([-20 20 -20 20 -20 20]), grid on, drawnow
    pause(0.1)

end
figure(3)
%subplot(2, 2, 4)
plot3(marble(:,1),marble(:,2),marble(:,3))
xlabel('X'); ylabel('Y'), zlabel('Z')
