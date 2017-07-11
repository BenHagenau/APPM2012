%ASEN 2012 HW 3
%AUTHOR: BEN HAGENAU
%DATE: 10/12/16

%This script will call functions to display the answers to question 8.26

%Question Description: A student measures radioactive decay. He counts
%decay in 15 second periods and makes six measurements and 30 minute
%intervals. (a) calculate the logs, z = ln(v) and unceratainties. show taht
%uncertainty in z is 1/root(v). wieght of z is v. (b) make wighted least
%squares line of best fit for the data. what is the materials mean life, T,
%and its uncertainty. make table to show t,v,z=ln(v),m,b. (c) plot with
%error bars. Does this make sense. 

%house keeping
clear all;
clc;

%create data vectors
t = [10 40 70 100 130 160];
v = [188 102 60 18 16 5];

%PART (a)
%calculate z = ln(v)
z = log(v);
%calculate error in z
z_error = 1./sqrt(v);
%calculate weighted matrix, W
W = diag(1./(1./sqrt(v)).^2);

%PART (b)
%create 'A' matrix
A = ones(6,2);
A(:,1) = t;
%create d matrix
d = z'; 
%calculate coefficients [m b] 
coeff = ((A'*W*A)^-1)*A'*W*d;
m = coeff(1);
b = coeff(2);
%calculate error in coefficients
Q = (A'*W*A)^-1;
b_error = sqrt(Q(2,2));
m_error = sqrt(Q(1,1));
%calculate line of best fit values and error in line of best fit 
z_best = real(m*t+b);
z_best_error = sqrt(sum((z_best - z).^2)/4);
%calculate z naught using line of best fit and error using the error in the line of best fit 
z0 = z(1);
z0_error = z_best_error;
%calculate mean life for each data point, T
T = real(t/(z0 - z_best)); 
%Error in T using quadrature(assume no error in t)
T_error = sqrt((((t/(z0 - z_best).^2)*z0_error).^2) + (((t/(z0 - z_best).^2)*z_best_error).^2));
%create table with t,v,z=ln(v), A,B
structure = struct('t',t,'v',v,'z',z_best,'m',m,'b',b);

%output table to a text file
fprintf(fopen('output_826.txt','w'),'t: ');
for i = 1:length(t)
    fprintf(fopen('output_826.txt','a'),'%3.2f, ',t(i));
end
fprintf(fopen('output_826.txt','a'),'\nv: ');
for i = 1:length(v)
    fprintf(fopen('output_826.txt','a'),'%3.2f, ',v(i));
end
fprintf(fopen('output_826.txt','a'),'\nz: ');
for i = 1:length(z_best)
    fprintf(fopen('output_826.txt','a'),'%3.2f, ',z_best(i));
end
fprintf(fopen('output_826.txt','a'),'\nm: %3.2f',m);
fprintf(fopen('output_826.txt','a'),'\nb: %3.2f',b);
fprintf(fopen('output_826.txt','a'),'\nMean life: %3.2f [1/s]', T);
fprintf(fopen('output_826.txt','a'),'\nError in mean life at each point respectively: ');
for i = 1:length(T_error)
    fprintf(fopen('output_826.txt','a'),'%2.2f, ',T_error(i));
end
fprintf(fopen('output_826.txt','a'),'\nGraph is consistent with the rate of decay decreasing exponentially!');

figure 
%plot z - t
plot(t,z,'k*')
hold on
%plot z_best - t
plot(t,m*t+b)
%legend
legend('z value','Weighted Least Squares Fit')
%axis label
ylabel('z value')
xlabel('time [s]')
%title
title('z value v.s.time')
errorbar(t,z,z_error,'k*')


















