clear all ;   close all ; clc; 
load Testdata

L=15; % spatial domain 
n=64; % Fourier modes 
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x; 
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k); 

[X,Y,Z]=meshgrid(x,y,z); 
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);  %fftshifted grid

UTsum = zeros([64 64 64]);
for j=1:20
Un(:,:,:)=reshape(Undata(j,:),n,n,n); 
Unf = fftn(Un);
UTsum = UTsum + Unf;
end

UTsum = fftshift(UTsum);


%filter location using max point

[maxVal index] = max(UTsum(:));

centerKx=Kx(index);
centerKy=Ky(index);
centerKz=Kz(index);

%generate filter and denoise data
%filter size should be the resolution which is the domain size divided by the number of fourier modes 
filterSize=2*max(k)/numel(k);
filterSize = 0.5;
%filter values came from visually inspecting isosurface of average spectum
filter = exp(-(((Kx-centerKx).^2)+((Ky-centerKy).^2)+((Kz-centerKz).^2))/filterSize);

subplot(2, 1, 1)
marble = zeros([20 3]);
for i=1:20
    Un(:,:,:)=reshape(Undata(i,:),n,n,n); 
    %denoise
    UTnf = (ifftn(ifftshift(filter.*fftshift(fftn(Un)))));  
    UTnf = UTnf / max(UTnf(:));
    [maxVal index] = max(abs(UTnf(:)));
    isoValue = 0.95 * maxVal;
    marble(i,:)=[X(index) Y(index) Z(index)];
    selected=(abs(UTnf)>0.95); 
    
    scatter3(X(selected),Y(selected),Z(selected),20,abs(UTnf(selected)))
    xlabel('X'); ylabel('Y'); zlabel('Z');
    axis([-20 20 -20 20 -20 20]), grid on, drawnow
    pause(0.1)

end
marble
%figure(4)
subplot(2, 1, 2)
plot3(marble(:,1),marble(:,2),marble(:,3))
xlabel('X'); ylabel('Y'), zlabel('Z')