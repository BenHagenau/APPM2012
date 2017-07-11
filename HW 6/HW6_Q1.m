%ASEN 2012: HW 6
%Author: Ben Hagenau
%Date Created: 11/11/2016
%Date Edited: 11/17/16

%%%%%%%%%%%%%%%QUESTION: 1%%%%%%%%%%%%%%%
%PURPOSE: %determine roots of the denominator of the transfer function that
%represents a navigational control system for an aircraft using bisection
%method
%GIVEN: Denominator of transfer function
%OUTPUT: location of real roots for this function
%ASSUMPTIONS: Roots are approximated using numerical root finding methods,
%there is one root, and roots are real.

%house keeping
clear all
close all
clc

%define function
y = @(x) x.^5 + 10.576*x.^4 + 23.45*x.^3 + 20.01*x.^2 + 4.589*x - 0.0145;

%Bisection Method root 1
%1. Select interval 
a = 10;
b = -10;
%2. Evaluate function at midpoint of interval
m = mean([a b]);
unc = abs(y(m));
while unc > .0001
    if y(a)*y(m)<0
        b = m;
    else 
        a = m;
    end
    m = mean([a b]);
    unc = abs(y(m));
end

%root 2
%Bisection Method
%1. Select interval 
a2 = -4;
b2 = -10;
%2. Evaluate function at midpoint of interval
m2 = mean([a2 b2]);
unc = abs(y(m2));
while unc > .0001
    if y(a2)*y(m2)<0
        b2 = m2;
    else 
        a2 = m2;
    end
    m2 = mean([a2 b2]);
    unc = abs(y(m2));
end

%root 3
%Bisection Method
%1. Select interval 
a3 = 0;
b3 = -1;
%2. Evaluate function at midpoint of interval
m3 = mean([a3 b3]);
unc = abs(y(m3));
while unc > .0001
    if y(a3)*y(m3)<0
        b3 = m3;
    else 
        a3 = m3;
    end
    m3 = mean([a3 b3]);
    unc = abs(y(m3));
end

%plot function from x[-100 100]
figure
x = -10:10;
hold on
plot(x,y(x))
plot(m,y(m),'*')
plot(m2,y(m2),'*')
plot(m3,y(m3),'*')
legend('Representation of a navigational control system for an aircraft','Root 1','Root 2','Root 3','Location','Best');
title('Representation of a navigational control system for an aircraft');

%write results to an output file
fprintf(fopen('HW6 Output1','w'),'Question 1:\n');
fprintf(fopen('HW6 Output1','a'),'The poles of the transfer function are at s = %3.5f, s = %3.2f, s = %3.3f\n',m,m2,m3);


