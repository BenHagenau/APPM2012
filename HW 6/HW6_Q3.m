%ASEN 2012: HW 6
%Author: Ben Hagenau
%Date Created: 11/11/2016
%Date Edited: 11/17/16

%%%%%%%%%%%%%%%QUESTION: 3%%%%%%%%%%%%%%%
%PURPOSE:  Determine the average surface temperature for this case to 
%within 4 significant figures accuracy
%GIVEN: Equation relating variables and values to describe the state so
%that average surface temperature can be determined
%OUTPUT: Average surface temperature
%ASSUMPTIONS: Roots are approximated using numerical root finding methods,
%there is one root, and roots are real.

%house keeping
clear all
close all
clc

%Define Variables
%Temperature of surroundings
T = 100; %[F]
%Desired rate of heat flux removed from hot metal
Q = 850; %[Btu/h-ft^2]
%Emissivity
e = .9;
%Stephan-Boltzman constant
s = 1.174e-9;
%Average surface temperature, Ts => to be solved for

%Define heat flux equation to be solved for a root
y = @(Ts) (Ts - 100) + e*s*(Ts.^4 - T^4) - Q;
%solve roots using solve function
syms Ts
eqn = (Ts - 100) + e*s*(Ts.^4-T^4) - Q == 0;
solx = solve(eqn,Ts);
%eliminate imaginary roots
for i = 1:4
    if isreal(solx(i)) == 0
        solx(i) = 'imaginary';
    end
end
solx = solx(find(solx ~= 'imaginary'));

%plot function from x[-1000 1000]
figure
x = 0:1000;
hold on
plot(x,y(x))
plot(solx(2),y(solx(2)),'*')
txt = 'Root  \rightarrow  ';
text(double(solx(2)),y(double(solx(2))),txt,'HorizontalAlignment','right')
legend('Average Surface Temperature of a Cooling Plate','Root','Location','Best');
title('Average Surface Temperature of a Cooling Plate');

%write results to an output file
fprintf(fopen('HW6 Output3','w'),'Question 3:\n');
fprintf(fopen('HW6 Output3','a'),'The average surface temperature of the hot plate is %3.1f degrees fahrenheit\n',double(solx(2)));
