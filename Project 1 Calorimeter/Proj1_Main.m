%ASEN 2012 Project 1 
%Author: 681142c5cecc
%Date Created: 10/21/16
%Date Modified: 10/21/16

%PURPOSE: This program use temperature measurements, the first-law of thermodynamics and and least
%quares extrapolation to determine the specific heat of a sample 
%material and assess associate errors, and determine the possible material 
%from which the sample is made.
%INPUTS:N/A
%OUTPUTS:Specific Heat Capacity of Sample and Uncertainty
%ASSUMTIONS:N/A

%Main Script

%Clear
clear all;
clc;

%Define given variables
mass_cal = 313.5; %[g]
unc_mass_cal = 0.05; %[g]
C_cal = 0.214; %[Calories/(g C)] assumed exact
mass_sample = 91.75; %[g]
unc_mass_sample = 0.05; %[g]

%read file and store data in matrix
data_mat = readfile('data9AM.xlsx');

%Process the given data: calculate average temperature for each time and error 
%in average temp
[Ctemp_avg,Ctemp_unc] = calorimeter_avg_temp(data_mat);

%Determine matrices to be used in weighted least squares calculation for 
%all three trends of the average calorimeter temperature data and solve for
%coefficients with error their error. 
[Q1,fit1,fit2,fit3,fit1_unc,fit2_unc,fit3_unc,fit1_ext,fit2_ext,fit3_ext,Q2,t,m1,m2,m3,b1,b2,b3] = WLSMatrices(Ctemp_avg,Ctemp_unc,data_mat);

%Determine T0,T1,T2
[t_placed,r,T0,T0_unc,T1,T1_unc,T_avg,T2,T2_unc,TH,TL,t_avg] = temperature_determination(data_mat,Ctemp_avg,Ctemp_unc,fit1,fit2,fit1_unc,fit2_unc,fit1_ext,fit2_ext,Q2,b3,m3,m2,b2,Q1);

%Determine specific heat capacity and uncertainty
[C_unc,C,C_min,C_max] = specific_heat(T0,T0_unc,T1,T1_unc,T2,T2_unc,mass_cal,unc_mass_cal,C_cal,mass_sample,unc_mass_sample);

%plot data, lines of best fit, and relavant points
figure_plot(data_mat,Ctemp_avg,m1,m2,m3,b1,b2,b3,t,T0,t_placed,TH,T2,t_avg,C,C_unc,T0_unc,T1,T1_unc,T2_unc)