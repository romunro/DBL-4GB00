%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting for Energy Storage System Group 21    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%
% Graphing %
%%%%%%%%%%%%
t_var = table_flywheel(1,:);
Omega_flywheel = table_flywheel(2,:);
side_drag = table_flywheel(5,:);
top_drag = table_flywheel(6,:);
bearing_drag = table_flywheel(7,:);
motor_drag = table_flywheel(8,:);
E_energy = table_flywheel(3,:);
E_inflow = table_flywheel(4,:);
table_experiment = readmatrix(['datasets/CSVfiles/Dataset_2_angular_velocity.csv']);
ang_experiment = table_experiment(2,:);

%%Figure 1 for surplus
if generate_fig1 == true
    figure(1);hold on
    figure(1);grid on
    figure(1); plot(t_var,E_inflow);

    figure(1); ylabel('Inflow energy (kW)')
    figure(1); legend({'Inflow energy flywheel'}, 'Location','northeast')

    figure(1); xlim([0 0.025]);
    figure(1); xlabel('Time (hours)')
    figure(1); title('Inflow energy flywheel')
    figure(1); saveas(gcf,'figures\scale_inflowEnergy.jpg')
end

%%Figure 2 for flywheel rotation
if generate_fig2 == true
    figure(2);hold on
    figure(2);grid on
    figure(2); plot(t_var,Omega_flywheel);
    figure(2); plot(t_var,ang_experiment)

    figure(2); ylabel('Angular velocity [rad/s]')
    figure(2); legend({'Angular velocity [rad/s] MATLAB', 'Angular velocity [rad/s] Experiment'}, 'Location','northeast')

    figure(2); xlim([0 0.025]);
    figure(2); xlabel('Time (hours)')
    figure(2); title('Angular velocity flywheel')
    figure(2); saveas(gcf,'figures\scale_angularVelocity.jpg')
end

%%Figure 3 for losses
if generate_fig3 == true
    figure(3);hold on
    figure(3);grid on
    figure(3); plot(t_var,side_drag);
    figure(3); plot(t_var,top_drag);
    figure(3); plot(t_var,bearing_drag);
    figure(3); plot(t_var, motor_drag);


    figure(3); ylabel('Losses [kW]')
    figure(3); legend({'Losses due to side drag', 'Losses due to top drag', 'Losses due to bearing friction', 'Losses due to motor friction'}, 'Location','northeast')

    figure(3); xlim([0 0.025]);
    figure(3); xlabel('Time (hours)')
    figure(3); title('Losses to air drag in kW')
    figure(3); saveas(gcf,'figures\scale_airDrag.jpg')
end