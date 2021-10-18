%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab model for Energy Storage System Group 21%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;
ScaleConstants;

%%
%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%
%%% Read CSV data
table_energy = readmatrix(['datasets/CSVfiles/Dataset_2.csv']);

%%% Setting up tables                                                       %Heat vessel table for data logging
table_flywheel(1,:) = table_energy(1,:)                      

%Mass calculations
m_flywheel = m_disc + m_rod + m_nuts + m_washers;                           %Calculating the mass of the flywheel
I_flywheel = 0.5 * m_disc * r_disc^2 ;                                      %Moment of inertia with respect to central axis

%Initial energy calculation
flywheel_energy = 0.5 * I_flywheel * flywheel_angular^2;                    %Starting energy flywheel

%%
%%%%%%%%%%%%%%%%%%%
% Numerical model %
%%%%%%%%%%%%%%%%%%%
Column = 0;
for t=table_energy(1,:)
%Incoming energy
    Column = Column + 1;                                                    %Table time step counter
     
    flywheel_in = table_energy(2,Column);
    flywheel_in_joule = flywheel_in*3.6e+6;
    
    %flywheel_losses = pi * flywheel_angular^2 * r_flywheel^4 * d_flywheel * rho_air;
    side_drag = rho_air * A_sides * c_lin;
    top_drag = 0.5 * rho_air * (r_disc * flywheel_angular)^2 * c_ang * 2 * pi * r_disc;
    bearing_loss = 0;
    motor_loss = 0;
    extra_loss = 0;
    
    flywheel_losses = side_drag + top_drag + bearing_loss + motor_loss + extra_loss;
    flywheel_in_joule = flywheel_in_joule - flywheel_losses;
    flywheel_energy = flywheel_energy + flywheel_in_joule;
    
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
    table_flywheel(5,Column)=side_drag/3.6e+6;                              %Assign value for energy losses to table 
    table_flywheel(6,Column)=top_drag/3.6e+6;                               %Assign value for energy losses to table 

end
%%
%Settings plots
generate_fig1 = true;                                                       %Inflow energy graph
generate_fig2 = true;                                                       %Angular velocity flywheel graph
generate_fig3 = true;

plotGraphs;
