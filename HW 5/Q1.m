%ASEN 2012 HW 5
%Ben Hagenau
%11/2/16

%PURPOSE:(a) Using a step size of 0.1, determine the approximation of y over 
%the interval 0?x?2, using the explicit Euler method.
%(b)Using a step size of 0.1, determine the approximation of y over the interval
%0?x?2 using the 4th order Runge Kutta(RK) method
%INPUT: Initial condition and differential equation
%OUTPUT:Estimated y-value at x = 2.0 using the Runge Kutta and Euler's
%Method. Compare to actual vaule and produce a plot

function [] = Q1()
%SET UP
%define differential equation and inition condition
dydx = @(x,y) ((2.*x.*y)+x);
y0=1;
x0=0;
%define step size
dx = 0.1;
%define x range 
xi = 0;
xf = 2;
%define number of steps
steps = (xf/dx);

%%%%%%%%%%%%%Q1:a%%%%%%%%%%%%%
%preallocate x and y
x = zeros(steps+1,1);
y = zeros(steps+1,1);
x(1) = x0;
y(1) = y0;
%determine x and y values for each step of y(x) using Euler's method
for i = 1:steps
    y(i+1) = y(i) + dx * (dydx(x(i),y(i)));
    x(i+1) = x(i) + dx;
end
%value of y at x = 2 using euler's
EU = y(length(y));

%%%%%%%%%%%%%Q1:b%%%%%%%%%%%%%
%preallocate
yR = zeros(steps,1);
yR(1) = y0;
%determine y value estimates on x range using the Runge Kutta method
for i = 1:steps
    k1 = dydx(x(i),yR(i));
    k2 = dydx(x(i)+.5*dx,yR(i)+.5*k1*dx);
    k3 = dydx(x(i)+.5*dx,yR(i)+.5*k2*dx);
    k4 = dydx(x(i)+dx,yR(i)+k3*dx);
    yR(i+1) = yR(i) + (dx/6)*(k1 + 2*k2 + 2*k3 + k4);
end
RK = yR(length(yR));

%determine analytical solution
ya = zeros(steps+1,1);
for i = 1:steps+1
    % Analytical solution
    % y = (3/2)*(e^x^2)-(1/2)   
    ya(i) = (3/2)*(exp(x(i)^(2)))-(.5);
end
yap = ya(length(ya));

%DISPLAY RESULTS: PLOT, OUTPUT, PRINT TO FILE
figure 
hold on
%plot Euler's method results
plot(x,y,'r--');
%plot Runge Kutta method
plot(x,yR,'b--');
%label plot
xlabel('x');
ylabel('y');
title('x v.s. y');
legend('Eulers method','Runge Kutta method','Location','Best');
hold off
%display results in command window
fprintf('QUESTION 1:\n');
fprintf('The value of y at x=%4.2f using Eulers Method is %f using dx=%4.2f \n',x(length(x)),EU,dx);
fprintf('The value of y at x=%4.2f using Runge Kutta Method is %f dx=%4.2f \n',x(length(x)),RK,dx);
fprintf('The exact vlaue of y at x=%4.2f is %f\n',x(length(x)),yap);
fprintf('The results from Eulers method are significantly less exact\nthan the results from the Runge Kutta Method because the latter uses a fourth order taylor series\napproximation and the prior only uses a first order taylor series\napproximation to estimate the value.\n');
%write to text file
fprintf(fopen('hw5Q1output.txt','w'),'QUESTION 1:\n');
fprintf(fopen('hw5Q1output.txt','a'),'The value of y at x=%4.2f using Eulers Method is %f using dx=%4.2f \n',x(length(x)),EU,dx);
fprintf(fopen('hw5Q1output.txt','a'),'The value of y at x=%4.2f using Runge Kutta Method is %f dx=%4.2f \n',x(length(x)),RK,dx);
fprintf(fopen('hw5Q1output.txt','a'),'The exact vlaue of y at x=%4.2f is %f\n',x(length(x)),yap);
fprintf(fopen('hw5Q1output.txt','a'), 'The results from Eulers method are significantly less exact\nthan the results from the Runge Kutta Method because the latter uses a fourth order taylor series\napproximation and the prior only uses a first order taylor series\napproximation to estimate the value.');

