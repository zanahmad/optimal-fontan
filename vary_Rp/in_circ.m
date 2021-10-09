%filename: in_circ.m  (initialization for circ)
num_fixed_iter =10; 
heart_rate = 62.5; %beats per min 52.5 - 72.5
T=1/heart_rate; 

dt=0.01*T;%Time step duration (minutes)
          
klokmax=ceil(500*T/dt); %Total number of timesteps
%This choice implies simulation of 500 cardiac cycles.
TS=0.0050; 
tauS=0.0025;
tauD=0.0075;
tau1 = (0.269*T); % time scale of contraction (minutes)
tau2 = (0.452*T); % duration of systole (minutes)
m1 = 1.32;
m2 = 27.4;
%initialization of maxnum
tt=0:(T/1000):T;
g1=(tt/tau1).^m1;
g2=(tt/tau2).^m2;
g2T=(T/tau2)^m2;
G1=g1./(1+g1);
G2=(1./(1+g2)) - (1/(1+g2T));
maxnum = max(G1.*G2);

%Gorlin Equation Parameters
rho = 1000/(1.36*980*10*3600); %density of blood in mmHg min^2 / dm^2
R_visc = .001; %viscosity

isa=1;
isv=2;
ipa=3;
ipv=4;
iRV=5;
 N=5;


% specify resistance parameters

Rs=18.39*1.13;    % systemic organs
RTr=0.01;    % Tricuspid valve
RAo=0.01;    % aortic valve: connecting RV and sa
RFo=.01;     % Fontan connection
if (A0 > 0)
   RFe=R_visc; %R_visc;     %Fenestration resistance
else
   RFe = Inf;
end 
% specify dead volumes
Vsad=0.825/1.17; %0.825
Vpad=0.1135/1.22; %0.1135
Vsvd=3.5/1.22; %3.5
Vpvd=0.18/1.22;%.18
VRVd=0.028;%0.01
Vd=zeros(N,1);

% specify compliance parameters
Csa=(0.0011/1.5);
Cpa=0.00412;
Csv=0.09*1.1;
Cpv=.01;

CRVD=(.111-VRVd)/6.6;
CRVS=(.0517-VRVd)/124;


  

%parameters for elastance
EminRV =  1/CRVD;% (mmHg/L)
EmaxRV =  1/CRVS; % (mmHg/L)

        % need to understand how a nonzero RV dead volume
        % comes into play in the nonpulsatile model, in particular
	    % for the pump coefficient and calculation of the total volume
	    % used in the nonpulsatile model.


for klok=1:klokmax
  t=klok*dt;
  ERV(klok)=elastance(t,T,tau1,tau2,m1,m2,EminRV,EmaxRV,maxnum);
  tsave(klok) = t;
end
%plot(tsave,ERV)

%Assign an index to each compliance vessel 
%of the model Fontan circulation:
%took out LV and ordered numbers by path of circulation.


%Enter parameters and initial values 
%into correct slots in arrays.
%Note that the code that follows is independent 
%of the specific numbering scheme chosen above.
%Compliance vector:
C=zeros(N,1);  
%This makes C a column vector of length N.
  %initial value (removed)
C(isa)=Csa;
C(isv)=Csv;
C(iRV)=CV_now(0,CRVS,CRVD);  %initial value
C(ipa)=Cpa;
C(ipv)=Cpv;
C;  %This writes the result on the screen.

  
%This makes Vd a column vector of length N.
Vd(isa)=Vsad;
Vd(isv)=Vsvd;
Vd(iRV)=VRVd;
Vd(ipa)=Vpad;
Vd(ipv)=Vpvd;
Vd;

Vtotal=5; % set the total volume
Vdist = Vtotal - sum(Vd); % in Liters
%initialize volume of the ith compliance chamber
V(isa)=Vdist*(C(isa)/(C(isa)+C(isv)+C(iRV)+C(ipa)+C(ipv))) + Vd(isa);
V(isv)=Vdist*(C(isv)/(C(isa)+C(isv)+C(iRV)+C(ipa)+C(ipv))) + Vd(isv);
V(iRV)=Vdist*(C(iRV)/(C(isa)+C(isv)+C(iRV)+C(ipa)+C(ipv))) + Vd(iRV);
V(ipa)=Vdist*(C(ipa)/(C(isa)+C(isv)+C(iRV)+C(ipa)+C(ipv))) + Vd(ipa);
V(ipv)=Vdist*(C(ipv)/(C(isa)+C(isv)+C(iRV)+C(ipa)+C(ipv))) + Vd(ipv);
%Vector of dead volumes (volume at zero pressure);
%Note: Vd is only needed for output purposes.  
%It drops out of the equations we solve for P, 
%but we need it if we want to output (e.g., plot)  
%the volume of any compliance vessel.
 
%Pressure vector (initial values) at end of diastole:
P=zeros(N,1);  
%This makes P a column vector of length N.
P(isa)= (V(isa)-Vd(isa))/C(isa);
P(isv)= (V(isv)-Vd(isv))/C(isv);
P(iRV)= (V(iRV)-Vd(iRV))/C(iRV);
P(ipa)= (V(ipa)-Vd(ipa))/C(ipa);
P(ipv)= (V(ipv)-Vd(ipv))/C(ipv);
P; %This writes the result on the screen.


%Conductance matrix:
G=zeros(N,N);
G_old=zeros(N,N);
%This makes G an NxN matrix filled with zeros.
%Any element of G that is not explicitly 
%made nonzero remains zero, 
%thus modeling an infinite resistance connection, 
%that is, no connection at all.
  %But G(isa,iLV)=0 (no leak)
G(isa,isv)=1/Rs;   %no valve
G(isv,isa)=1/Rs;   %no valve
G(isv,ipa)=1/RFo;  %no valve 
G(ipa,isv)=1/RFo;  %no valve
G(ipa,ipv)=1/Rp;   %no valve
G(ipv,ipa)=1/Rp;   %no valve
G(ipv,iRV)=1/RTr;  %But G(iRV,ipv)=0; (no leak)
G(iRV,isa)=1/RAo;  %But G(isa,iRV)=0; (no leak) 
G(isv,ipv)=1./RFe;  
G(ipv,isv)=1./RFe;

G;  %This writes the result on the screen.
%Matrix of initial valve states:
S=zeros(N,N);   
%This makes S an NxN matrix filled with zeros
%(and writes it on the screen).
%Start with all valves closed.
%Valves will adjust to pressures 
%during first time step.
%Initialize arrays to store data for plotting:
t_plot=zeros(1,klokmax);
C_plot=zeros(N,klokmax);
P_plot=zeros(N,klokmax);
O2_plot = zeros(N,klokmax);
%Other variables that we might want to plot 
%can be found from these.
%For self-checking in P_new, set CHECK=1.
%To skip self-checking set CHECK=0.
%(should be much faster with CHECK=0)
CHECK=1;
%Initialize flow computation (for output purposes only)
%assign an index to each flow of interest:
jAo=1;
js =2;
jTr=3;
jFo=4;
jp =5;
jFe=6;
Nflows=6;
%note index of upstream and downstream chamber 
%for each flow:
iU=zeros(Nflows,1);
iD=zeros(Nflows,1);
iU(jAo)=iRV;
iD(jAo)=isa;
iU(js )=isa;
iD(js )=isv;
iU(jTr)=ipv;
iD(jTr)=iRV;
iU(jFo)=isv;
iD(jFo)=ipa;
iU(jp )=ipa;
iD(jp )=ipv;
iU(jFe)=isv;
iD(jFe)=ipv;

%oxygen stuff
oxy_vec = ones(N, 1) .* 0.2;
metabolism = zeros(size(G));
metabolism(isa, isv) = 0.1;

%extract the conductances from the matrix G:
Gf=zeros(Nflows,1);
Gr=zeros(Nflows,1);
for j=1:Nflows
  Gf(j)=G(iU(j),iD(j)); %forward conductance
  Gr(j)=G(iD(j),iU(j)); %reverse conductance
end
%create arrays to store current pressure differences 
%and history over time of the net flows:
Pdiff=zeros(Nflows,1);
Q_plot=zeros(Nflows,klokmax);


