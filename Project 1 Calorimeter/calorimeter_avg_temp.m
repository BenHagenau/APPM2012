%ASEN 2012 Project 1 
%Author: 681142c5cecc
%Date Created: 10/21/16
%Date Modified: 10/21/16

%Purpose: This function determines the average temperature reading at each time
%value from the three thermocouples and its error
%Inputs: Matrix of raw data
%Outputs: Averaged temperature values for the calorimeter and uncertainty
%Assumptions: N/A



function [Ctemp_avg,Ctemp_unc] = calorimeter_avg_temp(data_mat)

%DETERMINE AVERAGE CALORIMETER TEMPERATURE WITH TIME (Ctemp_avg)
%preallocate
Ctemp_avg = zeros(length(data_mat),2);
%set time values to first column
Ctemp_avg(:,1) = data_mat(:,1);
%set average calorimeter temperature values in second column
for i = 1:length(data_mat)
    Ctemp_avg(i,2) = sum(data_mat(i,2:4))/3;
end
%DETERMINE UNCERTAINTY FOR EACH CALORIMETER TEMPERATURE TIME SET OF DATA (Ctemp_unc)
%calculate summation of three temperature readings for at each time use in
%uncertainty equation
Ctemp_unc = zeros(length(data_mat),1);
for i = 1:length(data_mat)
    for j = 2:4
        Ctemp_unc(i) = Ctemp_unc(i) + (Ctemp_avg(i,2) - data_mat(i,j))^2;
    end
%use summation in uncertainty equation
    Ctemp_unc(i) = (sqrt(Ctemp_unc(i)/2));
end
end