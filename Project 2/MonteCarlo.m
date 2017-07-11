%Project II: Bottle Rocket Design
%ASEN 2012
%Author: 681142c5cecc
%Created: 10/30/16
%Modified: 12/2/16

%PURPOSE: Determine which parameter affects range and height most: initial air 
%pressure, initial air volume, drag coefficient, or launch angle, 
%iterates from 0% to 200% of the allowable value under inspection
%INPUT: N/A
%OUTPUT: Max difference parameter that has the greatest difference between
%its 0% trajectory and its 200% trajectory for height and distance. Plots
%all trajectories for varied parameters
%ASSUMPTIONS:Isentropic fluid expansion, initial temperature of air is in
%equilibrium with STP



function MonteCarlo
clc
%define time interval
tspan = [0 10];
%define global variables
global C P vol

%units: SI and Radians
%DEFINE CONSTANTS
g                       = 9.81;             %[m/s^2]
Cd                      = 0.8;              %discharge coefficient
rho_a                   = .961;             %[kg/m^3]
volume_rocket           = .002;             %[m^3] 
pa                      = 82943.93;         %[Pa]
gamma                   = 1.4;              %specific heat ratios
rho_water               = 1000;             %[kg/m^3]
At                      = ((.021/2)^2)*pi;    %[m^2]
A                       = ((.105/2)^2)*pi;    %[m^2]
R                       = 287;              %[J/(kg K)]
mass_rocket             =.07;               %[kg]
C                       = .5;               %drage coefficient
p0                      = 427681.93;        %[Pa] (absolute)
v0                      = .001;             %[m^3] 
T0                      = 300;              %[K]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THETA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%define initial conditions for each equation and store in matrix y
V0 = 0;        %[m/s]
x0 = 0;        %[m]
z0 = .1;       %[m]
m0t = mass_rocket + rho_water*(volume_rocket-v0) + (p0*v0)/(R*T0); %[kg]
m0_air = (p0*v0)/(R*T0); %[kg]

%iterate through initial theta values varying theta from zero to pi/2 by
%10 of pi/4
theta0 = 0;
for i = 1:20
    theta0 = theta0 + ((pi/4)*.1); %radians
    yTHETA{1} = [v0 V0 theta0 x0 z0 m0t m0_air];
    [tT,yTHETA{i}] = ode45('trajectory',tspan, yTHETA{1});
    tTHETA{i} = tT;
end

%plot theta
figure
for i = 2:20
    x = yTHETA{i};
    x = x(:,4);
    y = yTHETA{i};
    y = y(:,5);
    plot(x,y);
    hold on 
end
%title('Trajectory of Rocket With Variable Launch Angle')
xlabel('Horizontal Distance, m')
ylabel('Vertical Distance, m')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% DRAG COEFFICIENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta0 = pi/4;
C = 0;
%iterate through drag coefficients adding 10% each time for 20 times
%starting at zero
for i = 1:20
    C = C + .5*(.1);
    yDRAG{1} = [v0 V0 theta0 x0 z0 m0t m0_air];
    [tD,yDRAG{i}] = ode45('DRAG_trajectory',tspan,yDRAG{1});
    tDRAG{i} = tD;
end
%plot drag coefficient trajectories
figure
for i = 2:20
    x = yDRAG{i};
    x = x(:,4);
    y = yDRAG{i};
    y = y(:,5);
   plot(x,y);
   hold on 
end
%title('Trajectory of Rocket With Variable Drag Coefficient')
xlabel('Horizontal Distance, m')
ylabel('Vertical Distance, m')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRESSURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = pa;
for i = 1:20
    P = P + 427681.93*(.1);
    m0t = mass_rocket + rho_water*(volume_rocket-v0) + (P*v0)/(R*T0); %[kg]
    m0_air = (P*v0)/(R*T0); %[kg]
    yPRES{1} = [v0 V0 theta0 x0 z0 m0t m0_air];
    [tP,yPRES{i}] = ode45('PRES_trajectory',tspan,yPRES{1});
    tPRES{i} = tP;
end
%plot pressure trajectories
figure
for i = 2:20
    x = yPRES{i};
    x = x(:,4);
    y = yPRES{i};
    y = y(:,5);
   plot(x,y);
   hold on 
end
%title('Trajectory of Rocket With Variable Initial Air Pressure')
xlabel('Horizontal Distance, m')
ylabel('Vertical Distance, m')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% VOLUME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vol = 0.0;
for i = 1:20
    vol = vol + volume_rocket*(.05) - .001;
    v0 = vol;
    yVOLU{1} = [v0 V0 theta0 x0 z0 m0t m0_air];
    [tV,yVOLU{i}] = ode45('VOLU_trajectory',tspan,yVOLU{1});
    tVOLU{i} = tV;
end
%plot pressure trajectories
figure
for i = 2:20
    x = yVOLU{i};
    x = x(:,4);
    y = yVOLU{i};
    y = y(:,5);
   plot(x,y);
   hold on 
end
%title('Trajectory of Rocket With Variable Initial Air Volume')
xlabel('Horizontal Distance, m')
ylabel('Vertical Distance, m')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DETERMINE THE RATES OF CHANGE IN THE HIGHT AND DISTANCE OF TRAJECTORY AS PARAMETERS
%INCREASE
%determine max hights and distances for each set of variable iterated
%sets of data
x_theta = zeros(1,20);
y_theta = zeros(1,20);
x_drag = zeros(1,20);
y_drag = zeros(1,20);
x_pres = zeros(1,20);
y_pres = zeros(1,20);
x_vol = zeros(1,20);
y_vol = zeros(1,20);

for i = 1:20
%theta max height and range
    xT = yTHETA{i};
    x_theta(i) = max(xT(:,4));
    yT = yTHETA{i};
    y_theta(i) = max(yT(:,5));
%drag max height and range
    xD = yDRAG{i};
    x_drag(i) = max(xD(:,4));
    yD = yDRAG{i};
    y_drag(i) = max(yD(:,5));
%pressure max height and range
    xP = yPRES{i};
    x_pres(i) = max(xP(:,4));
    yP = yPRES{i};
    y_pres(i) = max(yP(:,5));
%volume max height and range
    xV = yVOLU{i};
    x_vol(i) = max(xV(:,4));
    yV = yVOLU{i};
    y_vol(i) = max(yV(:,5));
end
clc

%determine which parameter effects height and distance the most by
%determining the difference between the max and min as they all vary
%between zero and 200% of their allowable values.
diff_range_max = 0;
diff_height_max = 0;
for i = 1:4
    if i == 1
        s = 'theta';
    end
    if i == 2
        s = 'drag';
    end
    if i == 3
        s = 'pres';
    end
    if i == 4
        s = 'vol';
    end
    diff_height = max(eval(sprintf('y_%s',s))) - min(eval(sprintf('y_%s',s)));
    diff_range = max(eval(sprintf('x_%s',s))) - min(eval(sprintf('x_%s',s)));
    if diff_range > diff_range_max
        diff_range_max = diff_range;
        paraR = s;
    end
    if diff_height > diff_height_max
        diff_height_max = diff_height;
        paraH = s;
    end
end
fprintf('max height difference: %3.3f - %s\n',diff_height_max,paraH);
fprintf('max range difference: %3.3f - %s\n',diff_range_max,paraR);

    
    
    