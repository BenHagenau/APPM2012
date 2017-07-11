%ASEN 2012 HW4
%10/19/2016
%Ben Hagenau

%This function calculates the distance traveled of a partical given the
%acceleration vector and initial velocity using trapezoidal rule and
%simpson's rule for 10 intevales and 100 intervales. 

%PROBLEM SET UP: Use trapozoidal and simpsons rule to calculate total
%distance traveled in four seconds given parameters below. Comment on use
%of the two methods and two different number of intervals of 10 and 100.
%note: velocity and acceleration are always positive on time interal [0,4]

%Define initial velocity 
V0 = 3; %[m/s]
%define function for acceleration
a = @(t) 7*t; %[m/s^2]
%define number of intervals used
n1 = 10;
n2 = 100;

%integral of velocity is distance and velocity function is integral of
%acceleration 
v = @(t) (7/2)*t.^2 + 3;

%calculate total distance using trapezoidal rule for both intervals
%n = 10
[SA10] = simpsons(10,0,4);
%n = 100
[SA100] = simpsons(100,0,4);
%calculate total distance using simpson's rule for both intervals
%n = 10
[TA10] = trapazoidal(10,0,4);
%n = 100
[TA100] = trapazoidal(100,0,4);

%plot
t = linspace(0,4,100);
plot(t,v(t));
legend('velocity','Location','Best')
xlabel('time, s')
ylabel('velocity, m/s')
title('Velocity v.s. Time')

%Write results to output file
fprintf(fopen('HW4Q1.txt','w'), 'The equation integrated to find the estimate for the total distance is the velocity equation: (7/2)*t.^2 + 3\n');
fprintf(fopen('HW4Q1.txt','a'), 'Using simpsons rule:\n');
fprintf(fopen('HW4Q1.txt','a'), 'n = 10 : Area = total distance = %3.3f [m]\n', SA10);
fprintf(fopen('HW4Q1.txt','a'), 'n = 100 : Area = total distance = %3.3f [m]\n', SA100);
fprintf(fopen('HW4Q1.txt','a'), 'Using trapezoidal rule:\n');
fprintf(fopen('HW4Q1.txt','a'), 'n = 10 : Area = total distance = %3.3f [m]\n', TA10);
fprintf(fopen('HW4Q1.txt','a'), 'n = 100 : Area = total distance = %3.3f [m]\n', TA100);
fprintf(fopen('HW4Q1.txt','a'), 'The hand calculated area value is 86.66666... [m]\n');
fprintf(fopen('HW4Q1.txt','a'), 'The area calculated using simpsons rule is more accurate thanthe area calculated using the trapezoidal rule.\nusing a larger number of intervals produces a more accurate area in both methods.');