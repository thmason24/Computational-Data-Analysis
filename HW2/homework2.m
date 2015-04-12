clear all; close all; clc;

load handel
v=y'/2;
plot((1:length(v))/Fs,v);
xlabel('Time [sec]');
ylabel('Amplitude');
title('Signal of Interest, v(n)');

%p8 = audioplayer(v,Fs);
%playblocking(p8);
%fft
plot(abs(fftshift(fft(v))))

%gabor window

t=1:length(v);
%width=10000000;
width = 10000;
slide=0:500:length(v);
spec=[];
for j=1:length(slide)
    %gaussian
    %f=exp(-(1/width)*(t-slide(j)).^2); 
    %mexican hat
    sig = width;
    %f=10*(2/(sqrt(3*sig)*pi^0.25))...
     %   *(1-((t-slide(j)).^2)/sig.^2)...
      %  .*exp(-((t-slide(j)).^2)/(2*sig.^2));
    %step
    f=zeros(size(t));
    f( (t-slide(j)) < width  & (t-slide(j)) > -width) = 1;
    %f( (t) < width  & (t) > -width) = 1;
    %f( t > width ) = 1;
    %plot(f)
    
    %f((t-slide(j))<(-width)=0
    %f((t-slide(j))>width )=0;
    
    
    
    
    vf=f.*v;
    vft=fft(vf);
    
    subplot(3,1,1),   plot(t,v,'k',t,f,'m')
    subplot(3,1,2),   plot(t,vf,'k') 
    subplot(3,1,3),   plot(t,real(fftshift(vft)/max(abs(vft))))
    %axis([-60 60 0 1])
    drawnow
    pause(0.1)

    spec = [spec; abs(fftshift(vft))];
    
end

figure(2)

pcolor(slide,t,spec.'), shading interp
%set(gca,'Ylim',[-60 60], 'Fontsize',[14])
colormap(hot)
colorbar
xlabel('t')
ylabel('omega')
