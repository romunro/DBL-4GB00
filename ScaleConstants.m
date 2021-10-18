%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants for Energy Storage System Experimental model Group 21   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%
% Constants %
%%%%%%%%%%%%%
%%%Starting values
time_start = 0;                                                             %Starting time                                                                                        
flywheel_in = 0;                                                            %Starting inflow energy
flywheel_angular = 200;                                                     %Starting angular velocity flywheel

m_disc = 1;
r_disc = 0.075;                                                          %Radius of the flywheel
d_disc = 0.03;                                                          %Thickness of the flywheel
rho_flywheel = 7200;                                                        %Density of the material of which the flywheel is made (Cast-iron)
rho_air = 1.2041;                                                           %Density of air
c_lin = 1.17;                                                               %linear air drag coefficient
c_ang = 1;                                                                  %angular drag coefficient
A_sides = 2 * pi * r_disc * d_disc;                                 %Area of the sides of the flywheel
A_top = pi * r_disc^2;                                                  %Drag of the top of the main cylinder
m_rod = 0.36378;                                                                  %mass of the central rod
r_rod = 0.01;
m_nuts = 0.19377;
r_nut = 0;
m_washers = 0.344;