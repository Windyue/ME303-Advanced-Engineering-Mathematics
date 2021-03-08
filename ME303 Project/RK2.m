function [R_fwd, V_fwd] = RK2(R_cur, V_cur, rho, dt, lambda_sqrd, R_o, P_o)

% RK2: y_i+1 = y_i + Δt * (( f(t,y)* + f(t,y)) / 2 )

% (1): R_i+1 = Ri + Δt * R_i'
% (2): V_i+1 = Vi + Δt * V_i'

%{ 

System of Equations:

First, Explicit Euler:

R_i+1* = Ri + Δt * V_i 
V_i' = ( λ^2 ( R_o - R_i ) - 1.5( P_o / ( ρ_1 * R_o ) )
V_i+1* = Vi + Δt * V_i'

then Implicit Method,

R_i+1' = V_i+1*;
V_i+1' = (lambda_sqrd * (R_o - R_i+1*) - 1.5 * (P_o / (rho*R_o)));

then Modified Slope,

R_i+1 = Ri + Δt * 0.5(V_i + V_i+1*)
V_i+1 = Vi + Δt * 0.5(V_i' + V_i+1')


%}

V_slope=@(R)(lambda_sqrd * (R_o - R) - 1.5 * (P_o / (rho*R_o)));

% Foward Eulers
R1_slope = V_cur;
R1 = R_cur + dt * R1_slope;
V1_slope =  V_slope(R_cur);
V1 = V_cur + dt * V1_slope;

% Calculate Slope using Implicit Method
R2_slope = V1;
V2_slope =V_slope(R1);

% Modified Slopes
R_prime = 0.5 * (R1_slope + R2_slope);
V_prime = 0.5 * (V1_slope + V2_slope);

%fprintf('\n slope = %d', R_prime);

% RK2
R_fwd = R_cur + dt * R_prime;
V_fwd = V_cur + dt * V_prime;

end

