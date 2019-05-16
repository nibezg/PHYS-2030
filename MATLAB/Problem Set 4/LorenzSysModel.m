%Numerical solution for Lorenz System

clear;

%---------------------
%Initial conditions
%---------------------
t0=0; %Initial time (s)
tf=60; %Final time (s)

x0=1.5; 
y0=1.5; 
z0=1.5;

%Numerical Calculation: Solving with ode45

[T,Y] = ode45(@lorenzSys,[t0 tf],[x0 y0 z0]);

%Plotting 

subplot(2,2,1)
plot(T,Y(:,1),'Linewidth',1)
title('x vs t');
xlabel('t');
ylabel('x');

subplot(2,2,2)
plot(T,Y(:,2),'Linewidth',1)
title('y vs t');
xlabel('t');
ylabel('y');

subplot(2,2,3)
plot(T,Y(:,3),'Linewidth',1)
title('z vs t');
xlabel('t');
ylabel('z');

subplot(2,2,4)
plot3(Y(:,1),Y(:,2),Y(:,3))
title('Lorenz System Phase Space');
xlabel('x');
ylabel('y');
zlabel('z');


