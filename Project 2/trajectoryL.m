%Project II: Bottle Rocket Design
%ASEN 2012
%Author: 681142c5cecc
%Created: 10/30/16
%Modified: 12/2/16

%PURPOSE: This is the file called by ODE45 which defines the differential
%equations when varying the initial air pressure in the bottle rocket. This
%file is called when calculating the initial air pressure that lands the
%rocket 85 meters from its initial position wihtin one meter.
%INPUT: time parameter and initial conditions
%OUTPUT: Differential equations for parameters tracked by ode45
%ASSUMPTIONS:Isentropic fluid expansion, initial temperature of air is in
%equilibrium with STP

function [out] = trajectoryL(t,y)
global PL
%DEFINE CONSTANTS
%units: SI and Radians
g                       = 9.81;             %[m/s^2]
Cd                      = 0.8;              %discharge coefficient
rho_a                   = .961;             %[kg/m^3]
volume_rocket           = .002;             %[m^3] 
pa                      = 82943.93;         %[Pa]
rho_water               = 1000;             %[kg/m^3]
At                      = ((.021/2)^2)*pi;  %[m^2]
A                       = ((.105/2)^2)*pi;  %[m^2]
R                       = 287;              %[J/(kg K)]
mass_rocket             =.07;               %[kg]
C                       = .5;               %drage coefficient
p0                      = PL;        %[Pa] (absolute)
v0                      = .001;             %[m^3] 
T0                      = 300;              %[K]
m0                      = (p0*v0)/(R*T0);   %[kg]

%define iterated values
VOL   = y(1);
V     = y(2);
THETA = y(3);
M     = y(6);
MAIR  = y(7); %GOES NEGATIVE TWICE (source)

if y(5) > 0 
%calculate drag
    D = (rho_a/2)*(V^2)*C*A;
%define pressure to be used in phase II
    p = (p0*(v0/volume_rocket)^1.4)*(MAIR/m0)^1.4;
%%%%%%%%%%%%%%%%%%%%%%STAGE I: WATER AND AIR IN BOTTLE%%%%%%%%%%%%%%%%%%%%%
    if VOL < volume_rocket
%determine pressure and drag factor at each time to be used in ODEs
        p = p0*(v0/VOL)^1.4; %note: this pressure value is fine
%determine thrust for stage 1
        Thrust = (2*Cd*(p - pa)*At);
%DEFINE ODEs FOR STAGE 1
        dVOLUMEAIRdt = Cd*At*sqrt((2*(p - pa)/rho_water));
        dMdt         = -(Cd*At)*sqrt(2*1000*(p - pa));
        dMAIRdt      = 0;
        dXdt         = V*cos(THETA);
        dZdt         = V*sin(THETA);
        dVdt         = ((Thrust)/M) - (D/M) - g*sin(THETA);
%create condition so that you ignore the change in theta for the first
%section of time because of the rails
         if V < 1
            dTHETAdt =  0;
         else
           dTHETAdt = -(g*cos(THETA))/V;
         end
    
%%%%%%%%%%%%%%%%%%%%%%%STAGE II: WATER EXHAUSTED%%%%%%%%%%%%%%%%%%%%%%%%%%%
%determine stage 2 pressure
   %[Pa] %note: this pressure value is fucked because of the MAIR
    elseif p > pa
%determine density of air
      rho = (MAIR)/volume_rocket; %[kg/m^3] Goes negative twice
%determine temperature of air 
      T = p/(rho*R); %[K] Temperature goes negative twice
%define critical pressure
      cp = p*(2/2.4)^(1.4/.4); %[Pa]
%CHOKED FLOW
        if cp > pa
            T_exit = T*(2/2.4); %T_exit becomes negative twice
            v_exit = sqrt(1.4*R*T_exit); %v_exit is imaginary twice
            rho_exit = cp/(R*T_exit);
        end 
%NOT CHOKED FLOW
        if cp <= pa
            MACH = sqrt(((p/pa)^(.4/1.4) - 1)*(2/.4));
            T_exit = T*(1+(.4/2)*MACH^2);
            v_exit = MACH*sqrt(1.4*R*T_exit);
            rho_exit = pa/(R*T_exit);
        end
%define pressure at the exit
        p_exit = rho_exit*R*T_exit;
%determine thrust
        Thrust = Cd*rho_exit*At*v_exit^2 + At*(p_exit - pa);
%DEFINE DIFFERENTIAL EQUATIONS
        dVOLUMEAIRdt = 0;
        dTHETAdt     = -(g*cos(THETA))/V;
        dMdt         = -Cd*rho_exit*At*v_exit;
        dMAIRdt      = -Cd*rho_exit*At*v_exit; %change in mass of air is imaginary twice
        dXdt         = V*cos(THETA);
        dZdt         = V*sin(THETA);
        dVdt         = ((Thrust)/M) - (D/M) - g*sin(THETA);
%%%%%%%%%%%%%%%%%%%%%%%%%%STAGE III: BALLISTIC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else
        dVOLUMEAIRdt = 0;
        dTHETAdt     = -(g*cos(THETA))/V;
        dMdt         = 0;
        dMAIRdt      = 0;
        dXdt         = V*cos(THETA);
        dZdt         = V*sin(THETA);
        dVdt         = -(D/M) - g*sin(THETA);
    end
else
    dVOLUMEAIRdt = 0;
    dMdt         = 0;
    dMAIRdt      = 0;
    dXdt         = 0;
    dZdt         = 0;
    dVdt         = 0;
    dTHETAdt     = 0;
end

out(1) = dVOLUMEAIRdt;
out(2) = dVdt;
out(3) = dTHETAdt;
out(4) = dXdt;
out(5) = dZdt;
out(6) = dMdt;
out(7) = dMAIRdt;
out = out';

end

