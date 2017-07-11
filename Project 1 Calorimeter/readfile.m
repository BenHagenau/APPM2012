%ASEN 2012 Project 1 
%Author: 681142c5cecc
%Date Created: 10/21/16
%Date Modified: 10/21/16

%Purpose:Read the raw temperature data and place it into a matrix
%Inputs:data9AM.xlsx
%Outputs:Matrix containing data
%Assumptions:N/A
function [data_mat] = readfile(fileID)
%read all numerical data from file into a matrix
data_mat = xlsread(fileID);