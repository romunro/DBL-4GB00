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

r_flywheel = 0.85;                                                          %Radius of the flywheel
d_flywheel = 0.40;                                                          %Thickness of the flywheel
rho_flywheel = 7850;                                                        %Density of the material of which the flywheel is made (solid)

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

%Mass calculations
m_flywheel = pi * r_flywheel^2 * rho_flywheel;                              %Calculating the mass of the flywheel


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
t_var = table_flywheel(1,:);
E_energy = table_flywheel(3,:);
E_inflow = table_flywheel(4,:);
%%Figure 1 for surplus
figure(1);hold on
figure(1);grid on
figure(1); plot(t_var,E_inflow);

%figure(1); annotation('textarrow',[0.8 0.9], [0.88 0.845] ,'String','T = 317.7  K ');
%figure(1); annotation('textarrow', [0.45 0.33], [0.25 0.25], 'String', 'Thermocline effect');

figure(1); ylabel('Inflow energy (kWh)')
figure(1); legend({'Inflow energy flywheel'}, 'Location','northeast')

figure(1); xlim([0 time_end]);
figure(1); xlabel('Time (hours)')
figure(1); title('Inflow energy flywheel')
figure(1); saveas(gcf,'figures\inflowEnergy.jpg')

