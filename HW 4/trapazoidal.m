function [A] = trapazoidal(n,x1,x2)
%This script calculates an integral using trapazoidal rule
%define equation to be integrated
v = @(t) ((7/2)*t^2) + 3;
%define the change in x
dx = (x2-x1)/n;
%calculate sum to be used in trapazoidal rule
s = [v(0)];
for i = 1:n-1
    s = [s 2*v(dx*i)];
end
s = [s v(dx*n)];
A = (dx/2)*sum(s);


