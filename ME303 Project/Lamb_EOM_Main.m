%Written by Adrian Chow
clc
clear
close all

% Constants
R_cur = 100;
V_cur = 0;
run_period = 10;
i= 10000;
Reversal = 7;

t = linspace(0,run_period,i);
dt = run_period/i;

R = [] * i;


for c = 1:i
    [R_cur, V_cur] = Lamb_EOM_RK4(R_cur, V_cur, Reversal, dt);
    %fprintf('\n c=%d, R_cur=%d, V_cur=%d' , c, R_cur ,V_cur); 
    R(c) = R_cur;
    
end

plot(t,R);
grid on;
xlabel('t');
ylabel('R');
