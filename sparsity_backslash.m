clear all ; close all ; clc;

A = [1/2 1/4 3 7 -2 10]
b = 3;

x1 = A\b
%backslash makes as many values zero as it can

x2 = pinv(A)*b  %pseudo inverse command also provides a solution but doesn't find a spare one

