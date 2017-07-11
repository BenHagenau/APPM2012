%ASEN 2012 HW 3
%AUTHOR: BEN HAGENAU
%DATE: 10/12/16

%This script will call functions to display the answers to question 2.2
%house keeping
clear all; 
clc;
%create data vectors
t = [-2 -1 0 2]';
y = [4 3 1 0]';
%create a time vector that will produce a smooth curve
t_ext = linspace(-2,2,100);

%(1): Find the best straight-line fit to this data having the form y = B0+B1t.
%define matrix A
A = ones(4,2);
A(:,1) = t;
%define matrix d
d = y;
%calculate coefficients [m b]
coeff = ((A'*A)^-1)*A'*d;
B1 = coeff(1);
B0 = coeff(2);
%define line of best fit
y_best = B1*t+B0;

%(2): Determine the uncertainty in the measurement of y if we assume a straight-line fit 
y_unc = sqrt(sum((y_best - y).^2)/2);

%(3): Determine the uncertainty in the coefficients m and b.
Q = (A'*A)^-1;
B1_error = sqrt(Q(1,1));
B0_error = sqrt(Q(2,2));

%(4): Find the best quadratic polynomial fit to this data having the form: y = B4t^2 + B3t +B2  
%create A matrix, A_quad
A_quad = ones(4,3);
A_quad(:,1) = t.^2;
A_quad(:,2) = t;
%calculate coefficients
coeff_quad = ((A_quad'*A_quad)^-1)*A_quad'*d;
B4 = coeff_quad(1);
B3 = coeff_quad(2);
B2 = coeff_quad(3);
%define line of best fit - use more t values, t_ext, to get a smooth curve
y_quad_best = B4*t.^2 + B3*t+B2;

%(5): Determine the uncertainty in the measurement of y if we assume a quadratic polynomial fit 
y_quad_unc = sqrt(sum((y_quad_best - y).^2)/2);

%(6): Determine the uncertainty in the coefficients B4, B3, and B1
Q_quad = (A_quad'*A_quad)^-1;
B4_error = sqrt(Q_quad(1,1));
B3_error = sqrt(Q_quad(2,2));
B2_error = sqrt(Q_quad(3,3));

%(7): Plot the data, the best straight-line fit and the best quadratic polynomial fit.
figure
plot(t,y,'k*')
hold on
plot(t,y_best,'--')
hold on
plot(t_ext,B4*t_ext.^2 + B3*t_ext+B2,'--')
xlabel('x')
ylabel('y')
title('x v.s. y')
legend('x value', 'Least Squares Fit line', 'Quadratic Least Squares Fit line')

%(8): Estimate the uncertainty in y at t = 5, if we use both the straight-line fit and the quadratic polynomial fit.
%calculate error in linear fit
linear_unc = sqrt([5 1]*Q*[5 1]');
%calculate error in quadratic fit
quadratic_unc = sqrt([25 5 1]*Q_quad*[25 5 1]');
%average error to get best error at t = 5
unct5 = (linear_unc+quadratic_unc)/2;

%write asnwers to output text file
fprintf(fopen('output_22.txt','w'), '(1): Best straight-line fit = %3.3f(t) + %3.3f\n',B1,B0);
fprintf(fopen('output_22.txt','a'), '(2): Uncertainty in y for the linear fit = %3.3f\n',y_unc);
fprintf(fopen('output_22.txt','a'), '(3): Uncertainty in B1 = %3.3f and uncertainty in B0 = %3.3f\n', B1_error,B0_error);
fprintf(fopen('output_22.txt','a'), '(4): Best quadratic-polynomial fit = %3.3f(t^2) - %3.3f(t) + %3.3f\n',B4,abs(B3),B2);
fprintf(fopen('output_22.txt','a'), '(5): Uncertainty in y for the polynomial fit = %3.3f\n',y_quad_unc);
fprintf(fopen('output_22.txt','a'), '(6): Uncertainty in B4 = %3.3f, uncertainty in B3 = %3.3f, and uncertainty in B2 = %3.3f\n', B4_error, B3_error, B2_error);
fprintf(fopen('output_22.txt','a'), '(8): Uncertainty in y at t = 5 using linear and quadratic fit lines = %3.3f', unct5);
