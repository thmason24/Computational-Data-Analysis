clear all; close all;  clc;
%clean up pimple from black and white photo of derek zoolander

A=imread('derek4.jpg');
Abw=double(A(size(A,1):-1:1,:));    %converts from uint8 to double
figure(1)
pcolor(abs(Abw)), shading interp, colormap(gray) , drawnow


%red = (Abw(:,:,1));
%green = (Abw(:,:,2));
%blue = (Abw(:,:,3));

figure(2)

%select region
x = 92:115;
y = 157:182;
rash = Abw(x,y);
pcolor(y,x,abs(rash)), shading interp, colormap(gray) , drawnow


%clear this up by diffusion
[nx,ny]=size(A);

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
tspan=[0 0.002 0.004 0.006 0.008 0.010 0.012 0.014 0.016 ]/20;
%rash2 = reshape(rash,nx*ny,1);
Abw2 = reshape(Abw,nx*ny,1);

Dmag=0.01;
D=zeros(size(Abw));
D(x,y)=Dmag;
Dvec = reshape(D,nx*ny,1);
size(Dvec)
size(L*Abw2)


[t,usolve]=ode45('zoo_rhs',tspan,Abw2,[],L,Dvec); %octave wants the parameters in a list
%[t,usolve]=ode45(zoo_rhs,tspan,rash2,[],[L,D]); %matlab wants the parameters just in the last arguments

figure(3)

for j=1:length(t)
    Atemp = uint8(reshape(usolve(j,:),nx,ny));
	Atemp = Atemp(size(A,1):-1:1,:);
	subplot(3,3,j), imshow(Atemp);
end

figure(4)

select = [1 9];
%reduce x size
trimSize = 2;

trimx = trimSize:numel(x)-trimSize;
trimy = trimSize:numel(y)-trimSize;
x2=x(trimx);
y2=y(trimy);


for j=1:2
    Atemp = uint8(reshape(usolve(select(j),:),nx,ny));
	Atemp = Atemp(size(A,1):-1:1,:);
	subplot(1,2,j), imshow(Atemp);
end


