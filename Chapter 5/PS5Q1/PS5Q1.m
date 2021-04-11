%{
- Consider a square plate of length1 unit with thermal diffusivity a=1. 
- (This is an imaginary material as most physical material shave diffusivities orders of magnitude lower than 1).
- Solve the transient 2D heat equation using a second order scheme for spatial derivatives and 
  an explicit time marching method. 
- Divide the domain such that both x and y directions have 30 nodes. 
- Choose Dt=0.0002s. Plot the temp distribution at t=0 , 0.15s.

IC & BC:

T(x,y,0) = sin(5πx)cos(4πy)
T(x=0,y,t) = sin(πy) = T{0,j}
T(x,y=1,t) = 0 = T{i,1}
T(x=1,y,t) = sin(πy) = T{30,j}
T(x,y=0,t) = 0 = T{i,0}

%}

clear all
clc

x = linspace(0,1,30);
y = linspace(0,1,30);
[X,Y] = meshgrid(x,y);

% change in x and y
dx = x(2) - x(1);
dy = y(2) - y(1);
dt = 0.0002;

% dirichlet boundary
T_old = sin(5*pi*X) .* cos(4*pi*Y); % Matrix multiply
B1 = sin(pi*y);
B2 = 0;
B3 = 0;
B4 = sin(pi*y);
% Index like T_old(y,x)
T_old(:,1) = B1; % T(x=0,y,t) = sin(πy) = T{0,j}
T_old(1,:) = B2; % T(x,y=1,t) = 0 = T{i,1}
T_old(end,:) = B3; % T(x,y=1,t) = 0 = T{i,1}
T_old(:,end) = B4;  % T(x=1,y,t) = sin(πy) = T{30,j}

surf(x,y,T_old);
view(2)
axis('equal');
colorbar();
xlabel('X');
ylabel('Y');
title('time=0 s');

T_new = ones(size(T_old));
T_new(:,1) = B1; % T(x=0,y,t) = sin(πy) = T{0,j}
T_new(1,:) = B2; % T(x,y=1,t) = 0 = T{i,1}
T_new(end,:) = B3; % T(x,y=1,t) = 0 = T{i,1}
T_new(:,end) = B4;  % T(x=1,y,t) = sin(πy) = T{30,j}

k=1;
for t = 1:1000
    for i = 2: length(x)-1
        for j = 2: length(y)-1
            
            a =  ( T_old(i, j+1) - 2*T_old(i, j) + T_old(i, j-1) ) / dx^2;
            b =  ( T_old(i+1, j) - 2*T_old(i, j) + T_old(i-1,j) ) / dy^2;
            T_new(i,j) = (dt*(a +b ) ) + T_old(i, j);
        end
    end
    T_old = T_new; % Update at each t
    
    %{
    
    surf(x,y,T_old);
    view(2)
    a = sprintf('time=%f s', t*dt);
    title(a);  
    axis('equal');
    h=colorbar();
    title(h, 'T');
    xlabel('X');
    ylabel('Y');
    axis('equal');
    pause(0.0000001);
    
    %}
    
end       

surf(x,y,T_old);
view(2)
axis('equal');
colorbar();
xlabel('X');
ylabel('Y');
title('time=2s');


