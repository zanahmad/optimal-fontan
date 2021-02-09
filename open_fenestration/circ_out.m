%filename: circ_out.m
%script to plot results of computer simulation 
%of the entire circulation.

%right ventricular compliance, pressures, and flows:
figure(1)
subplot(2,1,1)
xlim([klokmax*dt-5*T klokmax*dt])
plot(t_plot,P_plot([iRV],:),'linewidth',3)
title('Right Ventricular Pressure with Varying Fenestration Sizes')
xlabel('t (min)')
ylabel('P (mmHg)')
xlim([klokmax*dt-5*T klokmax*dt])
id = legend("$A_0 = 0.1$cm$^2$", "$A_0 = 0.5$cm$^2$","$A_0 = 0.9$cm$^2$", "interpreter", "latex");
legend boxoff
set(gca,'fontsize',18)
hold on
subplot(2,1,2)
xlim([klokmax*dt-5*T klokmax*dt])
plot(t_plot,P_plot([isa],:),'linewidth',3)
title('Blood Pressure with Varying Fenestration Sizes')
xlabel('t (min)')
ylabel('P (mmHg)')
xlim([klokmax*dt-5*T klokmax*dt])
id = legend("$A_0 = 0.1$cm$^2$", "$A_0 = 0.5$cm$^2$","$A_0 = 0.9$cm$^2$", "interpreter", "latex");
legend boxoff
set(gca,'fontsize',18)
hold on



%systemic flows:
figure(2)
subplot(2,1,1)
plot(t_plot,Q_plot([js],:),'linewidth',3)
title('Systemic Flows for Varying Fenestration Sizes')
xlabel('t (min)')
ylabel('Q (L/min)')
id = legend("$A_0 = 0.1$cm$^2$", "$A_0 = 0.5$cm$^2$","$A_0 = 0.9$cm$^2$", "interpreter", "latex");
legend boxoff
set(gca,'fontsize',18)
xlim([klokmax*dt-5*T klokmax*dt])
hold on
subplot(2,1,2)
plot(t_plot,Q_plot([jp],:),'linewidth',3)
title('Pulmonary Flows for Varying Fenestration Sizes')
xlabel('t (min)')
ylabel('Q (L/min)')
id = legend("$A_0 = 0.1$cm$^2$", "$A_0 = 0.5$cm$^2$","$A_0 = 0.9$cm$^2$", "interpreter", "latex");
legend boxoff
set(gca,'fontsize',18)
xlim([klokmax*dt-5*T klokmax*dt])
hold on

figure(3)%pressure-volume loops for right ventricle
subplot(2,1,2),plot(V_plot(iRV,:),P_plot(iRV,:),'linewidth',1.5)
title('Pressure Volume Loop RV for Varying Fenestration Sizes')
xlabel('V (L)')
ylabel('P (mmHg)')
id = legend("$A_0 = 0.1$cm$^2$", "$A_0 = 0.5$cm$^2$","$A_0 = 0.9$cm$^2$", "interpreter", "latex");
legend boxoff
set(gca,'fontsize',18)
hold on

figure(4)
plot(t_plot,Q_plot([jFe],:),'linewidth',3)
title('Flow Through Fenestration for Varying Fenestration Sizes')
xlabel('t (min)')
ylabel('Q (L/min)')
xlim([klokmax*dt-5*T klokmax*dt])
id = legend("$A_0 = 0.1$cm$^2$", "$A_0 = 0.5$cm$^2$","$A_0 = 0.9$cm$^2$", "interpreter", "latex");
legend boxoff
set(gca,'fontsize',18)
hold on


