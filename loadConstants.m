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
time_end = 23.75;                                                           %End time, after 24 hours
flywheel_in = 0;                                                            %Starting inflow energy
flywheel_angular = 200;                                                     %Starting angular velocity flywheel

r_flywheel = 0.85;                                                          %Radius of the flywheel
d_flywheel = 0.40;                                                          %Thickness of the flywheel
rho_flywheel = 1440;                                                        %Density of the material of which the flywheel is made (Concrete)
rho_air = 1.2041;                                                           %Density of air
c_lin = 1.17;                                                               %linear air drag coefficient
c_ang = 1;                                                                  %angular drag coefficient
A_sides = 2 * pi * r_flywheel * d_flywheel;
A_top = pi * r_flywheel^2;                                                  %Drag of the top of the main cylinder