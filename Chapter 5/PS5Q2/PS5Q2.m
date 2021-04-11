%{

 - A circular rod is12cm long and 2cm in diameter. 
- The rod is insulated on all surfaces and is initially at 15ºC. 
- For t>=0,  the x=0 end is heated by an electrical device that inputs 20watts of power to the rod. 
- The temperature Tx,t,of the rod is governed by the 1-D diffusion equation
- Subject to Neumann BCs at x=0 cm and x=12cm. 
- Choose Dx=2cm and Dt=0.5seconds. 
- Solve forT(x,t), numerically for 0<= t  >=150seconds by applying each of : 
    (i) the explicit scheme
    (ii) the fullyimplicit scheme.

- Material properties of the rod are: k=200W/(m*C) 
 alpha =0.00005 m^2/s 

For comparison, plot T vs. x at t =150seconds based on i and ii

%}

% Explicit Version 

clear all
clc

dx = 2;
dt = 0.5;

L=12;
T = 150;
k=200;
N=L/dx;
M=T/dt;
F=0.0625;


% Position of Nodes
for i = 1: N+1
       x(i) = (i-1) *dx;
end

% Initial Condition
for i = 1: N+1
      To(i) = 15;
end

Ti = To;
Temp(1,:) = To;
%Explicit Scheme

for j = 2: M+1 % Time
    for i = 2:N % Space
        Ti(i) = To(i) + F * ( To(i+1) - 2* To(i) + To(i-1) );
    end
    
    % First order BC

    Ti(1) = Ti(2) + 6.37;  %boundary condition at x= 0 
    Ti(N+1)  = Ti(N);  %ghost node at x =14
    
    To = Ti;
    Temp(j,:) = Ti;
    
end

figure(2)
[X,Y] = meshgrid(0:dx:L,0:dt:T);
mesh(X,Y,Temp)
colormap('hot')
xlabel('x'); ylabel('t'); zlabel('T(x,t)'); 
colorbar

% Implicit Version 

clear all
clc

nx = 7;
f =0.625; % We can use this value since implicit is more stable
A = zeros(nx,nx); % Matrix

for  i = 2: nx -1
    A(i, i-1) = -f;
    A(i,i) = (1+2*f);
    A(i, i+1) = -f;
end

% Neumann Boundary Conditions

A(1,1) = 1 +2*f ;
A(1,2) = -2*f;
A(end, end) = 1+2*f;
A(end, end-1) = -2*f;

% Initial Condition
b = 15 * ones(nx,1);
temp(1,:) = b;

for i = 2:30
        b(1) = b(1) + f * 12.74;
        x = A\b;
        temp(i,:) = x;
        b = x;
end

figure(2)
[X,Y] = meshgrid(0:1:nx-1,0:1:30-1);
mesh(X,Y,temp)
colormap('hot')
xlabel('x'); ylabel('t'); zlabel('T(x,t)'); 
colorbar


        