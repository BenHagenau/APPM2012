function [A] = simpsons(n,x1,x2)
%This script calculates an integral using simpson's rule
%define equation to be integrated
v = @(t) ((7/2)*t^2) + 3;
%define the change in x
dx = (x2-x1)/n;
%add first term to sum of simpson's rule
s = [v(0)];
%add intermediate terms of the sum of simpson's rule 
for i = 1:2:n
    s = [s 4*v(dx*(i)) 2*v(dx*(i+1))];
end
%remove extra term produced by loop
s(end) = [];
%add the last term of the sum of simspon's rule
s = [s v(dx*n)];
%calculate area
A = sum(s)*(dx/3);
end

