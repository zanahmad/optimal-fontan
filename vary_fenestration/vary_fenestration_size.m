clear all; close all;  clc;

% pulsatile code below
num_compliance_chambers = 5;
num_resistors = 6;
A0_vec = linspace( 0.00,  0.008, 10); %cross sectional area array in dm^2
mean_pressure = zeros(num_compliance_chambers, length(A0_vec));
mean_O2_concentration = zeros(num_compliance_chambers, length(A0_vec));
mean_flow = zeros(num_resistors, length(A0_vec));

for ii = 1:length(A0_vec)
    disp(ii)
    A0 = A0_vec(ii); %cross sectional area in dm^2
    circ   
    mean_pressure(:,ii) = compute_mean(T, dt, t_plot, P_plot);
    mean_O2_concentration(:,ii) = compute_mean(T, dt, t_plot, O2_plot);
    mean_flow(:,ii) = compute_mean(T, dt, t_plot, Q_plot);
    clearvars -except RFe A0_vec A0 mean_pressure mean_O2_concentration mean_flow;    
end

oxygen_delivery_vec=mean_O2_concentration(1,:) .* mean_flow(1,:);
[max_ox_deliv,optimal_index]=max(mean_O2_concentration(1,:) .* mean_flow(1,:));
optimal_size=A0_vec(optimal_index);


figure(600)
plot(A0_vec.*100, mean_O2_concentration(1,:) .* mean_flow(1,:),'linewidth',5);
xlabel("$A_{0}$ (cm$^2$)",'interpreter','latex')
ylabel('$Q[O_2]$ (Liters/min)','interpreter','latex')
title('oxygen delivery, varying $A_{0}$','interpreter','latex')
id = legend("Pulsatile");
legend boxoff
set(gca,'fontsize',18)

figure(601)
plot(A0_vec, mean_flow(1,:),'linewidth',5);
xlabel("$A_{0}$ (cm$^2$)",'interpreter','latex')
ylabel('$Q$ (Liters/min)','interpreter','latex')
title('cardiac output, varying $A_{0}$','interpreter','latex')
id = legend("Pulsatile");
legend boxoff
set(gca,'fontsize',18)

figure(602)
plot(A0_vec, mean_O2_concentration(1,:),'linewidth',5);
xlabel("$A_{0}$ (cm$^2$)",'interpreter','latex')
ylabel('$[O_2]$','interpreter','latex')
title('oxygen concentration,varying $A_{0}$','interpreter','latex')
id = legend("Pulsatile");
legend boxoff
set(gca,'fontsize',18)

