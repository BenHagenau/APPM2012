%Homework 5
%ASEN 2012
%Ben Hagenau
%11/2/16

%PURPOSE: Define system of differential equations for be solved for time =
%[0.26 1.65] (thrust flight)
%INPUT: Time span and initial values
%OUTPUT: Hight, velocity, and mass of rocket on the time span
function [output2] = equ2(t,y2)
%define differential equations for hight, mass, velocity
dvdtT2 = ((15)/(0.1536 - 0.01515*t)) - 9.807 - ((0.000626*sign(y2(2))*(y2(2).^2))/(0.1536 - 0.01515*t));
dhdtT2 = y2(2);
dmdtT2 = -.01515;
%store output to be used in ode45
output2 = [dhdtT2;dvdtT2;dmdtT2];
end