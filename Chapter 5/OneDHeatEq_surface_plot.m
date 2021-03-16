% http://people.uncw.edu/hermanr/pde1/NumHeatEqn.pdf
% modified from R. L. Herman 
 
clear 
clc

L= 1;         % x in (0,L)
T= 0.5;       % t in (0,T)
k=1;    % conductivity
N=20;   % cut space 
M=5000; % cut time 
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

% Explict Scheme for 1D heat equation 
for j=1:M % time
for i=2:N % space
T1(i)=T0(i)+alpha*(T0(i+1)-2*T0(i)+T0(i-1));
end
T1(1)=0;
T1(N+1)=0;
T0=T1;
Temp(j,:)=T1;
end

%%
figure(2)
[X,Y] = meshgrid(0:dx:L,dt:dt:T);
mesh(X,Y,Temp)
colormap('hot')
xlabel('x'); ylabel('t'); zlabel('T(x,t)'); 
colorbar


