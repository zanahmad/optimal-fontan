clear all; close all;  clc;

% pulsatile code below
num_compliance_chambers = 5;
num_resistors = 6;
A0_vec = linspace(0.003,0.008, 100); %cross sectional area array in dm^2
mean_pressure = zeros(num_compliance_chambers, length(A0_vec));
mean_O2_concentration = zeros(num_compliance_chambers, length(A0_vec));
mean_flow = zeros(num_resistors, length(A0_vec));
Rp_vec = linspace(0.5,15 ,50);
for jj=1:length(Rp_vec)
    fprintf('%s %d \n', "Rp index = ", jj);
    Rp = Rp_vec(jj);
for ii = 1:length(A0_vec)
    fprintf('%s %d \n', "A0 index = ", ii);
    A0 = A0_vec(ii); %cross sectional area in dm^2
    circ
    mean_pressure(:,ii) = compute_mean(T, dt, t_plot, P_plot);
    mean_O2_concentration(:,ii) = compute_mean(T, dt, t_plot, O2_plot);
    mean_flow(:,ii) = compute_mean(T, dt, t_plot, Q_plot);
    clearvars -except RFe A0_vec A0 mean_pressure mean_O2_concentration mean_flow Rp_vec Rp optimal_size_plot jj;    
end
oxygen_delivery_vec = mean_O2_concentration(1,:) .* mean_flow(1,:);
[max_ox_deliv,optimal_index] = max(mean_O2_concentration(1,:) .* mean_flow(1,:));
optimal_size = A0_vec(optimal_index);
optimal_size_plot(jj) = optimal_size;
benefit(jj) = abs(max_ox_deliv - oxygen_delivery_vec(1))/(oxygen_delivery_vec(1)); 
save optimal_size_versus_Rp.mat
end

figure(1001)
plot( Rp_vec,optimal_size_plot.*100,'linewidth',5);
ylabel('$A_{0}$ (cm$^2$)','interpreter','latex')
xlabel("R$_p$ mmHg/(L/min)",'interpreter','latex')
title('Optimal Fenestration Area v. Pulmonary Resistance','interpreter','latex')
set(gca,'fontsize',18)

figure(102)
plot(Rp_vec, benefit.*100, 'linewidth', 5);
title('Optimal fenestration benefit for varying pulmonary resistance')
xlabel("R$_p$ mmHg/(L/min)",'interpreter','latex');
ylabel("% change in $Q[O_2]$" , 'interpreter', 'latex');
set(gca,'fontsize',18)