clear all; close all; clc;

Abw=imread('lena.jpg');

A2=double(Abw);  %have to do this to turn it into a data matrix
[nx,ny]=size(A2);
An=A2+20*randn(nx,ny);

%clear this up by diffusion

x=linspace(0,1,nx);  dx=x(2)-x(1);
y=linspace(0,1,ny);  dy=y(2)-y(1);

onex=ones(nx,1); oney=ones(ny,1);
Dx=spdiags([onex -2*onex onex],[-1 0 1],nx,nx)/dx^2;
Dy=spdiags([oney -2*oney oney],[-1 0 1],ny,ny)/dy^2;

Ix=eye(nx);  Iy=eye(ny);
L=kron(Iy,Dx)+kron(Dy,Ix);

%now diffuse
tspan=[0 0.002 0.004 0.006]/2;
An2=reshape(An,nx*ny,1);

D=0.01;
[t,usolve]=ode45('zoo_rhs',tspan,An2,[],L,D);

for j=1:length(t)
    Atemp = uint8(reshape(usolve(j,:),nx,ny));
subplot(2,2,j), imshow(Atemp);

end


break
Ani=uint8(An);
imshow(Ani)