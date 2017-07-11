%ASEN 2012 HW 5
%Homework 5
%ASEN 2012
%Ben Hagenau
%11/2/16

%PURPOSE: Compute and plot the trajectory of this model rocket and find the maximum height
%INPUT: Differential equations decribing the flight of the rocket
%OUTPUT: Plot of the trajectory of Rocket and max hight

function [] = Q2()
%SOLVE DIFFERENTIAL EQUATIONS FOR TIME = [0 0.26]
%define initial conditions and time span
m1 = .1536;
v1 = 0;
h1 = 0;
y1 = [h1 v1 m1];
t1 = [0 .26];
%solve system of differential equations
[t1, h_v_m1] = ode45('equ1', t1, y1);

%SOLVE DIFFERENTIAL EQUATIONS FOR TIME = [0.26 1.65]
%define initial conditions and time span
y2 = [h_v_m1(end,1),h_v_m1(end,2),h_v_m1(end,3)];
t2 = [.26 1.65];
%solve system of differential equations
[t2, h_v_m2] = ode45('equ2', t2 , y2);

%SOLVE DIFFERENTIAL EQUATIONS FOR TIME = [0.26 1.65]
%define initial conditions and time span
y3 = [h_v_m2(end,1),h_v_m2(end,2),h_v_m2(end,3)];
t3 = [1.65 20];
%solve system of differential equations
[t3, h_v_m3] = ode45('equ3', t3, y3);

%CALCULATE THE MAXIMUM HIGHT
%compose all hight data into one vector
height = [h_v_m1(:,1)' h_v_m2(:,1)' h_v_m3(:,1)'];
max_height = max(height);
%determine the corrosponding time value
loc = find(height == max_height);
time = [t1' t2' t3'];
max_time = time(loc);

%PLOT HIGHT OF THE ROCKET
figure
hold on
plot(time,height,'b')
plot(max_time,max_height,'r*')
xlabel('Vertical Distance [m]')
ylabel('Time [s]')
title('Verticle Distance v.s Time')
legend('Rocket Trajectory', 'Max Height','Location','Best')
hold off

%PRINT RESULTS 
fprintf('\n\nQUESTION 2:\nThe predicted maximum height of the rocket is %3.2f [m]', max_height);
fprintf(fopen('hw5Q1output.txt','a'),'\n\nQUESTION 2:\nThe predicted maximum height of the rocket is %3.2f [m]', max_height);
end












