function P=P_new(P_old,C_old,C,S)
%filename: P_new.m
%This is a function that solves the 
%linear system for the N unknown pressures. 

%valve states S are unknown as well, but we
%temporarily regard them as functions of the pressure. 

%P, P_old,C_old, and C are column vectors of length N

%G, C, S are all NxN matrices
global G dt CHECK N;
A=-dt*((S.*G)+(S.*G)'); %defines the off diagonal part of A (NxN)
A=diag(C-(sum(A))')+A; %adds the diagonal elements of A (NxN)
P=A\(C_old.*P_old); %solve the linear system AP = C(t-dt)P(t-dt)
if(CHECK)
  for i=1:N
    CH(i)=-(C(i)*P(i)-C_old(i)*P_old(i))/dt;
    for j=1:N
      CH(i)=CH(i)+S(j,i)*G(j,i)*(P(j)-P(i));
      CH(i)=CH(i)-S(i,j)*G(i,j)*(P(i)-P(j));
    end
  end
  CH;         %Write out the values of CH, 
%which should be zero to within roundoff.
end
