%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 Bisection Method                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{

The bisection method is one of the simplest algorithms 
fo finding roots of non-linear equations. It works by 
creating successively smaller and smaller intervals which 
contain the root of the equation.

Algorithm
~~~~~~~~~

- Choose a and b so that f(a) > 0 and f(b) < 0
- Set n = 0, define x_o = a and choose error level ε > 0
- Begin Iterations:

    1. n = n+1 
    2. x_n = (a+b)/2
    3. if |f(xn)| < ε, STOP
    4. if|f(xn)|>0,then a = x_n 
    5. if|f(xn)|<0,then b = x_n

- Loop

Q.
Write a MATLAB code which uses the bisection method 
to solve f(x) = π where f(x) = x2/3 for 0 ≤ x.
Suppose we have a tolerance of the form ε = 10−n, 
determine the value of n which gives an approximation 
accurate to 6 decimal places (6DP). 

In other words what value of n results a difference from
5.568328 of a value less than 1e-7. (6DP).

%}
clc, close all;

g=@(x)(x.^(2/3)-pi); % This will be our g(x) = f(x) - pi = 0
x=linspace(0,6,400); % 400 points from 0 to 6
figure(1), plot(x, g(x),'b',[0 6], [0 0],'k')


%%%a)- termination condition |f(xn)| < ε is used 

i = 1;
a = 4.5;
b = 6;
e = 5;
tol = 10^(-e);
x_n = a;
n = 0;
max_iter = 1000;

while (i < max_iter)
   n = n+1; % Increment
   x_n = (a+b)/2; % Find Bisection
   func_val = g(x_n); % Determine Value at x_n
   
   if (abs(func_val) < tol)
       n_str=['x_' num2str(n)];
       disp([n_str ', f(' n_str ') = ' num2str(abs(x_n-5.568328)) ', ' num2str(g(x_n))])
       break
   end
   
   if(func_val * g(a) > 0)
       a = x_n;
   else
       b = x_n; 
   end
     
   n_str=['x_' num2str(n)];
   disp([n_str ', f(' n_str ') = ' num2str(abs(x_n-5.568328)) ', ' num2str(g(x_n))])
  
end

% 14 Iterations


%%%b)- termination condition |xn − xn−1| < ε


i = 1;
a = 4.5;
b = 6;
e = 6;
tol = 10^(-e);
x_n = a;
x_prev = 0;
n = 0;
max_iter = 1000;

while (i < max_iter)
   n = n+1; % Increment
   x_prev = x_n; % Set previous
   x_n = (a+b)/2; % Find Bisection
   func_val = g(x_n); % Determine Value at x_n
   
   if (abs(x_n - x_prev)< tol && n ~= 1)
       n_str=['x_' num2str(n)];
       disp([n_str ', f(' n_str ') = ' num2str(abs(x_n-5.568328)) ', ' num2str(g(x_n))])       
       break
   end
   
   if(func_val * g(a) > 0)
       a = x_n;
   else
       b = x_n; 
   end
   
   n_str=['x_' num2str(n)];
   disp([n_str ', f(' n_str ') = ' num2str(abs(x_n-5.568328)) ', ' num2str(g(x_n))])
  
end

% 20 Iterations


%%%c)- termination condition |b-a| < ε


i = 1;
a = 4.5;
b = 6;
e = 6;
tol = 10^(-e);
x_n = a;
x_prev = 0;
n = 0;
max_iter = 1000;

while (i < max_iter)
   n = n+1; % Increment
   x_n = (a+b)/2; % Find Bisection
   func_val = g(x_n); % Determine Value at x_n
   
   if (abs(b-a)< tol && n ~= 1)
       n_str=['x_' num2str(n)];
       disp([n_str ', f(' n_str ') = ' num2str(abs(x_n-5.568328)) ', ' num2str(g(x_n))])       
       break
   end
   
   if(func_val * g(a) > 0)
       a = x_n;
   else
       b = x_n; 
   end
   
   n_str=['x_' num2str(n)];
   disp([n_str ', f(' n_str ') = ' num2str(abs(x_n-5.568328)) ', ' num2str(g(x_n))])
  
end

% 20 Iterations


%%%%%
% The standard termination conditon, |f(x_n)| < tol, required n=5 whereas
% the other two conditions required n=6. 
% Either of the other 2 termination conditions are more useful for ensuring
% the accuracy. Both |x_n-x_{n-1}| <tol and |b-a|<tol, are ensuring that
% modifications to the approximation are at a scale less than tol. So if
% n = 6 then tol = 10^{-6} means xn is simply changing at a level less than
% 10^{-6} which is the 6th decimal place so we have 6DP accuracy. 



