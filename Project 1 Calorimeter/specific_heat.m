%ASEN 2012 Project 1 
%Author: 681142c5cecc
%Date Created: 10/21/16
%Date Modified: 10/21/16

%PURPOSE:This function determines the specific heat capacity of the sample and 
%its uncertainty
%INPUTS:Critical temperature and their uncertainties, line of best fit
%equation data. 
%OUTPUTS:Specific heat capacity of sample and its uncertainty
%ASSUMTIONS:N/A

function [C_unc,C,C_min,C_max] = specific_heat(T0,T0_unc,T1,T1_unc,T2,T2_unc,mass_cal,unc_mass_cal,C_cal,mass_sample,unc_mass_sample)
%CALCULATE SPECIFIC HEAT CAPACITY OF SAMPLE
%specific heat equation: Cs = mc*Cc*(T2 - T0)/ms*(T1-T2)
C = mass_cal*C_cal*(T2-T0)/(mass_sample*(T1-T2)); %[Calories/(g C)]

%CALCULATE THE ERROR IN THE SPECIFIC HEAT OF THE SAMPLE USING QUADRATURE
%determine each differential term used in quadrature
%differential with respect to mass of calorimeter
C_mass_diff = (C_cal*(T2-T0)/(mass_sample*(T1-T2)))*unc_mass_cal;
%differential with respect to final temperature of calorimeter
T2_diff = ((mass_cal*C_cal/mass_sample)*((T1-T2)+(T2-T0))/(T1-T2)^2)*T2_unc;
%differential with respect to initial Calorimeter Temperature
T0_diff = ((-mass_cal*C_cal)/(mass_sample*(T1-T2)))*T0_unc;
%differential with respect to mass of the sample
mass_sample_diff = ((mass_cal*C_cal*(T2-T0)/(T1-T2))*(-1/mass_sample^2))*unc_mass_sample;
%differential with respect to initial temperature of sample
T1_diff = ((mass_cal*C_cal*(T2-T0)/(mass_sample))*(-1/(T1-T2)^2))*T1_unc;
%use these terms to calculate error via quadrature [Calories/(g C)]
C_unc = sqrt((C_mass_diff)^2 + (T2_diff)^2 + (T0_diff)^2 + (mass_sample_diff)^2 + (T1_diff)^2);
%determine max and min specific heat values
C_max = C + C_unc;
C_min = C - C_unc;
end