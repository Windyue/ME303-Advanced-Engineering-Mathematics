function [R_fwd, V_fwd] = explicit_euler(R_cur, V_cur, rho, dt, lambda_sqrd, R_o, P_o)

% Forward Euler: y_i+1 = y_i + Δt * f(t,y)

% (1): R_i+1 = Ri + Δt * R_i'
% (2): V_i+1 = Vi + Δt * V_i'

%{ 

System of Equations:

R_i+1 = Ri + Δt * V_i 
V_i+1 = Vi + Δt * ( λ^2 ( R_o - R_i ) - 1.5( P_o / ( ρ_1 * R_o ) ) )

where,

R_i' = V_i
V_i' = ( λ^2 ( R_o - R_i ) - 1.5( P_o / ( ρ_1 * R_o ) ) ) 

%}

R_fwd = R_cur + dt * V_cur;
V_fwd = V_cur + dt * (lambda_sqrd * (R_o - R_cur) - 1.5 * (P_o / (rho*R_o)));

end

