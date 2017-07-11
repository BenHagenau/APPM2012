%Ben Hagenau
%Due: 9/9/16
%ASEN 2012
%Homework: 1
%Read File (number of processes, polytropic index(n), Pressure(Pa), and
%Volume(m^3) which are the properties in each state.

%Define Function
function [num_cycle,cycle_var,n,P,V] = HW1_read_file(filepath)
%Open file
fileID = fopen(filepath);
%Read first line
line=fgets(fileID);
%Determine number of cycles by reading second line
num_cycle=str2num(fgets(fileID));
%Preallocate cell array to store all cycle variables
cycle_var={};
%Preallocate iterater to count through lines of cell
i=1;
%Create loop to store variables into cell from the file line by line
while line > -1 %stop loop when at bottom of file
    if line(1) ~= '#' %do not read lines that start with #
       cycle_var{i}=line;
       i=i+1;
    end
%get next line
line=fgets(fileID); 
end
%Change the cell of variables to a matrix of variables
cycle_var=(str2num(cell2mat(cycle_var)));
%Break matrix of all variables into 3 seperate matrices based on variable
%n,P,V.
n=cycle_var(:,1);
P=cycle_var(:,2);
V=cycle_var(:,3);       
end
    
    
    