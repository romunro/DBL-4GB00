%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting for Energy Storage System Group 21    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%
% Graphing %
%%%%%%%%%%%%
t_var = table_flywheel(1,:);
Omega_flywheel = table_flywheel(2,:);
E_energy = table_flywheel(3,:);
E_inflow = table_flywheel(4,:);

%%Figure 1 for surplus
if generate_fig1 == true
    figure(1);hold on
    figure(1);grid on
    figure(1); plot(t_var,E_inflow);

    figure(1); ylabel('Inflow energy (kWh)')
    figure(1); legend({'Inflow energy flywheel'}, 'Location','northeast')

    figure(1); xlim([0 time_end]);
    figure(1); xlabel('Time (hours)')
    figure(1); title('Inflow energy flywheel')
    figure(1); saveas(gcf,'figures\inflowEnergy.jpg')
end

%%Figure 2 for flywheel rotation
if generate_fig2 == true
    figure(2);hold on
    figure(2);grid on
    figure(2); plot(t_var,Omega_flywheel);

    figure(2); ylabel('Angular velocity [rad/s]')
    figure(2); legend({'Angular velocity [rad/s]'}, 'Location','northeast')

    figure(2); xlim([0 time_end]);
    figure(2); xlabel('Time (hours)')
    figure(2); title('Angular velocity flywheel')
    figure(2); saveas(gcf,'figures\angularVelocity.jpg')
end