%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab model for Energy Storage System Group 21%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;

%%
%Settings
vacuumPercentage = 0;                                                          %Percentage of vacuum percentage [%]
numDays = 1;                                                              %Number of days in total efficiency calculation
%%
loadConstants;                                                              %Load constant from .m file
%%
%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%
%%% Read CSV data
table_energy = readmatrix(['datasets/CSVfiles/Quartile2.csv'])/1000;

%%% Setting up tables
Steps = time_end/time_step;                                                 %Amount of steps
table_flywheel = zeros(3,Steps+1);                                          %Heat vessel table for data logging
table_flywheel(1,:) = time_start:time_step:time_end;                        

%Mass calculations
m_flywheel = pi * r_flywheel^2 * d_flywheel * rho_flywheel;                 %Calculating the mass of the flywheel
I_flywheel = 0.5 * m_flywheel * r_flywheel^2;                               %Moment of inertia with respect to central axis

%Initial energy calculation
flywheel_energy = 0.5 * I_flywheel * flywheel_angular^2;                    %Starting energy flywheel

%%
%%%%%%%%%%%%%%%%%%%
% Numerical model %
%%%%%%%%%%%%%%%%%%%

for t=time_start:time_step:time_end
%Incoming energy
    Column = round((1/time_step)*t+1);                                      %Table time step counter
     
    flywheel_in = table_energy(2,Column);
    flywheel_in_joule = flywheel_in*3.6e+6;
    
    %flywheel_losses = pi * flywheel_angular^2 * r_flywheel^4 * d_flywheel * rho_air;
    side_drag = rho_air * A_sides * c_lin * flywheel_angular;
    top_drag = 1/5 * pi * c_lin * rho_air * flywheel_angular^2 * r_flywheel^5;
    bearing_loss = 1.05*10^(-4)* 0.002 * (m_flywheel) * 9.81 * (25/2) * flywheel_angular * 9.5493;
    if flywheel_angular > 0
        motor_loss = abs(flywheel_in_joule * 0.20);
    else
        motor_loss = 0;                                                     %To prevent energy loss from flywheel with no angular velocity
    end
    extra_loss = 0;
    
    flywheel_losses = side_drag + top_drag + bearing_loss + motor_loss + extra_loss;
    if (flywheel_angular <= 0) && (flywheel_in_joule <=0)
        flywheel_losses = 0;
        flywheel_in_joule = 0;
    end
    
    flywheel_in_joule = flywheel_in_joule - flywheel_losses;
    flywheel_energy = flywheel_energy + flywheel_in_joule;
    
    if flywheel_in_joule >= 0
        dt_flywheel_angular = sqrt((2 * flywheel_in_joule)/(I_flywheel));
    else
        flywheel_in_joule = flywheel_in_joule*-1;
        dt_flywheel_angular = -sqrt((2 * flywheel_in_joule)/(I_flywheel));
    end
   
    flywheel_angular = real(sqrt((2 * flywheel_energy)/(I_flywheel)));
       
    if flywheel_angular < 0
        flywheel_angular = 0;
        flywheel_energy = 0;
    end
    
    %Log data to table 
    table_flywheel(2,Column)=flywheel_angular;                              %Assign value for flywheel revolutions to table
    table_flywheel(3,Column)=flywheel_energy;                               %Assign value for flywheel energy to table
    table_flywheel(4,Column)=flywheel_in;                                   %Assign value for incomming flywheel energy to table
    table_flywheel(5,Column)=side_drag/3.6e+6;                              %Assign value for energy losses to table 
    table_flywheel(6,Column)=top_drag/3.6e+6;                               %Assign value for energy losses to table 
    table_flywheel(7,Column)=bearing_loss/3.6e+6;                           %Assign value for energy losses to table 
    table_flywheel(8,Column)=motor_loss/3.6e+6;                             %Assign value for energy losses to table 
    table_flywheel(9,Column)=flywheel_losses/3.6e+6;                        %Total losses in system
end
%%
%Settings plots
generate_fig1 = true;                                                       %Inflow energy graph
generate_fig2 = true;                                                       %Angular velocity flywheel graph
generate_fig3 = true;

plotGraphs;
%%
%Efficiency calculation
losses = sum(table_flywheel(9,:));
t=table_flywheel(4,:);
input = sum(t(t>0));
output = sum(t(t<0));

disp(['Total input energy [kWh]: ',num2str(numDays*input)])
disp(['Total output energy [kWh]: ',num2str(numDays*output)])
disp(['Total loss to air drag [kWh]: ',num2str(numDays*sum(table_flywheel(5,:) + table_flywheel(6,:)))])
disp(['Total loss to bearing friction [kWh]: ',num2str(numDays*sum(table_flywheel(7,:)))])
disp(['Total loss to motor friction [kWh]: ',num2str(numDays*sum(table_flywheel(8,:)))])
fprintf('\n')
disp(['Efficiency of system [%]: ',num2str(100 - losses / input * 100)])

%%
%Specific energy calculation
fprintf('\n')
E = K * (concrete_tensile / rho_flywheel) * m_flywheel / 3.6e+6;
E_calc = 0.5*I_flywheel * (max(table_flywheel(2,:))) ^2  /   3.6e6;
disp(['Theoretical storage capacity [kWh]: ', num2str(E)])
disp(['Maximum stored energy using max. angular velocity [kWh]: ', num2str(E_calc)])

