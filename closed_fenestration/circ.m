%filename:  circ.m
clear all; close all; 
global T TS tauS tauD;
global G dt CHECK N;
in_circ;  %initialize
for klok=1:klokmax
  t=klok*dt;
  oxy_old_vec = oxy_vec;
  G_old=G;
  P_old=P;
  C_old=C;
  Pdiff_old = P_old(iU)-P_old(iD);
  Q_old = (Gf.*(Pdiff_old>0)+Gr.*(Pdiff_old<0)).*Pdiff_old;
  V_old = Vd + C_old.*P_old;
  %find current values of left and right 
  %ventricular compliance and store each 
  %of them in the appropriate slot in the array C:
  %C(iRV)=CV_now(t,CRVS,CRVD);
  C(iRV)=1/elastance(t,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);
  %find self-consistent valve states and pressures:
  set_valves
  %store variables in arrays for future plotting:
  t_plot(klok)=t;
  C_plot(:,klok)=C;
  P_plot(:,klok)=P;
  V_plot(:,klok)=Vd+C.*P;
  V = Vd+C.*P; 
  Pdiff=P(iU)-P(iD); %pressure differences 
                     %for flows of interest:
  Q_plot(:,klok)=(Gf.*(Pdiff>0)+Gr.*(Pdiff<0)).*Pdiff;
  %(the net flow is computed in each case)
 
 
  Qp = S(ipa,ipv)*G(ipa,ipv)*(P(ipa)-P(ipv));
  metabolism(ipa,ipv) = -(Qp * (0.2 - oxy_old_vec(ipa)));
    
  for i=1:N
      oxy_amt(i)=oxy_old_vec(i)*V_old(i);
      for j=1:N
          if j ~= i
             Qij = S(i,j)*G_old(i,j)*(P(i)-P(j));
             Qji = S(j,i)*G_old(j,i)*(P(j)-P(i));
             oxy_amt(i) = oxy_amt(i) + dt*(oxy_old_vec(j) * Qji - oxy_old_vec(i) * Qij - metabolism(j,i));
          end
      end
      oxy_vec(i) = oxy_amt(i)/V(i);
  end

  oxy_vec;
  O2_plot(:,klok) = oxy_vec;

end

CI = mean(Q_plot(js, (klokmax-10*T/dt): klokmax))/1.5; %cardiac index (L*min^-1*m^-2)
SVI = ((max(V_plot(iRV, (klokmax-10*T/dt):klokmax))-min(V_plot(iRV, (klokmax-10*T/dt):klokmax)))/1.5)*1000; %stroke volume index (mL m^-2)
RV_ED_VI = (V_plot(klokmax)*1000)/1.5; %RV end diastolic volume index (mL m^-2) assuming klokmax occurs at End Diastole
RV_ES_VI = ((min(V_plot(iRV, (klokmax-10*T/dt):klokmax))/1.5)*1000); %RV end systolic volume index (mL m^-2)
RV_ES_P = max(P_plot(iRV, (klokmax-10*T/dt):klokmax)); %RV end systolic pressure (mmHg)
RV_ED_P = P_plot(iRV, klokmax); %RV end diastolic pressure (mmHg), assuming klokmax occurs at End Diastole
sv_P_mean = mean(P_plot(isv, (klokmax-10*T/dt):klokmax));%vena cava mean pressure (mmHg)
sa_sys_P = max(P_plot(isa, (klokmax-10*T/dt):klokmax)); %systemic artery systolic pressure (mmHg)
sa_dias_P = min(P_plot(isa, (klokmax-10*T/dt):klokmax)); %systemic artery diastolic pressure (mmHg)
sa_P_mean = mean(P_plot(isa, (klokmax-10*T/dt):klokmax)); %systemic artery mean pressure (mmHg)
pa_P_mean = mean(P_plot(ipa, (klokmax-10*T/dt):klokmax)); %pul artery mean pressure (mmHg)

%display
fprintf('cardiac index (L*min^-1*m^-2):%i \n', CI)
fprintf('stroke volume index (mL m^-2):%i \n', SVI)
fprintf('RV end diastolic volume index (mL m^-2):%i \n', RV_ED_VI)
fprintf('RV end systolic volume index (mL m^-2):%i \n', RV_ES_VI)
fprintf('RV end systolic pressure (mmHg):%i \n', RV_ES_P)
fprintf('RV end diastolic pressure (mmHg):%i \n', RV_ED_P)
fprintf('vena cava mean pressure (mmHg):%i \n', sv_P_mean)
fprintf('systemic artery systolic pressure (mmHg):%i \n', sa_sys_P)
fprintf('systemic artery diastolic pressure (mmHg):%i \n', sa_dias_P)
fprintf('systemic artery mean pressure (mmHg):%i \n', sa_P_mean)
fprintf('pul artery mean pressure (mmHg):%i \n', pa_P_mean)


circ_out

