clear all; close all; clc;
% 
%  tr_piano=16;  % record time in seconds
%  y=audioread('music1.wav'); Fs=length(y)/tr_piano;
%  plot((1:length(y))/Fs,y);
%  xlabel('Time [sec]'); ylabel('Amplitude');
%  title('Mary had a little lamb (piano)');  drawnow
%  %p8 = audioplayer(y,Fs); playblocking(p8);

 figure(2)
 tr_rec=14;  % record time in seconds
 y=audioread('music2.wav'); Fs=length(y)/tr_rec;
 plot((1:length(y))/Fs,y);
 xlabel('Time [sec]'); ylabel('Amplitude');
 title('Mary had a little lamb (recorder)');
 %p8 = audioplayer(y,Fs); playblocking(p8);
 
v=y'/2;

%gabor window
t=1:length(v);
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k); 

%width=10000000;
width = 10000000;
slide=0:10000:length(v);
spec=[];
figure(4)
for j=1:length(slide)
    %gaussian
    f=exp(-(1/width)*(t-slide(j)).^2); 
    %mexican hat
    sig = width;
    %f=10*(2/(sqrt(3*sig)*pi^0.25))...
     %   *(1-((t-slide(j)).^2)/sig.^2)...
      %  .*exp(-((t-slide(j)).^2)/(2*sig.^2));
    %step
    %f=zeros(size(t));
    %f( (t-slide(j)) < width  & (t-slide(j)) > -width) = 1;
    %f( (t) < width  & (t) > -width) = 1;
    %f( t > width ) = 1;
    %plot(f)
    
    %f((t-slide(j))<(-width)=0
    %f((t-slide(j))>width )=0;
    vf=f.*v;
    vft=fft(vf);
    
    subplot(3,1,1),   plot(t/Fs,v,'k',t/Fs,f,'m')
    subplot(3,1,2),   plot(t/Fs,vf,'k') 
    subplot(3,1,3),   plot((t),real(fftshift(vft)/max(abs(vft))))
    axis([-60 60 0 1])
    drawnow
    %pause(0.1)

    spec = [spec; abs(fftshift(vft))];
    
end

figure(2)

pcolor(slide,t,spec.'), shading interp
set(gca,'Ylim',[2.9e5 3.1e5], 'Fontsize',[14])
colormap(hot)
colorbar
xlabel('t')
ylabel('omega')
