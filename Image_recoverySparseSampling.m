clear all; close all; clc;

%we don't have the right toolbox to do this,  not known if this code works,
%it hasn't been run

n=5000;
t=linspace(0,1/8,n); 
f=sin(1394*pi*t)+sin(3266*pi*t); 
ft=fft(f);

subplot(2,1,1), plot(t,f)
subplot(2,1,2), plot(abs(fftshift(ft)))

%randomly sample some points and then try to reconstruct the signal

m = 500;
r1 = randintrlv(1:n,793);  %mixes up vectorr randomly
perm=r1(1:m);   %takes the first 500 of the random points
f2=f(perm);
t2=t(perm);

%the following results in an identity matrix for which the 1 in each row is
%randomly shuffled to a different column
D=dct(eye(n,n));
A=D(perm,:);

x=pinv(A)*f2';
x2=A\f2';
cvx_begin;
variable x3(n);
minimize(norm(x3,1));
subject to
A*x3 == f2';
cvx_end;



plot(t,f,'k',t2,f2,'mo')


