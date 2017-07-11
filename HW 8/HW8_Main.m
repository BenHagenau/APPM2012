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
%clear all
close all

%equation 1: x - 3y + z = 4
%equation 2: 2x - 8y + 8z = -2
%equation 3: -6x + 3y - 15z = 9

%define A and b matrices
% A = [-6 3 -15; 1 -3 1; 2 -8 8];
% b = [9;4;-2];


%define variables for general case
a11 = A(1,1);
a12 = A(1,2);
a13 = A(1,3);
b1 = b(1);

a21 = A(2,1);
a22 = A(2,2);
a23 = A(2,3);
b2 = b(2);

a31 = A(3,1);
a32 = A(3,2);
a33 = A(3,3);
b3 = b(3);

%eliminate first term in second equation
b2 = b2 - (a21/a11)*b1;
a22 = a22 - (a21/a11)*a12;
a23 = a23 - (a21/a11)*a13;
a21 = a21 - (a21/a11)*a11;
%eliminate first term in third equation
b3 = b3 - (a31/a11)*b1;
a32 = a32 - (a31/a11)*a12;
a33 = a33 - (a31/a11)*a13;
a31 = a31 - (a31/a11)*a11;
%eliminate second term in third equation
b3 = b3 - (a32/a22)*b2;
a33 = a33 - (a32/a22)*a23;
a32 = a32 - (a32/a22)*a22;

%solve for x, y, and z
z = b3/a33;
y = (b2 - a23*z)/a22;
x = (b1 - a13*z - a12*y)/a11;
out = [x,y,z];
%output answer
fprintf('X = %3.3f\n',x)
fprintf('Y = %3.3f\n',y)
fprintf('Z = %3.3f\n',z)
%write output to file
fprintf(fopen('HW8 Solutions.txt','w'),'X = %3.3f\nY = %3.3f\nZ = %3.3f\n',x,y,z);


