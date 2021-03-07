close all,
clear all
%%%%%%%%%%%(a)%%%%%%%%%%%%%
%f(x)=tan(x) (LHS)
%g(x) = 1/x (RHS)
f=@(x)(tan(x));
x=linspace(0,6*pi,1000)';
figure(1), plot(x,f(x),'color','r');
figure(1), hold on, plot(x,1./x,'color','b');
xlim([0 6*pi]);
ylim([-10 10]);
xticks([0 pi 2*pi 3*pi 4*pi 5*pi 6*pi]);
xticklabels({'0','\pi','2\pi','3\pi','4\pi','5\pi','6\pi'});
xlabel('x');
ylabel('f,g');
legend('tan(x)','1/x');

%%%%%%%%%%%(b)%%%%%%%%%%%%%
% NEWTON's Method
% Rearrange f(x)=tan(x)-1/x = 0
% g(x) = f'(x)
% Iterate x_n = x_o - f(x_o)/f'(x_o)
% Stop iterations when |x_n-x_o| < tol

f = @(x)(tan(x)-1/x);
g = @(x)(1/cos(x)^2 + 1/x^2);
x_o = 1000;                    %Try different initial guesses
x_n = 0;
tol = 1e-6;
diff = 10;
n=0;
while diff > tol
    x_n = x_o - f(x_o)/g(x_o);  %Newton's recursive function
    diff = abs(x_n - x_o);
    x_o = x_n;
    n=n+1;
    fprintf(['\n x_n = ',num2str(x_n)]);
    if(n>1000)
        disp('Iterations not converged!');
        break;
    end
end


%%%%%%%%%%%(c)%%%%%%%%%%%%%%%%
%Direct Iterations
%Rearrange x = f(x) => x = 1/tan(x)
f = @(x)(1/tan(x));
x_o = 1;                    %Try different initial guesses
x_n = 0;
tol = 1e-6;
diff = 10;
n=0;
while diff > tol
    x_n = f(x_o);
    diff = abs(x_n - x_o);
    x_o = x_n;
    n=n+1;
    fprintf(['\n x_n = ',num2str(x_n)]);
    if(n>1000)
        disp('Iterations not converged!');
        break;
    end
end

%%%%%%%%%%%(d)%%%%%%%%%%%%%%%%
%Direct Iterations with relaxation
%Rearrange x* = f(x) => x* = 1/tan(x)
%x_n = wx* + (1 - w)x_o
f = @(x)(1/tan(x));
x_o = 1;                    %Try different initial guesses
x_n = 0;
x_star = 0;
w = 0.3;                    %Try different relaxation factors in (0,1)
tol = 1e-6;
diff = 10;
n=0;
while diff > tol
    x_star = f(x_o);
    x_n = w*x_star + (1-w)*x_o;
    diff = abs(x_n - x_o);
    x_o = x_n;
    n=n+1;
    fprintf(['\n x_n = ',num2str(x_n)]);
    if(n>1000)
        disp('Iterations not converged!');
        break;
    end
end


