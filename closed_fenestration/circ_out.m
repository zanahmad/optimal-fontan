%filename: circ_out.m
%script to plot results of computer simulation 
%of the entire circulation.

%right ventricular compliance, pressures, and flows:
figure(1)
subplot(2,1,1),plot(t_plot,P_plot([iRV,isa,ipa],:),'linewidth',3)
title('Pressure v Time (RV,sa,pa)')
xlabel('t (min)')
ylabel('P (mmHg)')
id = legend("RV", "sa","pa");
legend boxoff
xlim([klokmax*dt-5*T klokmax*dt])
subplot(2,1,2),plot(t_plot,Q_plot([jTr,jAo],:),'linewidth',3)
title('Flow v Time (Tr and Ao)')
xlabel('t (min)')
ylabel('Q (L/min)')
xlim([klokmax*dt-5*T klokmax*dt])
id = legend("Tr", "Ao");
legend boxoff
%systemic and pulmonary flows:
figure(2)
plot(t_plot,Q_plot([js,jp],:),'linewidth',3)
title('Systemic and Pulmonary Flows')
xlabel('t (min)')
ylabel('Q (L/min)')
id = legend("Systemic", "Pulmonary");
legend boxoff
set(gca,'fontsize',18)
xlim([klokmax*dt-5*T klokmax*dt])

figure(3)%pressure-volume loops for right ventricle
subplot(2,1,2)
plot(V_plot(iRV,:),P_plot(iRV,:),'linewidth',3)
title('Pressure Volume Loop RV')
xlabel('V (L)')
ylabel('P (mmHg)')

figure(4)%compliance function
subplot(3,1,1),plot(t_plot,C_plot(iRV,:),'linewidth',3)
title('Compliance v. Time of RV')
xlabel('t (min)')
ylabel('C (L/mmHg)')
xlim([klokmax*dt-7*T klokmax*dt])

figure(5)
plot(t_plot,Q_plot([jFe],:),'linewidth',3)
title('Flow Through Fenestration for Varying Fenestration Sizes')
xlabel('t (min)')
ylabel('Q (L/min)')
xlim([klokmax*dt-5*T klokmax*dt])
set(gca,'fontsize',18)
hold on

