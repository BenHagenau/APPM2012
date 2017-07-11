%ASEN 2012 HW 3
%AUTHOR: BEN HAGENAU
%DATE: 10/12/16

%This script will call functions to display the answers to question 8.15.

%Question Description: Kundt's tube is a device for measuring the wave
%length of sound. The experimenter sets up a standing wave inside a glass
%tube in which he or she sprinkled a light power. The vibration of the air
%causes the power to more and eventually to collect in small piles at the
%displacement ndes of the standing wave. Distance between the nodes is
%half of the wave length.
%A student finds six nodes which are all equal distance apart, half of the
%wavelength. Thier positions satisfy the equation s = A +Bn. B = half of
%the wave length. s is the position of the node. 

%Process: (1) Calculate A and B using weighted least squares. 
%(2) Calculate wavelength uncertainty. (3) plot.

%House keeping
clear all; 
clc;

%Create data matrix [Node number n, position s]
data(:,1) = [1 2 3 4 5 6]; 
data(:,2) = [5.0 14.4 23.1 32.3 41.0 50.4]; %[cm]

%Create 'a' matrix 
a = ones(length(data),2);
a(:,1) = data(:,1);
%Create d matrix
d = data(:,2);
%Calculate coefficients [m b] => [B A]
coeff = ((a'*a)^-1)*a'*d;
%Define B and A
B = coeff(1);
A = coeff(2);
%Calculate wave length [cm]
wavelength = 2*B; 
%Calculate error in wavelength [cm]
Q = (a'*a)^-1;
wavelength_error = Q(1)*2; 

%PLOT
figure
%plot data
plot(data(:,1),data(:,2),'k*');
hold on
%plot line of best fit
plot(data(:,1),A+B*data(:,1));
hold on
%plot key
legend('Data Points','Line of Least Squares');
%plot title
title('Node Number v.s. Node Postion');
%label axis'
xlabel('Node Number');
ylabel('Node Postion [cm]');

%Write output to text file
fprintf(fopen('output_815.txt','w'), 'A, y-intercept: %3.2f\nB, wavelength/2: %3.2f\nWavelength: %3.2f [cm]\nUncertainty in wavelength: %3.1f [cm]', A,B,wavelength,wavelength_error);








