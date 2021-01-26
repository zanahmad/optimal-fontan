clear all; close all;  clc;
% this is a script to run the pulsatile and non-pulsatile 
%(steady state) model for different
% values of the the fenestration resistant RFe.
global RFe;

% pulsatile code below
num_compliance_chambers = 5;
num_resistors = 6;
RFe_vec = linspace(0.01, 5, 10);
mean_pressure = zeros(num_compliance_chambers, length(RFe_vec));
mean_O2_concentration = zeros(num_compliance_chambers, length(RFe_vec));
mean_flow = zeros(num_resistors, length(RFe_vec));

for ii = 1:length(RFe_vec)
    disp(ii)
    RFe = RFe_vec(ii);
    circ   
    mean_pressure(:,ii) = compute_mean(T, dt, t_plot, P_plot);
    mean_O2_concentration(:,ii) = compute_mean(T, dt, t_plot, O2_plot);
    mean_flow(:,ii) = compute_mean(T, dt, t_plot, Q_plot);
    clearvars -except RFe_vec RFe mean_pressure mean_O2_concentration mean_flow;    
end

% Steady state code below
%specify dead volumes
Vsad=0.825;
Vpad=0.0382;
Vsvd=0.0;
Vpvd=0.0;


Cstar = 0.2;
V0 = 5.8631; 
x=.0001;
Csa = 0.00175/3.0;
Csv = 1.75/3;
Cpa =0.00412/3;
Cpv = 0.08/3;

Rs = 1.5*17.5;
Rp0 = 1.79*1.5; % resistance in the lungs
M0 = 0.1;
RFo = 0.01; % Fontan Resistance
K1 = 80*0.0146*2; %F*C_diastole 
K2 = 80*0.00003*2;%F*C_systole 


T1 = ((Csa + Csv + Cpa + Cpv).*((1/K1)+(1/K1).*K2.*((Rs+(1/K1)+x)./(1-K2.*(1/K1)))) + Csa * Rs);
T2 = @(Rp) (Csa + Csv + Cpa) .* Rp;
T3 = (Csv+Csa) * RFo;

Q = @(x,Rp) ((V0-(Vsad+Vsvd+Vpad+Vpvd))./(T1 + (T2(Rp)+T3) .* (x./(Rp + x + RFo))));
O2 = @(x,M,Rp) Cstar - (M./Q(x,Rp)).*(Rp./x);
AO2 = @(x,M,Rp) Q(x,Rp).*O2(x,M,Rp);
Ppa = @(x,Rp) ( (x*Rp./(x + Rp)) + (1/K1) + (1/K1).*K2.*((Rs+(1/K1)+x)./(1-K2.*(1/K1))) ).*Q(x,Rp);

RFemin = 0.01;
RFemax = 5;
x = linspace(RFemin, RFemax, 1000);
x_with_zero = linspace(0, RFemax, 1000);

figure(500);
% nonpulsatile
plot(x,AO2(x,M0,Rp0),'linewidth',5); hold on
xlim([RFemin RFemax]);
ylim([0.5 1.75])
% pulsatile
plot(RFe_vec, mean_O2_concentration(1,:) .* mean_flow(1,:),'linewidth',5);
xlabel('$R_{Fe}$','interpreter','latex')
ylabel('$A_{O_2}$ (Liters/min)','interpreter','latex')
title('oxygen delivery, varying RFe')
id = legend("Steady-State", "Pulsatile");
legend boxoff
set(gca,'fontsize',18)

figure(501);
% nonpulsatile
plot(x,Q(x,Rp0),'linewidth',5); hold on
xlim([RFemin RFemax]);
% pulsatile
plot(RFe_vec, mean_flow(1,:),'linewidth',5);
xlabel('$R_{Fe}$','interpreter','latex')
ylabel('$Q$ (Liters/min)','interpreter','latex')
title('cardiac output, varying RFe')
id = legend("Steady-State", "Pulsatile");
legend boxoff
set(gca,'fontsize',18)
