% This is a script that shows how heat diffuses across a square domain. The boundary conditions are dirichlet 
%and you can set different boundaries to different values and see how temperature varies in time throughout the domain. 
clear all
clc

%%
x=linspace(0,1,100); % These are the domain boundaries just to give an idea of how the domain looks like.
y=linspace(0,1,100);
[X,Y]=meshgrid(x,y);

%%
dx=x(2)-x(1); % The delta x and delta y
dy=y(2)-y(1);

%% Dirichlet boundary conditions
%Try changing this by setting different boundaries to different temperatures to see what happens

T_old=sin(pi*x).*cos(4*pi*Y); % This defines a temperature field that corresponds to the same number of points as the domain in XY

Boundary_1_temperature=-1;   %% Change the boundary temperatures here
Boundary_2_temperature=1;
Boundary_3_temperature=-1;
Boundary_4_temperature=1;

 T_old(:,1)=Boundary_1_temperature;   
 T_old(1,:)=Boundary_2_temperature;
 T_old(end,:)=Boundary_3_temperature;
 T_old(:,end)=Boundary_4_temperature;
% 
% surf(x,y,T_old)  %% Uncomment Visualize how temperature is distributed at time =0
% view(2)
% axis('equal')
% colorbar()
% xlabel('X')
% ylabel('Y')

%%
delta_t=0.00001;   % This is the time step

T_new=ones(size(T_old));
 T_new(:,1)=Boundary_1_temperature;
 T_new(1,:)=Boundary_2_temperature;
 T_new(end,:)=Boundary_3_temperature;
 T_new(:,end)=Boundary_4_temperature;

 k=1;
for t=1:10000   % time loop. 
    for i=2:length(x)-1

        for j=2:length(y)-1
       
        T_new(i,j)=((((T_old(i,j+1)-2*T_old(i,j)+T_old(i,j-1))/dx^2)+((T_old(i+1,j)-2*T_old(i,j)+T_old(i-1,j))/dy^2))*delta_t)+T_old(i,j);    

        end
        
   end
          T_old=T_new;

%           surf(x,y,T_old)
%           view(2)
%           a=sprintf('time=%f s' ,t*delta_t);
%           title(a)
%           h=colorbar();
%           colormap('autumn')
%           title(h,'Temperature')
%            axis('equal')
%           pause(0.001)
%If you dont want to watch how the temperature distribution changes through
%time then comment the previous plot (from surf)
%and uncomment the figure below to see the final temperature distribution
%(steady state)
        
end
   
surf(x,y,T_old)
view(2)
a=sprintf('time=%f s' ,t*delta_t);
title(a)
h=colorbar();
%colormap('autumn')
title(h,'Temperature')
axis('equal')



