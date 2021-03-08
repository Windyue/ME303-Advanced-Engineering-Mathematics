clc
clear
close all

% Constants
rho = 1000;
lambda_sqrd = 75735750;
R_o = 0.002;
P_o = 100981;
T_star = pi / sqrt(lambda_sqrd);

i= 100000;
t = linspace(0,T_star,i);
dt = T_star/i;

% This is our analytical solution: y
y=@(x)(0.001 * cos(sqrt(lambda_sqrd) * x) + 0.001);

% R Values from Forward Euler
R_Euler_Vals = [] * i;
R_Euler = 0.002;
V_Euler = 0;

% R Values from Rk2
R_RK2_Vals = [] * i;
R_RK2 = 0.002;
V_RK2 = 0;

% R Values from Rk4
R_RK4_Vals = [] * i;
R_RK4 = 0.002;
V_RK4 = 0;


for c = 1 :i
    
    % Forward Pass
    [R_Euler, V_Euler] = explicit_euler(R_Euler, V_Euler, rho, dt, lambda_sqrd, R_o, P_o);
    [R_RK2, V_RK2] = RK2(R_RK2, V_RK2, rho, dt, lambda_sqrd, R_o, P_o);
    [R_RK4, V_RK4] = RK4(R_RK4, V_RK4, rho, dt, lambda_sqrd, R_o, P_o);
    
    % Store Values
    R_Euler_Vals(c) = R_Euler;
    R_RK2_Vals(c) = R_RK2;
    R_RK4_Vals(c) = R_RK4;
    
end

% Errors
Euler_Error = R_Euler_Vals - y(t);
RK2_Error = R_RK2_Vals - y(t);
RK4_Error = R_RK4_Vals - y(t);

Euler_Max_Error = max(abs(Euler_Error));
RK2_Max_Error = max(abs(RK2_Error));
RK4_Max_Error = max(abs(RK4_Error));

script = '\n Maximum Error: Euler = %d, RK2 = %d, RK4 = %d';

fprintf(script, Euler_Max_Error, RK2_Max_Error, RK4_Max_Error);

plot(t, y(t), t, R_Euler_Vals, t, R_RK2_Vals, t, R_RK4_Vals);
legend('Analytical', 'Euler', 'RK2', 'RK4')
grid on;
xlabel('t');
ylabel('R');



