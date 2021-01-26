%filename: set_valves.m
%P_new solves for pressures given the state of the valves and it is
%easy to set the state of the valves if we are given pressures:

%set_valves script works to find self-consistent 
%valve states and pressures by setting each according to 
%the other until :
done=0; % not done yet!
while(~done)  %if not done, keep trying
  S_noted=S;  %note valve states 
  %set pressures based on valve states:
  P=P_new(P_old,C_old,C,S); 
  %then set valve states based on pressures:
  P_matrix=P*ones(1,N); %Takes column vector P and repeats in N times into an N x N matrix 
  S=((P_matrix) > (P_matrix')); %S(i,j) = (P(i)>P(j)) for all i,j
  %done if all valve states are unchanged:
  done=all(all(S==S_noted));
end
