clc
clear
close all

% Constants
rho = 1000;
P_o = 9910000;
sigma = 0.07495;
mu = 0.0015215;
R_o = [100, 10, 1, 0.001];
Reversal = [6, 1.75, .2, 0.00025];
Gridspace = [1e-4, 1e-5, 1e-6, 1e-9];

% Test Case number
tc = 1;

% Initial Values
R_cur = R_o(tc);
RP = Reversal(tc);
V_cur = 0;

i= 100000;
dt = Gridspace(tc);
t = linspace(0,i*dt,i+1);
PRINT_EVERY = 10000;

R = [] * i+1;
V = [] * i+1;

for c = 1 :i+1

    [R_cur, V_cur] = RK4_rayleigh_plesset(R_cur, V_cur, rho, sigma, mu, P_o, RP, dt);
    if mod(c, PRINT_EVERY) == 0 
        fprintf('\n c=%d, R_cur=%d, dt=%d' , c, R_cur ,V_cur);
    end
    R(c) = R_cur;
    V(c) = V_cur;

end

ttl = sprintf('Rayleigh-Plesset Equation, R_o = %.0d, ΔT= %.0d', R_o(tc), dt);
plot(t,R);
title(ttl);
grid on;
xlabel('t');
ylabel('R');


