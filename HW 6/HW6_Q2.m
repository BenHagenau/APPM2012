%ASEN 2012: HW 6
%Author: Ben Hagenau
%Date Created: 11/11/2016
%Date Edited: 11/17/16

%%%%%%%%%%%%%%%QUESTION: 2%%%%%%%%%%%%%%%
%PURPOSE: Determine The angle of the orbit to the sun using kepler's
%equation and the root finding method of bisection
%GIVEN: Eccentricity of Ellipse, Period of Revolution, Mean Anomaly
%OUTPUT: Angle of Orbit With Respect to The Sun in Radians
%ASSUMPTIONS: Roots are approximated using numerical root finding methods,
%there is one root, and roots are real.

%house keeping
clear all
close all
clc

%Define Variables
% M = Mean Anomaly
M = 50; %[days]
% P = Period of Revolution
P = 100; %[days]
% e = Eccentricity of Ellipse
e = .2;
% THETA = Angle of Orbit With Respect to The Sun in Radians

%Define Kepler's Equation to be solved for a root
y = @(THETA) P*(THETA - e*sin(THETA)) - M;

%Bisection Method
%1. Select interval 
a = -30;
b = 30;
m = mean([a b]);
unc = abs(y(m));
%2. Evaluate function at midpoint of interval
while unc > .0001
    if y(m)*y(a) < 0 
        b = m;
    else 
        a = m;
    end
    m = mean([a b]);
    unc = abs(y(m));
end

%plot function from x[-100 100]
figure
x = -100:100;
hold on
plot(x,y(x))
plot(m,y(m),'*')
txt = ' \leftarrow Root';
text(m,y(m),txt,'HorizontalAlignment','left')
legend('Angle of Orbit With Respect to The Sun in Radians','Root','Location','Best');
title('Angle of Orbit With Respect to The Sun in Radians');

%write results to an output file
fprintf(fopen('HW6 Output2','w'),'Question 2:\n');
fprintf(fopen('HW6 Output2','a'),'The angle of orbit with respect to the sun is %3.4f radians\n',m);


