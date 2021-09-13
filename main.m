%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab model for Energy Storage System Group 21%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;

%%
%%%%%%%%%%%%%
% Constants %
%%%%%%%%%%%%%
%%%Starting values
time_start = 0;                                                             %Starting time
time_step = 0.25;                                                           %Time step, every 15 minutes
time_end = 24;                                                              %End time, after 24 hours
flywheel_in = 0;                                                            %Starting inflow energy
flywheel_energy = 0;                                                        %Starting energy flywheel
flywheel_rev = 0 ;                                                          %Starting revolutions flywheel, also energy

%%
%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%
%%% Read CSV data
table_energy = readmatrix('datasets\numericalEnergyData.csv');

%%% Setting up tables
Steps = time_end/time_step;                                                 %Amount of steps
table_flywheel = zeros(3,Steps+1);                                          %Heat vessel table for data logging
table_flywheel(1,:) = time_start:time_step:time_end;                        

%%
%%%%%%%%%%%%%%%%%%%
% Numerical model %
%%%%%%%%%%%%%%%%%%%

for t=time_start:time_step:time_end
%Incoming energy
    Column = round((1/time_step)*t+1);                                         %Table time step counter

    flywheel_in = table_energy(2,Column);
    flywheel_energy = flywheel_energy + flywheel_in;

    %Log data to table 
    table_flywheel(2,Column)=flywheel_rev;                                  %Assign value for flywheel revolutions to table
    table_flywheel(3,Column)=flywheel_energy;                               %Assign value for flywheel energy to table
    table_flywheel(4,Column)=flywheel_in;                                   %Assign value for incomming flywheel energy to table
end
%%
%%%%%%%%%%%%
% Graphing %
%%%%%%%%%%%%

