clear all; close all;  clc;
%clean up pimple from black and white photo of derek zoolander

A=imread('derek3.jpg');
figure(1)
imshow(A)

figure(2)

Abw=double(A(size(A,1):-1:1,:,:));    %converts from uint8 to double


red = (Abw(:,:,1));
green = (Abw(:,:,2));
blue = (Abw(:,:,3));



figure(2)

%select region
x = 91:116;
y = 156:184;

%clear this up by diffusion
[nx,ny]=size(A(:,:,1));

x1=linspace(0,1,nx);  dx=x1(2)-x1(1);
y1=linspace(0,1,ny);  dy=y1(2)-y1(1);

onex=ones(nx,1); oney=ones(ny,1);
Dx=spdiags([onex -2*onex onex],[-1 0 1],nx,nx)/dx^2;
Dx(1,nx)=1;
Dx(nx,1)=1;

Dy=spdiags([oney -2*oney oney],[-1 0 1],ny,ny)/dy^2;
Dy(1,ny)=1;
Dy(ny,1)=1;


Ix=eye(nx);  Iy=eye(ny);
L=kron(Iy,Dx)+kron(Dy,Ix);

%now diffuse
tspan=[0 0.002 0.004 0.006 0.008 0.010 0.012 0.014 0.016 ]/10;
%rash2 = reshape(rash,nx*ny,1);
Abw1dred = reshape(Abw(:,:,1),nx*ny,1);
Abw1dgreen = reshape(Abw(:,:,2),nx*ny,1);
Abw1dblue = reshape(Abw(:,:,3),nx*ny,1);

Dmag=0.01;
D=zeros(size(Abw(:,:,1)));
D(x,y)=Dmag;
Dvec = reshape(D,nx*ny,1);



[t,usolveRed]=ode45('zoo_rhs',tspan,Abw1dred,[],L,Dvec); 
[t,usolveGreen]=ode45('zoo_rhs',tspan,Abw1dgreen,[],L,Dvec); 
[t,usolveBlue]=ode45('zoo_rhs',tspan,Abw1dblue,[],L,Dvec); 


figure(3)

for j=1:length(t)
    Ared = uint8(reshape(usolveRed(j,:),nx,ny));
    Agreen = uint8(reshape(usolveGreen(j,:),nx,ny));
    Ablue = uint8(reshape(usolveBlue(j,:),nx,ny));    
    Ared = Ared(size(A,1):-1:1,:);
    Agreen = Agreen(size(A,1):-1:1,:);
    Ablue = Ablue(size(A,1):-1:1,:);
    
    Afixed(:,:,1)=Ared;
    Afixed(:,:,2)=Agreen;
    Afixed(:,:,3)=Ablue;
    
	subplot(3,3,j), imshow(Afixed);
end

figure(4)

select = [1 9];

for j=1:2
    sel = select(j);
    Ared = uint8(reshape(usolveRed(sel,:),nx,ny));
    Agreen = uint8(reshape(usolveGreen(sel,:),nx,ny));
    Ablue = uint8(reshape(usolveBlue(sel,:),nx,ny));    
    Ared = Ared(size(A,1):-1:1,:);
    Agreen = Agreen(size(A,1):-1:1,:);
    Ablue = Ablue(size(A,1):-1:1,:);
    
    Afixed(:,:,1)=Ared;
    Afixed(:,:,2)=Agreen;
    Afixed(:,:,3)=Ablue;
    
	subplot(1,2,j), imshow(Afixed);
end


