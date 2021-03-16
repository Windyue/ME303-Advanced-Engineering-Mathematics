%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Fixed Point Iteration                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
Find Smallest Positive Root of:

f(x) = g(x), where
x^2 = 4 − 4x^3

so

f(x) = x^2
g(x) = 4 − 4x^3
F(x) = x^2 - 4 + 4x^3


%}

% Cleanup on Initialization
clc
close all
clear all 

%%%%%%%%%%%%%%%%%%%
%  Problem 1.a 1  %
%%%%%%%%%%%%%%%%%%%

% Generate 100 evenly spaced x-value between (-10,10) 
x = linspace(-10,10,100);


%{
@brief: Method One 

Plot f(x) against g(x) to find intersection

%}

figure(1); 
plot(x,x.^2)
hold on
plot(x, 4 - 4*x.^3); 
hold on

% Labels, Limit X-Axis Range
xlabel('x');
ylabel('y');
xlim([-1,2]);
title('f(x) vs g(x) = 0');

%{
@brief: Method Two 

Plot F(x) = f(x) - g(x)
against y=0 to find intersection

%}

figure(2); 
plot(x,x.^2 - 4 + 4*x.^3)
hold on
plot(x, zeros(length(x))); 
hold on

% Labels, Limit X-Axis Range
xlabel('x');
ylabel('y');
xlim([-1,2]);
title('F(x) vs y = 0');


%%%%%%%%%%%%%%%%%%%
%  Problem 1.a 2  %
%%%%%%%%%%%%%%%%%%%

%{
@brief: Direct iteration 

Direct Iteration (fixed-point iteration) 
with the rearrangement x = (4 − 4x^3)^1/2

%}

x_old = 0;
x_new = 0;

diff = realmax; % set initial diff to some large value
tolerance = 0.0001; % define to a value of satisfaction
max_iterations = 1000; % Max Iter.
i=1;


while(diff>tolerance)
    
    x_new = (4 - 4*x_old^3)^(1/2); % Calculate new value using old x
    diff = abs(x_new - x_old); % Difference between new x and old x
    x_old = x_new;
    
    i=i+1; % Increment count
    fprintf('\n x_%d = %d' ,i ,x_new); % Print new x
    if(i>max_iterations)
        disp('Not Converged');
        fprintf('\n x_%d = %d' ,i ,x_new);
        break
    end  
end

% The value for x blew up due to square root, thus can not 
% use this methods for square root g(x) functions in x = g(x).


%%%%%%%%%%%%%%%%%%%
%  Problem 1.a 2  %
%%%%%%%%%%%%%%%%%%%

%{
@brief: Direct iteration 

Direct Iteration (fixed-point iteration) 
with the rearrangement x = ((4 − x^2)/4)^1/3

%}

x_old = 0;
x_new = 0;

diff = realmax; % set initial diff to some large value
tolerance = 0.0001; % define to a value of satisfaction
max_iterations = 1000; % Max Iter.
i=1;


while(diff>tolerance)
    
    x_new = (1 - (0.25 * x_old^2))^(1/3); % Calculate new value using old x
    diff = abs(x_new - x_old); % Difference between new x and old x
    x_old = x_new;
    
    i=i+1; % Increment count
    fprintf('\n x_%d = %d' ,i ,x_new); % Print new x
    if(i>max_iterations)
        disp('Not Converged');
        fprintf('\n x_%d = %d' ,i ,x_new);
        break
    end  
end
