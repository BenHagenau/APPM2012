%ASEN 2012 HW4
%10/19/2016
%Ben Hagenau

%This program calculates the water hight at time 10 min given time and flow
%rate data points using trapazoidal rule

%PROBLEM SET UP: Tank is empty and is filling with water. The area of the
%base is known and 10 data points are known. Use Trapezoidal rule to
%approximate the water height at t = 10

%Area of the base
A = 100; %[ft^2]
%Create variable vectors
t = 0:10;
flow_rate = [0 80 130 150 150 160 165 170 160 140 120];

%CALCULATE VOLUME OF WATER INTO TANK IN 10 MIN
%define the change in t
dx = 1;
%calculate sum to be used in trapazoidal rule
s = [flow_rate(1)];
for i = 2:10
    s = [s 2*flow_rate(i)];
end
s = [s flow_rate(11)];
%use sum in calculation to find volume of water in
volume_water_in = (dx/2)*sum(s); %[ft^3]

%CALCULATE THE HIGHT OF THE WATER
%height = volume/area of base
h = volume_water_in/A;

%plot
plot(t,flow_rate,'-');
legend('Flow Rate','Location','Best');
xlabel('time, minutes');
ylabel('flow rate, ft^3/minute');
title('Flow Rate v.s. Time');

%write results to output file
fprintf(fopen('HW4Q2.txt','w'), 'Trapezoidal approximation of water height in tank at ten minutes: %3.3f [ft]\n', h);



