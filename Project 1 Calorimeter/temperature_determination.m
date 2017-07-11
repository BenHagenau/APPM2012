%ASEN 2012 Project 1 
%Author: 681142c5cecc
%Date Created: 10/21/16
%Date Modified: 10/21/16

%PURPOSE:This function determines T0, T1, and T2
%INPUTS:Line of best fit data for each trend, averaged temperature data,
%raw temperature data
%OUTPUTS:initial temperature of calorimeter, equilibrium temperature,
%initial temperature of sample, and all corrosponding uncertainties.
%ASSUMTIONS:N/A


function [t_placed,r,T0,T0_unc,T1,T1_unc,T_avg,T2,T2_unc,TH,TL,t_avg] = temperature_determination(data_mat,Ctemp_avg,Ctemp_unc,fit1,fit2,fit1_unc,fit2_unc,fit1_ext,fit2_ext,Q2,b3,m3,m2,b2,Q1)
%DETERMINE THE TIME AND ROW WHEN THE SAMPLE WAS ADDED
times = [];
%window of values analyzed was observed from the graph. find the first
%point when the temperature begins to go up consistantly for all following
%times within the given window. The first value of this trend is the time 
%the sample was placed
for i = 800:850
    if Ctemp_avg(i,2) < Ctemp_avg(i+1,2)
        times = [times Ctemp_avg(i,1)];
    else 
        times = [];
    end
end
t_placed = times(1);
%find this time's corrosponding row value 
r = find(Ctemp_avg == times(1));

%DETERMINE CALORIMETER TEMPERATURE VALUE AND ERROR FOR WHEN THE
%SAMPLE WAS ADDED, T0, T0_unc
%determine value, temperature when sample was added
T0 = fit1_ext(r,2);
%determine error using extrapolation
T0_unc = sqrt([t_placed 1]*Q1*[t_placed 1]');

%DETERMINE INITIAL TEMPERATURE OF SAMPLE AND ERROR, T1, T1_unc
%determine value, average temperature of the boiling water used to heat the
%sample. Use the trend of data that is consistant
T1 = sum(data_mat(1:700,5))/length(1:700);
%determine error of the average temperature value of the water
T1_unc = sqrt(sum((data_mat(1:700,5) - T1).^2)/(length(1:700)-1));

%DETERMINE FINAL CALORIMETER TEMPERATURE AND ERROR, T2, T2_unc
%determine the over estimate of the final temperature of the calorimeter, 
%fit line 2 at time of sample placement, TH
for i = 1:length(fit2_ext)
    if fit2_ext(i,1) == t_placed
        TH = fit2_ext(i,2);
    end
end
%uncertainty in TH is uncertainty in the second line of best fit
TH_unc = fit2_unc;
%determine lower estimate, TL, of the final temperature of the calorimeter which
%is T0
TL = T0;
%uncertainty in TL is uncertainty in T0
TL_unc = T0_unc;
%final calorimeter temperature, T2, find time when temperature is average
%of high and low
T_avg = (TH + TL)/2;
%find the time when this occurs on fit3
t_avg = (T_avg - b3)/m3;
%determine T2 by plugging in t_avg to fit2
T2 = m2*t_avg + b2;
%determine error in T2, use extrapolation error
T2_unc = sqrt([t_avg 1]*Q2*[t_avg 1]');
end