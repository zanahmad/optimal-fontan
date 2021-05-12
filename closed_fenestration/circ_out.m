%filename: circ_out.m
%script to plot results of computer simulation 
%of the entire circulation.

%right ventricular compliance, pressures, and flows:
figure(1)
subplot(2,1,1), plot(t_plot,C_plot(iRV,:),'linewidth',3)
title('Compliance v. Time of RV')
xlabel('t (min)')
ylabel('C (L/mmHg)')
xlim([klokmax*dt-5*T klokmax*dt])
figure(4)
subplot(2,1,1),plot(t_plot,P_plot([iRV,isa,ipa],:),'linewidth',3)
title('Pressure v Time (RV,sa,pa)')
xlabel('t (min)')
ylabel('P (mmHg)')
id = legend("RV", "sa","pa");
legend boxoff
set(gca,'fontsize',18)
xlim([klokmax*dt-5*T klokmax*dt])
subplot(2,1,2),plot(t_plot,Q_plot([jTr,jAo],:),'linewidth',3)
title('Flow v Time (Tr and Ao)')
xlabel('t (min)')
ylabel('Q (L/min)')
xlim([klokmax*dt-5*T klokmax*dt])
id = legend("Tr", "Ao");
legend boxoff
set(gca,'fontsize',18)
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
subplot(2,1,2),plot(V_plot(iRV,:),P_plot(iRV,:),'linewidth',3)
title('Pressure Volume Loop RV')
xlabel('V (L)')
ylabel('P (mmHg)')



