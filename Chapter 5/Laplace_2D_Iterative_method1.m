clear
clc
% this code use an iterative way to solve a Laplace's eq. 
% It is not necessary to keep all data from previous iteratios. It is done
% here to show how temperature changes with iteration (educational code). 
% In practical cases it is not a good idea to keep all data, 
% as we have lots of data points and we can go out of memory

T = ones(200,6,7);


%initial guess
T(1,6,7) = 50;

%Iterative calculation of T(i,j)
for n=2:200
    for i = 2:5
        for j = 2:6
            % Interior points using central difference
            T(n,i,j) = (4*T(n-1,i+1,j)+4*T(n-1,i-1,j)+T(n-1,i,j+1)+T(n-1,i,j-1))/10;
        end
    end
    %removing the points in the corner (top left)
    T(n,1:2,1:3) = NaN;
    
    %constant temperature over 3 walls
    T(n,3,1:3) = 100;
    T(n,1:3,4) = 100;
    T(n,:,7) = 0;
    %Isolated walls 
    T(n,1,:) = T(n,2,:);
    T(n,6,:) = T(n,5,:);
    T(n,:,1) = T(n,:,2); 

end
x(:,:) = T(200,:,:);
heatmap(x,'colormap', hot)

