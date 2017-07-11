%ASEN 2012 Project 1 
%Author: 681142c5cecc
%Date Created: 10/21/16
%Date Modified: 10/21/16

%PURPOSE:Determine matrices to be used in weighted least squares calculation for 
%all three trends of the average calorimeter temperature data and solve for
%coefficients with error their error.
%INPUTS:Average calorimeter data and uncertainty
%OUTPUTS:All matrices for lines of best fit, data for lines of best fit,
%and uncertainties
%ASSUMTIONS:N/A
 

function [Q1,fit1,fit2,fit3,fit1_unc,fit2_unc,fit3_unc,fit1_ext,fit2_ext,fit3_ext,Q2,t,m1,m2,m3,b1,b2,b3] = WLSMatrices(Ctemp_avg,Ctemp_unc,data_mat)
%store time values of the measurements to be used to extend the lines of
%best fit
t = data_mat(:,1);

%CREATE THE LINE OF LEAST FIT FOR THE FIRST SECTION OF DATA (BEFORE THE SAMPLE WAS PLACED)
%define data used to calculate the first line of least squares
data1 = Ctemp_avg(1:800,:);
%create 'A' matrix
A1 = ones(length(data1),2);
A1(:,1) = data1(:,1);
%create 'd' matrix 
d1 = data1(:,2);
%Set up Weight matrix (W1)
%create [1/unc^2] vector that will be used as the diagonal. Error comes from 
%error in the average temperature calculation (unc_vec1)
for i = 1:length(data1)
    unc_vec1(i) = 1/(Ctemp_unc(i))^2;
end
W1 = diag(unc_vec1);
%find coefficients for the first section using weighted least squares
coeff1 = ((A1'*W1*A1)^-1)*A1'*W1*d1;
m1 = coeff1(1);
b1 = coeff1(2);
%define time and corrosponding temperature values for line of best fit 1 in
%a matrix
fit1(:,1) = data1(:,1);
fit1(:,2) = m1*data1(:,1)+b1;
%extend line of best fit 1 to cover the domain of the data
fit1_ext(:,1) = data_mat(:,1);
fit1_ext(:,2) = m1*fit1_ext(:,1)+b1;
%CALCULATE UNCERTAINTY IN LINE OF BEST FIT AND COEFFICIENTS
fit1_unc = sqrt(sum(m1*fit1(:,1)+b1 - data1(:,2)).^2/(length(fit1)-2));
%calculate uncertainty in coefficients
Q1 = (A1'*W1*A1)^-1;

%CREATE THE LINE OF LEAST FIT FOR THE MIDDLE SECTION OF DATA (HEAT FROM SAMPLE 
%TO CALORIMETER)
%data for the line of least squares
data3 = Ctemp_avg(820:900,:);
%store uncertainty for these temperature values
data3_unc = Ctemp_unc(820:900);
%create 'A' matrix
A3 = ones(length(data3),2);
A3(:,1) = data3(:,1);
%create 'd' matrix 
d3 = data3(:,2);
%Set up Weight matrix (W3)
%create [1/unc^2] vector that will be used as the diagonal. Error comes from 
%error in the average temperature calculation (unc_vec3)
for i = 1:length(data3)
    unc_vec3(i) = 1/(data3_unc(i))^2;
end
W3 = diag(unc_vec3);
%find coefficients for the middle section
coeff3 = ((A3'*W3*A3)^-1)*A3'*W3*d3;
m3 = coeff3(1);
b3 = coeff3(2);
%define time and corrosponding temperature values for line of best fit 3 in
%a matrix
fit3(:,1) = data3(:,1);
fit3(:,2) = m3*data3(:,1)+b3;
%extend line of best fit 3 to cover the domain of the data
fit3_ext(:,1) = data_mat(:,1);
fit3_ext(:,2) = m3*fit3_ext(:,1)+b3;
%CALCULATE UNCERTAINTY IN LINE OF BEST FIT AND COEFFICIENTS
fit3_unc = sqrt(sum(m3*fit3(:,1)+b3 - data3(:,2)).^2/(length(fit3)-2));
%calculate uncertainty in fit 3 coefficients Q3
Q3 = (A3'*W3*A3)^-1;

%CREATE THE LINE OF LEAST FIT FOR THE THIRD SECTION OF DATA (POST-EQUILIBRIUM)
%data for the line of least squares
data2 = Ctemp_avg(1200:1800,:);
%store uncertainty for these temperature values
data2_unc = Ctemp_unc(1200:1800);
%create 'A' matrix
A2 = ones(length(data2),2);
A2(:,1) = data2(:,1);
%create 'd' matrix 
d2 = data2(:,2);
%Set up Weight matrix (W2)
%create [1/unc^2] vector that will be used as the diagonal. Error comes from 
%error in the average temperature calculation (unc_vec2)
for i = 1:length(data2)
     unc_vec2(i) = 1/(data2_unc(i))^2;
end
W2 = diag(unc_vec2);
%find coefficients for the first section
coeff2 = ((A2'*W2*A2)^-1)*A2'*W2*d2;
m2 = coeff2(1);
b2 = coeff2(2);
%define time and corrosponding temperature values for line of best fit 2 in
%a matrix
fit2(:,1) = data2(:,1);
fit2(:,2) = m2*data2(:,1)+b2;
%extend line of best fit 2 to cover the domain of the data
fit2_ext(:,1) = data_mat(:,1);
fit2_ext(:,2) = m2*fit2_ext(:,1)+b2;
%CALCULATE UNCERTAINTY IN LINE OF BEST FIT AND COEFFICIENTS
fit2_unc = sqrt(sum(m2*fit2(:,1)+b2 - data2(:,2)).^2/(length(fit2)-2));
%calculate uncertainty in fit 2 coefficients Q2
Q2 = (A2'*W2*A2)^-1;
end