%Homework 5
%ASEN 2012
%Ben Hagenau
%11/2/16

%PURPOSE: Define system of differential equations for be solved for time =
%[0 0.26] (thrust fligth)
%INPUT: Time span and initial values
%OUTPUT: Hight, velocity, and mass of rocket on the time span
function [output1] = equ1(t,y1)
%define differential equations for hight, mass, velocity
dvdtT1 = ((60*t)/(0.1536 - 0.01515*t)) - 9.807 - ((0.000626*sign(y1(2))*(y1(2).^2))/(0.1536 - 0.01515*t));
dhdtT1 = y1(2);
dmdtT1 = -.01515;
%store output to be used in ode45
output1 = [dhdtT1;dvdtT1;dmdtT1];
end