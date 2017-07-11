%Ben Hagenau
%Due: 9/9/16
%ASEN 2012
%Homework: 1
%Write data to text file(DisplayFile.txt), and Plot P-V

%Define function
function [process_pressures] = HW1_display(work,num_cycle,P,V,total_work,C,n,process_volumes)
%Open target text file
fileID = fopen('DisplayFile.txt','w');
%Write number of processes to the text file 
fprintf(fileID,'Number of Processes: %d\n', num_cycle);
%Write work done for each process to the text file
for i=1:num_cycle
    fprintf(fileID,'Work for process %d: %f [Joules]\n', i, work(i));
end
%Write total work done during cycle to the text file
fprintf(fileID, 'Total work done during cycle: %f [Joules]', total_work);

%open figure
figure
%Plot P-V as points
plot(V,P,'*')
%Label x and y axis
xlabel('Volume [m^3]')
ylabel('Pressure [Pa]')
%Title graph
title('Pressure - Volume Graph For a Polytropic Process');
%Keep figure window 
hold on
        

%Define pressure as a function of volume, p=C/(V^n)
for i=1:num_cycle-1 %define variables that are constant for a process
n1=n(i);
c1=C(i);
%Input volume values for process and determine pressure equivilents while using constants of each process
    for j=1:100 
        process_pressures{1,i}(j)=c1/(process_volumes{1,i}(j)^n1);
    end
end
%Calculate pressure for special case of first and last state process
n1=n(num_cycle);
c1=C(num_cycle);
for k=1:100
    process_pressures{num_cycle}(k)=c1/(process_volumes{num_cycle}(k)^n1);
end
%Plot process paths connecting state points
for i=1:num_cycle
    plot(process_volumes{1,i},process_pressures{1,i})
%Label each point by state
    str={'State' i};
    text(V(i),P(i),str)
%Keep figure window
    hold on
end
end
