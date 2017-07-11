%Ben Hagenau
%Due: 9/9/16
%ASEN 2012
%Homework: 1
%Compute work done for each process, sum them to find the total work done,
%and display this information to the command window
%W = (P2*V2 - P1*V1)/(1-n) ... Special Case: when n=1, W = P1*V1*log(V2/V1)

%Define function
function [total_work,work,C,process_volumes,n] = HW1_calc_work(num_cycle,n,P,V)
%Preallocate matrix to store work done in each cycle
work=zeros(1,num_cycle);
%Calculate the work of each process and place them in the preallocated matrix excluding
%the of process 4 to 1(due to iteration loop through this is a special
%case)
for i=1:num_cycle-1
%Define variables for each process to be used in calculation
    n1=n(i);
    P1=P(i);
    P2=P(i+1);
    V1=V(i);
    V2=V(i+1);
%If isochoric n = +inf
    if V1==V2
        n1 = inf;
        n(i) = inf;
    end
%Create calculation for special case of n=1
    if n(i)==1
        work(i)=P1*V1*log(V2/V1);
%Create calculation for all other cases
    else
        work(i)=(P2*V2-P1*V1)/(1-n1);
    end

%Display process numer(state 1 to state 2) and work done during this process
    fprintf('Work done during process %d to %d: %f [Joules]\n',i,i+1,work(i))
end
%Find process work for special case of state 4 to 1
%Defind variables of the states to be analyzed
n1=n(end);
P1=P(end);
P2=P(1);
V1=V(end);
V2=V(1);
%If isochoric n = +inf
if V1==V2
    n1=inf;
    n(end)=inf;
end
%Determine special case of n=1 and define equation
if n(end)==1
     work(end)=P1*V1*log(V2/V1);
else
%Determine calculation for all other cases (n~=1)
    work(end)=(P2*V2-P1*V1)/(1-n1);
end

%Display value for state 4 to 1 process
fprintf('Work done during process %d to %d: %f [Joules]\n',num_cycle,1,work(end))
%Sum the work from each process and use uint64 to store as the full
%value precision
total_work=int64(sum(work));
%Display total work
fprintf('Total work done during cycle: %f [Joules]\n',total_work);

%Calculate C for each process: PV^n=C (where n and C are constants)
C=zeros(1,num_cycle);
for i=1:num_cycle
    C(i)=P(i)*V(i)^n(i);
end

%Calculate more volume points on the line to determine curve, the volume
%will at some point be all volume values inbetween the two states(100
%points total)
%Preallocate cell to hold matrices of volume values,v, for each process
process_volumes=cell(1,num_cycle);
for i=1:num_cycle-1
    process_volumes{i}=linspace(V(i),V(i+1),100);
end
%Create volume values for end state to initial state process
process_volumes{num_cycle}=linspace(V(num_cycle),V(1),100);
end