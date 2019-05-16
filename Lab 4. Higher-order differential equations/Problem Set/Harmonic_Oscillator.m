%Numerical solution for Harmonic Oscillator

clear;

%-------------------------
%Newton's Second Law
%-------------------------
k=10; %Spring constant [N/m]
m=1; %Mass [kg]

vPrime=@(t,x,v)-k/m.*x; %Netwon's law

%---------------------
%Initial conditions
%---------------------
t0=0; %Initial time (s)
tf=5; %Final time (s)

x0=0; %Initial position [m]
v0=10; %Initial velocity [m/s]

%-------------------------
%Analytic Solution
%-------------------------
ampl=v0*(m/k)^0.5;

angFreq=(k/m)^0.5;

phi0=asin(x0/ampl);

FSol=@(t)ampl*sin(angFreq.*t+phi0); %Analytic solution


deltaT=[0.2 0.1 0.05 0.02]; %Step size (s)

%Numerical Calculation

plottingStyle={'g-','r:','b-.','m-.','c:'};

figure(1)

subplot(2,2,1)

hold on

for i=1:numel(deltaT)
    [tVal, ~, xVal]=RK2(vPrime,deltaT(i),t0,tf,x0,v0); %Numerical solution using 2nd-order Runge-Kutta method
    
    %Plotting
    
    plot(tVal,xVal,plottingStyle{i}, 'Linewidth',4)
    
end

title('Spring Mass System. Computed with RK2');
xlabel('Time, t[s]');
ylabel('Position, x[m]');
legend(num2str(deltaT(1)),num2str(deltaT(2)),num2str(deltaT(3)),num2str(deltaT(4)),'Location','Best')

hold off;
subplot(2,2,2)
[tVal, vVal, xVal]=RK2(vPrime,min(deltaT),t0,tf,x0,v0);
plot(xVal,vVal,'Linewidth',2)
title('Phase Space. Computed with RK2');
xlabel('Position, x[m]');
ylabel('Velocity, v[m/s]');

%Solving with ode45

[T,Y] = ode45(@springMassSystem,[t0 tf],[x0 v0]);

subplot(2,2,3)

hold on

plot(T,FSol(T),'go','Linewidth',2)
plot(T,Y(:,1),'b-.','Linewidth',2)
plot(tVal,xVal,'m*','Linewidth',2)

hold off

title('Spring Mass System');
xlabel('Time, t[s]');
ylabel('Position, x[m]');
legend('Analytic solution','ode45','RK2','Location','Best')

subplot(2,2,4)

hold on 

plot(Y(:,1),Y(:,2),'b-','Linewidth',2)
plot(xVal,vVal,'mo','Linewidth',2)
title('Phase Space');
xlabel('Position, x[m]');
ylabel('Velocity, v[m/s]');
legend('ode45','RK2','Location','Best')

hold off
