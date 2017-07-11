%ASEN 2012 HW4
%10/19/2016
%Ben Hagenau

%This program will calculate the distance traveled of an object given 10
%time-velocity data points. 

%PROBLEM SET UP: Objects velocity is given at ten time values. use
%trapezoidal to estimate position at time of 10 seconds

%define variables
time = 0:10; %[s]
velocity = [0 2 5 7 9 12 15 18 22 20 17];

%CALCULATE DISTANCE TAVELLED IN 10 SECONDS
%define the change in t
dx = 1;
%calculate sum to be used in trapazoidal rule
s = [velocity(1)];
for i = 2:10
    s = [s 2*velocity(i)];
end
s = [s velocity(11)];
%use sum in calculation to find distance traveleled
d = (dx/2)*sum(s); %[ft^3]

%plot
plot(t,velocity,'-');
legend('Velocity','Location','Best');
xlabel('time, s');
ylabel('velocity, m/s');
title('Velocity v.s. Time');

%write results to output file
fprintf(fopen('HW4Q3.txt','w'), 'Trapezoidal approximation of distance travelled in ten seconds: %3.3f [m]\n', d);




