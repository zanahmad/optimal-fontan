function E = elastance(t,T,tau1,tau2,m1,m2,Emin,Emax,maxnum)
tt=mod(t,T);
g1=(tt/tau1)^m1;
g2=(tt/tau2)^m2;
g2T=(T/tau2)^m2;
G1=g1/(1+g1);
G2=(1/(1+g2)) - (1/(1+g2T));
E=Emin + (Emax-Emin)*G1*G2/maxnum;

