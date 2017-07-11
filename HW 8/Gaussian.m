% Author: Ben Hagenau
% ASEN 2012: Homework 8
% Created: 12/9/2016

% PURPOSE: Create a program to run the gausse elimination method without
% pivoting for solving a system of linear equations
% INPUT: Linear system of equations
% OUTPUT: Solution for variables in linear system of equations
% ASSUMPTIONS: No pivoting

function [out] = Gaussian(A,b)

 %house cleaning
 clc
 clear all
 close all

%equation 1: x - 3y + z = 4
%equation 2: 2x - 8y + 8z = -2
%equation 3: -6x + 3y - 15z = 9

%define A and b matrices
% A = [-6 3 -15; 1 -3 1; 2 -8 8];
% b = [9;4;-2];
%Define number of equations to be solved
n = length(b);
m = zeros(n,1);
x = zeros(n,1);
%FORWARD ELLIMNATION
for r = 1:n-1
%compute the row used in ellimination after division
    m(r+1:n) = A(r+1:n,r)/A(r,r);
    for i = r+1:n
%eliminate from the next row via subtraction
        A(i,r+1:n) = A(i,r+1:n) - m(i)*A(r,r+1:n); %m(i) to multiply by correct value to elliminate
    end
%do subtraction to determine b value
    b(r+1:n) = b(r+1:n) - b(r)*m(r+1:n);
end
%use function to imput zeros where they belong
A = triu(A);

%BACK SUBSTITUTION
%solve for variable in the bottom row
x(n) = b(n)/A(n,n);
%solve for all other variables
for i = n-1:-1:1
    b(1:i) = b(1:i) - x(i+1)*A(1:i,i+1);
    x(i) = b(i)/A(i,i);
end

out = x;
%output answer
fprintf('The variables you are looking for are %3.3f, %3.3f, %3.3f\n',x(1),x(2),x(3));
%write output to file
fprintf(fopen('HW8 Solutions.txt','w'),'The variables you are looking for are %3.3f, %3.3f, %3.3f\n',x(1),x(2),x(3));
fprintf(fopen('HW8 Solutions.txt','a'),'Note that the order of the variables in the output corrospond the the order they are in the equations');
end
