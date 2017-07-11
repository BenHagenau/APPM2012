%ASEN 2012 Project 1 
%Author: 681142c5cecc
%Date Created: 10/21/16
%Date Modified: 10/21/16

%PURPOSE: This function plots data, lines of best fit, and relavant points
%INPUTS:Critical Temperatures and line of best fit data
%OUTPUTS:Plot of inputs
%ASSUMTIONS:N/A

function figure_plot(data_mat,Ctemp_avg,m1,m2,m3,b1,b2,b3,t,T0,t_placed,TH,T2,t_avg,C,C_unc,T0_unc,T1,T1_unc,T2_unc)
%plot average temperature-time graph and significant points
figure
plot(Ctemp_avg(:,1),Ctemp_avg(:,2))
hold on
%Plot...
%line of best fit 1
plot(t,m1*t+b1,'--')
%line of best fit 3
plot(Ctemp_avg([800:950],1),m3*Ctemp_avg([800:950],1)+b3,'--')
%line of best fit 2
plot(t,m2*t+b2,'--')
%plot T0/TL
plot(t_placed,T0,'*')
%plot TH and T2
plot(t_placed,TH,'*')
plot(t_avg,T2,'*')
%label graph and create legend
xlabel('Time, s')
ylabel('Temperature, degrees celcius')
legend('Averaged Calorimeter Temperature Data', 'First Fine of Best Fit', 'Second Line of Best Fit',...
    'Third Line of Best Fit', 'Initial Calorimeter Temperature/Low Estimate',...
    'High Estimate', 'Final Calorimeter Temperature','Location', 'best');
title('Calorimeter Temperature v.s. Time')
hold off

%plot boilding water temperature to show inconsistancy
figure
plot(1:1800,data_mat(:,5))
hold on
%plot verticle line to show where the data begins to get inconsistent
plot([700 700],get(gca,'ylim'))
xlabel('Time, s')
ylabel('Boilding water temperature, degrees celcius')
legend('Temperature of boiling water bath','Seperation of consistant and inconsistant data','Location','Best')
hold off

%display results of all calculations
fprintf('Temperature of Calorimeter When Sample is Placed: %3.3f °C\n', T0);
fprintf('Uncertainty in Temperature of Calorimeter When Sample is Placed: %3.3f °C\n', T0_unc);
fprintf('Initial Temperature of the Sample: %3.3f °C\n', T1);
fprintf('Uncertainty in Initial Temperature of Sample: %3.3f °C\n', T1_unc);
fprintf('Equilibrium Temperature of Sample and Calorimeter %3.3f °C\n', T2);
fprintf('Uncertainty in Equilibrium Temperature of Sample and Calorimeter %3.3f °C\n', T2_unc);
fprintf('Specific Heat of the Sample: %3.4f cal/(g °C)\n', C);
fprintf('Uncertainty in Specific Heat of the Sample: %3.3f cal/(g °C)\n', C_unc);
end