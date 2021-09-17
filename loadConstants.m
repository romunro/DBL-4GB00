%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants for Energy Storage System Group 21   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
flywheel_angular = 0 ;                                                      %Starting angular velocity flywheel

r_flywheel = 0.85;                                                          %Radius of the flywheel
d_flywheel = 0.40;                                                          %Thickness of the flywheel
rho_flywheel = 7850;                                                        %Density of the material of which the flywheel is made (solid)
rho_air = 1.2041;                                                           %Density of air
c_lin = 1.17;                                                                  %linear air drag coefficient
c_ang = 0.01;