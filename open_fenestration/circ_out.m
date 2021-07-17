%filename: circ_out.m
%script to plot results of computer simulation 
%of the entire circulation.

%right ventricular compliance, pressures, and flows:
figure(1)
subplot(2,1,1),plot(t_plot,P_plot([iRV],:),'linewidth',3)
title('Right Ventricular Pressure with Varying $A_0$', 'interpreter', 'latex')
xlabel('t (min)')
ylabel('P (mmHg)')
xlim([klokmax*dt-5*T klokmax*dt])
hold on
id = legend("$A_0 = 0.2$ cm$^2$", "$A_0 = 0.4$ cm$^2$","$A_0 = 0.6$ cm$^2$", 'interpreter', 'latex');
legend boxoff
set(gca,'fontsize',18)
subplot(2,1,2),plot(t_plot,P_plot([isa],:),'linewidth',3)
title('Blood Pressure with Varying $A_0$', 'interpreter', 'latex')
xlabel('t (min)')
ylabel('P (mmHg)')
xlim([klokmax*dt-5*T klokmax*dt])
hold on
id = legend("$A_0 = 0.2$ cm$^2$", "$A_0 = 0.4$ cm$^2$","$A_0 = 0.6$ cm$^2$", 'interpreter', 'latex');
legend boxoff
set(gca,'fontsize',18)

%systemic and pulmonary flows:
figure(2)
subplot(2,1,1), plot(t_plot,Q_plot([js],:),'linewidth',3)
title('Systemic Flows for Varying $A_0$', 'interpreter', 'latex')
xlabel('t (min)')
ylabel('Q (L/min)')
hold on
id = legend("$A_0 = 0.2$ cm$^2$", "$A_0 = 0.4$ cm$^2$","$A_0 = 0.6$ cm$^2$", 'interpreter', 'latex');
legend boxoff
set(gca,'fontsize',18)
xlim([klokmax*dt-5*T klokmax*dt])
subplot(2,1,2), plot(t_plot,Q_plot([jp],:),'linewidth',3)
title('Pulmonary Flows for Varying $A_0$', 'interpreter', 'latex')
xlabel('t (min)')
ylabel('Q (L/min)')
hold on
id = legend("$A_0 = 0.2$ cm$^2$", "$A_0 = 0.4$ cm$^2$","$A_0 = 0.6$ cm$^2$", 'interpreter', 'latex');
legend boxoff
set(gca,'fontsize',18)
xlim([klokmax*dt-5*T klokmax*dt])

figure(3)%pressure-volume loops for right ventricle
subplot(2,1,2),plot(V_plot(iRV,klokmax-T/dt:klokmax),P_plot(iRV,klokmax-T/dt:klokmax),'linewidth',3)
title('Pressure Volume Loop RV')
xlabel('V (L)')
ylabel('P (mmHg)')
hold on
id = legend("$A_0 = 0.2$ cm$^2$", "$A_0 = 0.4$ cm$^2$","$A_0 = 0.6$ cm$^2$", 'interpreter', 'latex');
legend boxoff
set(gca,'fontsize',18)


figure(4)
plot(t_plot,Q_plot([jFe],:),'linewidth',3)
title('Flow Through Fenestration for Varying $A_0$', 'interpreter', 'latex')
xlabel('t (min)')
ylabel('Q (L/min)')
xlim([klokmax*dt-5*T klokmax*dt])
hold on 
id = legend("$A_0 = 0.2$ cm$^2$", "$A_0 = 0.4$ cm$^2$","$A_0 = 0.6$ cm$^2$", 'interpreter', 'latex');
legend boxoff
set(gca,'fontsize',18)
xlim([klokmax*dt-5*T klokmax*dt])
% 
