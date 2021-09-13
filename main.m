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
time_start = 0;
time_step = 0.25;
time_end = 24;

r_flywheel = 0.85;                                                          %Radius of the flywheel
d_flywheel = 0.40;                                                          %Thickness of the flywheel
rho_flywheel = 7850;                                                        %Density of the material of which the flywheel is made (solid)

%%
%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%

m_flywheel = pi * r_flywheel^2 * rho_flywheel;                              %Calculating the mass of the flywheel


%%
%%%%%%%%%%%%%%%%%%%
% Numerical model %
%%%%%%%%%%%%%%%%%%%

for t=time_start:time_step:time_end

end
%%
%%%%%%%%%%%%
% Graphing %
%%%%%%%%%%%%

