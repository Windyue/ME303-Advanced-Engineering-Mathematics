clc
clear
close all

% Constants
R_cur = 100;
V_cur = 0;
run_period = 5;
i= 10000;
Reversal = 5;
speed = sqrt(2.15e9/1000);

t = linspace(0,run_period,i);
dt = run_period/i;

R = [] * i;


for c = 1:i
    [R_cur, V_cur] = KK_EOM_RK4(R_cur, V_cur, Reversal, speed, dt);
    %fprintf('\n c=%d, R_cur=%d, V_cur=%d' , c, R_cur ,V_cur); 
    R(c) = R_cur;
    
end

ttl = sprintf('Keller-Kolodner-EOM Equation, R_o = %.0d, ΔT= %.0d', 100, dt);
plot(t,R);
grid on;
xlabel('t(s)');
ylabel('R(m)');
title(ttl);