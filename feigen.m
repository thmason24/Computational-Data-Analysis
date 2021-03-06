% simulate feigenbaum period doubling
clear all; close all;
clc;

r=2;
u=0.1;
offset=2;
x_init=0.1;
numU=500;
u=offset+linspace(0,2,numU);
count = 1;
for k=1:numU
x=x_init;
for i=1:numU
    %x = 1 - u(k)*abs(x).^r;
    x = u(k)*x*(1-x);
  if i > 200
	  y(count)=x;
	  p(count)=u(k);
      count = count + 1;
  end
end
end

%plot(y, '.' , 'MarkerSize', 6)
scatter(p,y, 1,'red')
%ylim ([-2 2])
%set(h, 'Markersize','1');