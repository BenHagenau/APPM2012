%Project II: Bottle Rocket Design
%ASEN 2012
%Author: 681142c5cecc
%Created: 10/30/16
%Modified: 12/2/16

%PURPOSE: To determine the initial conditions, varying innitial air
%pressure inside of the bottle, that lands the rocket 85 meters from its
%launch position within one meter. 
%INPUT: N/A
%OUTPUT:air pressure for final trajectory and distance traveled
%ASSUMPTIONS:Isentropic fluid expansion, initial temperature of air is in
%equilibrium with STP

function Land
global PL
PL = 427681.93;
distance_travelled = 0;
figure
while distance_travelled < 85
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
    p0                      = PL;        %[Pa] (absolute)
    v0                      = .001;             %[m^3]
    T0                      = 300;              %[K]
    
    %define initial conditions for each equation and store in matrix y
    V0 = 0.0;        %[m/s]
    theta0 = pi/4; %radians
    x0 = 0;        %[m]
    z0 = .1;       %[m]
    m0t = mass_rocket + rho_water*(volume_rocket-v0) + (PL*v0)/(R*T0);
    m0_air = (PL*v0)/(R*T0);
    
    %define time range
    tspan = [0 10];
    
    %call ode45
    y = [v0 V0 theta0 x0 z0 m0t m0_air];
    [t,y] = ode45('trajectoryL',tspan,y);
    
    %define max distance
    distance_travelled = max(y(:,4));
    max_distance = distance_travelled;
    %iterate initial air pressure
    PL = PL + 427681.93*.1;
    Initial_Air_Pressure = PL;
    %plot trajectories
    hold on
    plot(y(:,4),y(:,5));
    %title('Rocket Trajectories With Variable Pressure')
    ylabel('Vertical Distance, m')
    xlabel('Horizontal Distance, m')
end
figure
plot(y(:,4),y(:,5))
ylabel('Vertical Distance, m')
xlabel('Horizontal Distance, m')

%display results
fprintf('distance %3.3f\n',max_distance)
fprintf('Initial Air Pressure %3.3f\n',Initial_Air_Pressure)

