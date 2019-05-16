%Numerical solution for Damped Harmonic Oscillator

clear;

%-------------------------
%Newton's Second Law
%-------------------------
k=10; %Spring constant [N/m]
m=1; %Mass [kg]

b=0.5; %Damping constant [kg/s]

vPrime=@(t,x,v)-k/m.*x-b/m.*v; %Netwon's law

%---------------------
%Initial conditions
%---------------------
t0=0; %Initial time (s)
tf=5; %Final time (s)

x0=0; %Initial position [m]
v0=10; %Initial velocity [m/s]

deltaT=[0.5 0.2 0.1 0.05 0.01]; %Step size (s)

%Numerical Calculation

plottingStyle={'g-','r:','b-.','m-.','c:'};

figure(1)

subplot(2,2,1)

hold on

for i=1:numel(deltaT)
    [tVal, ~, xVal]=RK4(vPrime,deltaT(i),t0,tf,x0,v0); %Numerical solution using 4th-order Runge-Kutta method
    
    %Plotting
    
    plot(tVal,xVal,plottingStyle{i}, 'Linewidth',4)
    
end

title('Damped Harmonic Oscillator. Computed with RK4');
xlabel('Time, t[s]');
ylabel('Position, x[m]');
legend(num2str(deltaT(1)),num2str(deltaT(2)),num2str(deltaT(3)),num2str(deltaT(4)),num2str(deltaT(5)),'Location','Best')

hold off;
subplot(2,2,2)
[tVal, vVal, xVal]=RK4(vPrime,min(deltaT),t0,tf,x0,v0);
plot(xVal,vVal,'Linewidth',2)
title('Phase Space. Computed with RK4');
xlabel('Position, x[m]');
ylabel('Velocity, v[m/s]');

%Solving with ode45

[T,Y] = ode45(@harmOsc,[t0 tf],[x0 v0]);

subplot(2,2,3)
plot(T,Y(:,1),'Linewidth',2)
title('Damped Harmonic Oscillator. Computed with ode45');
xlabel('Time, t[s]');
ylabel('Position, x[m]');

subplot(2,2,4)
plot(Y(:,1),Y(:,2),'Linewidth',2)
title('Phase Space. Computed with ode45');
xlabel('Position, x[m]');
ylabel('Velocity, v[m/s]');