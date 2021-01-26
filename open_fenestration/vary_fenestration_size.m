clear all; close all;  clc;

% pulsatile code below
num_compliance_chambers = 5;
num_resistors = 6;
A0_vec = linspace( 0.002,  0.006, 3); %cross sectional area array in dm^2
mean_pressure = zeros(num_compliance_chambers, length(A0_vec));
mean_O2_concentration = zeros(num_compliance_chambers, length(A0_vec));
mean_flow = zeros(num_resistors, length(A0_vec));

for ii = 1:length(A0_vec)
    disp(ii)
    A0 = A0_vec(ii); %cross sectional area in dm^2
    circ   
    circ_out
    hold on
end




