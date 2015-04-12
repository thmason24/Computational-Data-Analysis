clear all ; close all; clc;
 

T=60;
n=512;

t2 = linspace(-T/2,T/2,n+1); t=t2(1:n);
k=(2*pi/T)*[0:n/2-1 -n/2:-1];
ks=fftshift(k);

slice=[0:0.5:10];
[T,S] = meshgrid(t,slice);
[K,S] = meshgrid(k,slice);

U=sech(T-10*sin(S)).*exp(1i*0*T);
subplot(2,1,1)
waterfall(T,S,abs(U)), colormap([0 0 0]), view(-15,70)

noise = 10;
for j=1:length(slice)
   UT(j,:)=(fft(U(j,:))+noise*(randn(1,n)+i*randn(1,n)));
   UN(j,:)=ifft(UT(j,:));
end

%in this example,  a signal is moving in the time domain,  this is showing
%that only in the fourier doman can you sum repeated samples and cancel out
%the noise because in the time domain, the signal isn't adding but in the
%frequency domain it shows  up in the same space
subplot(2,1,2)
waterfall(fftshift(K),S,abs(fftshift(UT))), view(-15,70)
subplot(2,1,1)
waterfall(T,S,abs(UN)), colormap([0 0 0]), view(-15,70)

%add over frequency domain
UTsum = mean(UT,1);


freqCenter=0;

filter = exp(-((k-freqCenter).^2));

for j=1:length(slice)
   UNF(j,:) = UT(j,:).*filter;
   UNFT(j,:) = ifft(UNF(j,:));
end

figure(2)
subplot(2,1,1)
plot(ks,abs(fftshift(UTsum)))

subplot(2,1,2)
waterfall(T,S,abs(UNFT)), view(-15,70)







