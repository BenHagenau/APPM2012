%Homework 5
%ASEN 2012
%Ben Hagenau
%11/2/16

%PURPOSE: Define system of differential equations for be solved for time =
%[1.65 20.0] (ballistic flight)
%INPUT: Time span and initial values
%OUTPUT: Hight, velocity, and mass of rocket on the time span
function [output3] = equ3(t,y3)
%define differential equations for hight, mass, velocity
dvdtT3 = -9.807 - (0.000626*sign(y3(2))*(y3(2).^2))/y3((3));
dhdtT3 = y3(2);
dmdtT3 = 0;
%store output to be used in ode45
output3 = [dhdtT3;dvdtT3;dmdtT3];
end