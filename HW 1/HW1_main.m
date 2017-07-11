%Ben Hagenau
%Due: 9/9/16
%ASEN 2012
%Homework: 1
%Compute the net work done during a thermodynamic cycle where all processes
%are polytropic (p * v^n = C, n and C are constants). Data is read from a
%text file, calculations are made, and results are written to the command
%window, a text file, and are plotted.

%Housekeeping
clear all;
clc;
%Read File (number of processes, polytropic index(n), Pressure(Pa), and
%Volume(m^3) which are the properties in each state.
[num_cycle,cycle_var,n,P,V] = HW1_read_file('WorkInput.txt');
%Compute work done for each process, sum them to find the total work done,
%and display this information to the command window
[total_work,work,C,process_volumes,n] = HW1_calc_work(num_cycle,n,P,V);
%Write data to text file(DisplayFile.txt), and Plot P-V
[process_pressures] = HW1_display(work,num_cycle,P,V,total_work,C,n,process_volumes);


