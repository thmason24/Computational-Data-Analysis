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

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2, 2, 1)
for isoValue = 3800
    isosurface(Kx,Ky,Kz,(abs(UTsum)),isoValue)
    axis([-7 7 -7 7 -7 7]), grid on , drawnow
    xlabel('kx'); ylabel('ky'), zlabel('kz')
end

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
fprintf('filter size %f \n', filterSize)

%filter values came from visually inspecting isosurface of average spectum
filter = exp(-(((Kx-centerKx).^2)+((Ky-centerKy).^2)+((Kz-centerKz).^2))/filterSize);

%figure(2)
subplot(2, 2, 2)
isosurface(Kx,Ky,Kz,(abs((UTsum).*filter)),3800)
axis([-7 7 -7 7 -7 7]), grid on , drawnow
xlabel('kx'); ylabel('ky'), zlabel('kz')



if 1 == 2
    figure('units','normalized','outerposition',[0 0 1 1])
    colormap gray

    for thresh=3000

        threshUTsum = +(abs(UTsum) > thresh);
        if sum(threshUTsum(:)) == 0
            break
        end
        subplot(1,3,1)
        %pcolor(squeeze(abs(UTsum(choose,:,:))))
        pcolor(fftshift(squeeze(max(threshUTsum,[],1))))
        caxis([0 1])
        axis square

        subplot(1,3,2)
        %pcolor(squeeze(abs(threshUTsum(:,choose,:))))
        pcolor(fftshift(squeeze(max(threshUTsum,[],2))))
        caxis([0 1])
        axis square

        subplot(1,3,3)
        %pcolor(squeeze(abs(threshUTsum(:,:,choose))))
        pcolor(fftshift(squeeze(max(threshUTsum,[],3))))
        caxis([0 1])
        axis square

        pause(0.5)
    end
end

%figure(3)
subplot(2, 2, 3)
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
    xlabel('X'); ylabel('Y'), zlabel('Z')
    axis([-20 20 -20 20 -20 20]), grid on, drawnow
    pause(0.1)

end
save('marble.mat','marble')
%figure(4)
subplot(2, 2, 4)
plot3(marble(:,1),marble(:,2),marble(:,3))
xlabel('X'); ylabel('Y'), zlabel('Z')
marble