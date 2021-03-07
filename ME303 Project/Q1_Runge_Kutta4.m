clc
clear
close all

% Constants
rho = 1000;
lambda_sqrd = 75735750;
R_o = 0.002;
P_o = 100981;
T_star = pi / sqrt(lambda_sqrd);

R_cur = 0.002;
V_cur = 0;

i= 1000;
t = linspace(0,T_star,i);
dt = T_star/i;

R = [] * i;


for c = 1 :i
    [R_cur, V_cur] = RK4(R_cur, V_cur, rho, dt, lambda_sqrd, R_o, P_o);
    %fprintf('\n c=%d, R_cur=%d, V_cur=%d' , c, R_cur ,V_cur); 
    R(c) = R_cur;
    
end

plot(t,R);
grid on;
xlabel('t');
ylabel('R');


