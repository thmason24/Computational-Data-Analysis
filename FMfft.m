clear all; close all; clc;
% FFT of an FM signal (I think)
L=20;
N=128;
x2=linspace(-L/2,L/2,N+1);
x=x2(1:N);
K=(1/L)*[0:N/2-1 -N/2:-1];
ks=fftshift(K);
imag_unit=complex(0,1);
fmod=0.0;
%add random noise to simulate signal???
u=cos((4*pi+fmod*randn(size(x))).*x) + ...
   imag_unit*sin((2*pi+fmod*randn(size(x))).*x);
plot(x,real(u))
figure
ut=u;
minus_2_pi_i=complex(0,-2*pi);
for k=1:N,
  sum=complex(0,0);
  for n=1:N,
    sum=sum+ u(n)*exp(minus_2_pi_i*(k-1)*(n-1)/N);
  end
  ut(k)=sum;
end
subplot(3,1,1)
plot(ks,fftshift(real(ut)));
subplot(3,1,2)
plot(ks,fftshift(imag(ut)));
subplot(3,1,3)
plot(ks,fftshift(abs(ut)));
%