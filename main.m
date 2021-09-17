%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab model for Energy Storage System Group 21%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;
loadConstants;

%%
%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%
%%% Read CSV data
table_energy = readmatrix('datasets\CSVfiles\Quartile2.csv');

%%% Setting up tables
Steps = time_end/time_step;                                                 %Amount of steps
table_flywheel = zeros(3,Steps+1);                                          %Heat vessel table for data logging
table_flywheel(1,:) = time_start:time_step:time_end;                        

%Mass calculations
m_flywheel = pi * r_flywheel^2 * rho_flywheel;                              %Calculating the mass of the flywheel
I_flywheel = 5;                                                             %Moment of inertia with respect to central axis

%%
%%%%%%%%%%%%%%%%%%%
% Numerical model %
%%%%%%%%%%%%%%%%%%%

for t=time_start:time_step:time_end
%Incoming energy
    Column = round((1/time_step)*t+1);                                      %Table time step counter

    flywheel_in = table_energy(2,Column);
    flywheel_in_joule = flywheel_in*3.6e+6;
    flywheel_energy = flywheel_energy + flywheel_in;
    
    %flywheel_losses = pi * flywheel_angular^2 * r_flywheel^4 * d_flywheel * rho_air;
    angular_drag = 0.5 * c_ang * flywheel_angular^2 * rho_air * 2 * pi * r_flywheel * d_flywheel;
    flywheel_losses = angular_drag;
    flywheel_in_joule = flywheel_in_joule - flywheel_losses;
    if flywheel_in_joule >= 0
        dt_flywheel_angular = sqrt((2 * flywheel_in_joule)/(I_flywheel));
    else
        flywheel_in_joule = flywheel_in_joule*-1;
        dt_flywheel_angular = -sqrt((2 * flywheel_in_joule)/(I_flywheel));
    end
    
    flywheel_angular = flywheel_angular + dt_flywheel_angular;
    
    if flywheel_angular < 0
        flywheel_angular = 0;
    end
    
    %Log data to table 
    table_flywheel(2,Column)=flywheel_angular;                              %Assign value for flywheel revolutions to table
    table_flywheel(3,Column)=flywheel_energy;                               %Assign value for flywheel energy to table
    table_flywheel(4,Column)=flywheel_in;                                   %Assign value for incomming flywheel energy to table
    table_flywheel(5,Column)=flywheel_losses;                               %Assign value for energy losses to table    

end
%%
%Settings plots
generate_fig1 = false;                                                       %Inflow energy graph
generate_fig2 = true;                                                       %Angular velocity flywheel graph

plotGraphs;
