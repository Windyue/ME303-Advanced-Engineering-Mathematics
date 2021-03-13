function [R_next, V_next] = KK_EOM_RK4(R_cur, V_cur, Reversal, speed, dt)

w_i=@(R, R_slope)( ((9710003*0.001)*(1+R_slope/speed)-(1.5*(R_slope)^2)*(1-(R_slope)/(3*speed))) / (R*(1-(R_slope)/speed)));

%Estimate r at t_i+1 using R_slope at t_i
R1 = R_cur + (dt)* V_cur; %y*
V1_slope = w_i(R_cur, V_cur);
V1 = V_cur + (dt) * V1_slope;

%Estimate f* at t_i+1/2 using previous R1 value
R2_slope = V1; 
R2 =  R_cur + (dt/2) * R2_slope; 
V2_slope = w_i(R1, V1);
V2 = V_cur + (dt/2) * V2_slope;

%Estimate r at t_i+1/2 using V_1 at t_i+1/2
R3_slope = V2; 
R3 = R_cur + (dt/2)* R3_slope ;%y**
V3_slope = w_i(R2, V2);
V3 = V_cur + (dt/2) * V3_slope;

%Estimate r at t_i+1 using V_2 at t_i+1/2
V4_slope = w_i(R3, V3);
V4 = V_cur +(dt)* V4_slope;

%Calculate average slope
R_slope = (1/6) *((V1+V4) + 2*(V2+V3));
V_slope = (1/6) *((V1_slope+V4_slope) + 2*(V2_slope+V3_slope));

%fprintf('\n slope = %d', R_slope);

% RK4
R_next = R_cur + dt * R_slope;
V_next = V_cur + dt * V_slope;

if R_next < Reversal
    V_next = -V_next;
end

end
