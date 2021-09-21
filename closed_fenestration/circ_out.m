%filename: circ_out.m
%script to plot results of computer simulation 
%of the Fontan circulation.

%right ventricular compliance, pressures, and flows:
figure(1)
subplot(2,1,1)
plot(t_plot,C_plot(iRV,:).*1000,'linewidth',3)
title('Compliance v. Time of RV')
xlabel('t (min)')
ylabel('C (mL/mmHg)')
xlim([klokmax*dt-5*T klokmax*dt])

subplot(2,1,2) 
plot(t_plot, (1./C_plot(iRV,:))./1000, 'linewidth', 3)
title('Elastance v. Time or RV')
xlabel('t (min)')
ylabel('E (mmHg/mL)')
xlim([klokmax*dt-5*T klokmax*dt])


figure(2)
subplot(2,1,1),plot(t_plot,P_plot([iRV,isa,ipa],:),'linewidth',3)
title('Pressure v. Time (RV,sa,pa)')
xlabel('t (min)')
ylabel('P (mmHg)')
xlim([klokmax*dt-5*T klokmax*dt])
id = legend("RV", "sa", "pa");
legend boxoff
set(gca,'fontsize',18)
subplot(2,1,2),plot(t_plot,Q_plot([jTr,jAo],:),'linewidth',3)
title('Flow v. Time (Tr and Ao)')
xlabel('t (min)')
ylabel('Q (L/min)')
xlim([klokmax*dt-5*T klokmax*dt])
id = legend("Tr", "Ao");
legend boxoff
set(gca,'fontsize',18)

%systemic and pulmonary flows:
figure(3)
plot(t_plot,Q_plot([js,jp],:),'linewidth',3)
title('Systemic and Pulmonary Flows')
xlabel('t (min)')
ylabel('Q (L/min)')
id = legend("Systemic", "Pulmonary");
legend boxoff
set(gca,'fontsize',18)
xlim([klokmax*dt - 5*T klokmax*dt])

figure(4)%pressure-volume loops for right ventricle
plot(V_plot(iRV,klokmax-T/dt:klokmax),P_plot(iRV,klokmax-T/dt:klokmax),'linewidth',3)
hold on
plot([VRVd,.125],[0,EminRV*(.125-VRVd)],'linewidth', 3)
hold on
plot([VRVd,.075],[0,EmaxRV*(.075-VRVd)],'linewidth', 3)
hold on
plot(.111,6.6,'r*','linewidth',3)
plot(.0517,124,'b*','linewidth',3)
title('Right Ventricular Pressure-Volume Loop')
xlabel('V (L)')
ylabel('P (mmHg)')

figure(5)
subplot(2,1,1),plot(t_plot, V_plot.*O2_plot(1:end,:),'linewidth',3)
xlabel('t (min)')
ylabel('V (L)')
id = legend('sa','sv','pa','pv','RV');
set(id, 'location', 'northeast')
title('Oxygen volume in each chamber')
xlim([klokmax*dt-5*T klokmax*dt])
subplot(2,1,2),plot(t_plot, O2_plot([2,5],:),'linewidth',3)
xlabel('t (min)')
ylabel('[O$_2]$','interpreter','latex')
title('Oxygen concentration in each chamber')
xlim([klokmax*dt-5*T klokmax*dt])
id = legend('sv,pa','pv,RV,sa');
set(id, 'location', 'northeast')
