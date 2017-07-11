%ASEN 2012: HW 6
%Author: Ben Hagenau
%Date Created: 11/11/2016
%Date Edited: 11/17/16

%%%%%%%%%%%%%%%QUESTION: 4%%%%%%%%%%%%%%%
%PURPOSE: Use Bisection Method to find the friction factor of fluid through
%a pipe 
%GIVEN: Reynald's Number for the fluid
%OUTPUT: friction factor 
%ASSUMPTIONS: Roots are approximated using numerical root finding methods,
%there is one root, and roots are real.

%house keeping
clear all
close all
clc
%start output file
fprintf(fopen('HW6 Output4','w'),'Question 4:\n');

%define equation to be solved using bisection method
Re = [10^5 10^6];
for i = 1:2
    y = @(f) (2.*log(Re(i).*f.^(1/2)) - 0.8).*f.^(1/2) - 1;
    %Bisection Method
    %1. Select interval 
    a = 0.000001;
    b = 0.1;
    %2. Evaluate function at midpoint of interval
    m = mean([a b]);
    unc = abs(y(m));
    while unc > .0001
        if y(a)*y(m)<0
            b = m;
        else 
            a = m;
        end
        m = mean([a b]);
        unc = abs(y(m));
    end

    %plot function with its roots
    figure
    x = 0:.0001:0.2;
    hold on
    plot(x,y(x))
    plot(m,y(m),'*')
    txt = '  \leftarrow  Root';
    text(m,y(m),txt,'HorizontalAlignment','left')
    legend('Function of Friction Factor','Root','Location','Best');
    if i == 1
        title('Friction Factor of Turbulent Fluid Through a Pipe, Re = 10^5');
    else
        title('Friction Factor of Turbulent Fluid Through a Pipe, Re = 10^6');
    end
    %print results for each reynald's number
    fprintf(fopen('HW6 Output4','a'),'The coefficient of friction is %3.5f for a Reynolds Number of %d\n',m,Re(i));
end



