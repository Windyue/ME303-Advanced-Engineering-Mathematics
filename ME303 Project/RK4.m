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


% R at t_i+1/2 using i values
R1 = R_cur + (dt/2) * V_cur;
V1_slope =  (lambda_sqrd * (R_o - R_cur) - 1.5 * (P_o / (rho*R_o)));
V1 = V_cur + (dt/2) * V1_slope;

% R at t_i+1/2 using i+1/2* values
R2_slope = V1;
R2 = R_cur + (dt/2) * R2_slope; 
V2_slope =  (lambda_sqrd * (R_o - R1) - 1.5 * (P_o / (rho*R_o)));
V2 = V_cur + (dt/2) * V2_slope;

% R at t_i+1/2 using i+1/2** values
R3_slope = V2;
R3 = R_cur + (dt/2) * R3_slope;
V3_slope = (lambda_sqrd * (R_o - R2) - 1.5 * (P_o / (rho*R_o)));
V3 = V_cur + (dt/2) * V3_slope;

% R at t_i+1 using i+1/2** values
V4_slope = (lambda_sqrd * (R_o - R3) - 1.5 * (P_o / (rho*R_o)));
V4 =  V_cur + dt * V4_slope;

% Modified Slopes
R_slope = (1/6) *((V1+V4) + 2*(V2+V3));
V_slope = (1/6) *((V1_slope+V4_slope) + 2*(V2_slope+V3_slope));

%fprintf('\n slope = %d', R_slope);

% RK4
R_fwd = R_cur + dt * R_slope;
V_fwd = V_cur + dt * V_slope;

end

