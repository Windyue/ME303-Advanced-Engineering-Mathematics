clc
clear
close all

% Constants
rho = 1000;
P_o = 9910000;
sigma = 0.07495;
mu = 0.0015215;

% Initial Values
R_cur = 100;
V_cur = 0;

i= 50000;
dt = 1e-9;
t = linspace(0,dt*i,i+1);


R = [] * i+1;

for c = 1 :i+1
    [R_cur, V_cur] = RK4_rayleigh_plesset(R_cur, V_cur, rho, sigma, mu, P_o, dt);
    fprintf('\n c=%d, R_cur=%d, V_cur=%d' , c, R_cur ,V_cur); 
    R(c) = R_cur;
    
end

plot(t,R);
grid on;
xlabel('t');
ylabel('R');


