% http://people.uncw.edu/hermanr/pde1/NumHeatEqn.pdf
% modified from R. L. Herman 
 
clear 
clc
 
L= 1;         % x in (0,L)
T= 1;       % t in (0,T)
k=1;    % conductivity
N=100;   % cut space 
M=20000; % cut time 
dx=L/N; dt=T/M; % grid spacing
alpha=k*dt/dx^2;
 
% Position of nodes
for i=1:N+1
x(i)=(i-1)*dx;
end
 
% Initial Condition
for i=1:N+1
T0(i)=sin(pi*x(i));
end

% Explict Scheme for Partial Difference Equation 
for j=1:M % time
for i=2:N % space
T1(i)=T0(i)+alpha*(T0(i+1)-2*T0(i)+T0(i-1));
end

T1(1)=1;      % DBC left
T1(N+1)=-0.5; % DBC right

T0=T1;
Temp(j,:)=T1;
end

%% plot 2D
[X,Y] = meshgrid(0:dx:L,dt:dt:T);
mesh(X,Y,Temp); colormap('jet')
xlabel('x'); ylabel('t'); zlabel('T(x,t)'); colorbar

%% plot 1D 
plot(Temp(1,:)); hold on 
plot(Temp(10,:))
plot(Temp(100,:))
plot(Temp(1000,:))
plot(Temp(10000,:))
plot(Temp(20000,:))

xlabel('x'); ylabel('T(x,t)');

legend('t=0','t=0.0005','t=0.005','t=0.05','t=0.5','t=1')

