%Project II: Bottle Rocket Design
%ASEN 2012
%Author: 681142c5cecc
%Created: 10/30/16
%Modified: 12/2/16

%PURPOSE: To determine the trajectory of a bottle rocket that lands it 85
%meters within one meter from the launch position. The purpose is to also
%determine the initial parameter that effects the flight the most.
%INPUT:This code calls functions to do these tasks.
%OUTPUT:The trajectory of the rocket, the initial air pressure that lands
%the rocket 85 meters away, and the variables that effect the height and
%distance the most. 
%ASSUMPTIONS:Isentropic fluid expansion, initial temperature of air is in
%equilibrium with STP

%House Keeping
clear all
close all
clc

%Main Script

%Four tragectory parameters: initial air pressure, initial volume
%fraction of water (initial mass), drag coefficient, launch angle.

%units: SI and Radians
%DEFINE CONSTANTS
g                       = 9.81;             %[m/s^2]
Cd                      = 0.8;              %discharge coefficient
rho_a                   = .961;             %[kg/m^3]
volume_rocket           = .002;             %[m^3] 
pa                      = 82943.93;         %[Pa]
gamma                   = 1.4;              %specific heat ratios
rho_water               = 1000;             %[kg/m^3]
At                      = ((.021/2)^2)*pi;  %[m^2]
A                       = ((.105/2)^2)*pi;  %[m^2]
R                       = 287;              %[J/(kg K)]
mass_rocket             =.07;               %[kg]
C                       = .5;               %drage coefficient
p0                      = 427681.93;        %[Pa] (absolute)
v0                      = .001;             %[m^3] 
T0                      = 300;              %[K]

%define initial conditions for each equation and store in matrix y
V0 = 0.0;        %[m/s]
theta0 = pi/4;   %[radians]
x0 = 0;          %[m]
z0 = .1;         %[m]
m0t = mass_rocket + rho_water*(volume_rocket - v0) + (p0*v0)/(R*T0); %[kg]
m0_air = (p0*v0)/(R*T0); %[kg]

tspan = [0 5];

%DETERMINE TRAJECTORY USING ODE45
y = [v0 V0 theta0 x0 z0 m0t m0_air];
[t,y] = ode45('trajectory',tspan,y);

%plot trajectory
figure
plot(y(:,4),y(:,5))
%title('Rocket Trajectory')
ylabel('Vertical Distance, m')
xlabel('Horizontal Distance, m')


%DETERMINE WHAT HAS THE GRAETEST EFFECT ON THE HEIGHT AND RANGE OF THE ROCKET 
%MonteCarlo
%DETERMINE WHAT PARAMETERS LAND YOU AT 85 METERS WITHIN 1 METER
%Land

%output test case horizontal distance
fprintf('Distance Travelled: %3.3f meters\n',max(y(:,4)))


