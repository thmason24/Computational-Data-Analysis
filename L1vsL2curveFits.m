clear all; close all; clc;

x =[0.1 0.4 0.7 1.2 1.3 1.7 2.2 2.8 3.0 4.0 4.3 4.4 4.9];
y =[0.5 0.9 1.1 1.5 1.5 2.0 2.2 2.8 2.7 3.0 3.5 3.7 3.9];

plot(x,y,'ko', 'Linewidth',2)

%now place line fits using both the L2 and the L1 norm using fminsearch.

coeff_L2=fminsearch('line_L2_fit',[1 1],[],x,y);
coeff_L1=fminsearch('line_L1_fit',[1 1],[],x,y);

A2 = coeff_L2(1);   B2 = coeff_L2(2);
A1 = coeff_L1(1);   B1 = coeff_L1(2);

xp = 0:0.01:5;
y2=A2*xp+B2;
y1=A1*xp+B1;

hold on
plot(xp,y2,'r',xp,y1,'m')

% the results look pretty similar
%but now add outliers,  the outliers get squared which really exagerates
%the outliers

x =[0.1 0.4 0.5 0.7 1.2 1.3 1.7 2.2 2.8 3.0 3.9 4.0 4.3 4.4 4.9];
y =[0.5 0.9 3.8 1.1 1.5 1.5 2.0 2.2 2.8 2.7 0.3 3.0 3.5 3.7 3.9];

coeff_L2=fminsearch('line_L2_fit',[1 1],[],x,y);
coeff_L1=fminsearch('line_L1_fit',[1 1],[],x,y);

A2 = coeff_L2(1);   B2 = coeff_L2(2);
A1 = coeff_L1(1);   B1 = coeff_L1(2);

xp = 0:0.01:5;
y2=A2*xp+B2;
y1=A1*xp+B1;

figure(2)
plot(x,y,'ko', 'Linewidth',2)
hold on
plot(xp,y2,'r',xp,y1,'m')


