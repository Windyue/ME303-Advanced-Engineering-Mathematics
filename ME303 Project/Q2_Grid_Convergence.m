clc
clear
close all

% Constants
rho = 1000;
P_o = 9910000;
sigma = 0.07495;
mu = 0.0015215;
R_o = 100;
Reversal = 6;
Gridspace = [1e-6, 1e-4, 1e-3, 1e-2, 1e-1];
i = [10000000, 100000, 10000, 1000, 100];

 R = [[],[],[],[],[]];
 V = [[],[],[],[],[]];
 E = [[],[],[],[],[]]; % Error

% Assume Analytical Solution as Numerical using 1e-6 grid spacing

% Test Case number

for s = 1 : length(i)

    tc = s;

    % Initial Values
    R_cur = R_o;
    V_cur = 0;

    dt = Gridspace(tc);
    t = linspace(0,i(tc)*dt,i(tc)+1);
    PRINT_EVERY = 10000;


    for c = 1 :i(tc)+1

        [R_cur, V_cur] = RK4_rayleigh_plesset(R_cur, V_cur, rho, sigma, mu, P_o, Reversal, dt);
        R(s,c) = R_cur;
        V(s,c) = V_cur;

    end
    
end

%Calculating Error
tp = linspace(0,10,101);

for k = 2: length(i)
    p = length(tp);
    for j = 1 : length(tp)
       analytical_idx = int32((10/Gridspace(1))/p);
       indx = int32((10/Gridspace(k))/p);
       %fprintf("\n analytical_idx=%d, indx=%d",analytical_idx,indx);
       E(k,j) =  abs(R(1,analytical_idx) - R(k, indx));
       p = p - 1;

    end
end


plot(tp(1:88), E(2,1:88)', 'b:*', tp(1:88), E(3,1:88)', 'g:*', tp(1:88), E(4,1:88)', 'r:*', tp(1:88), E(5,1:88)', 'm:*');
grid on;
leg = legend('ΔT=1e-4', 'ΔT=1e-3', 'ΔT=1e-2', 'ΔT=1e-1', 'Location', 'best');
xlabel('t(s)');
ylabel('Absolute Error (m)');
title('Absolute Error Against ΔT=1e-6');

