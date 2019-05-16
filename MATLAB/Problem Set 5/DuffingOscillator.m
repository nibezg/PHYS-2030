%Numerical solution for Damped Harmonic Oscillator

clear;

%-------------------------
%Newton's Second Law
%-------------------------
a=10; %Spring constant [N/m]
b=15; %Non-linear term for spring constat [N/m^3]
m=1; %Mass [kg]
d=2; %Damping constant [kg/s]

vPrime=@(t,x,v)-a/m.*x-b.*x.^3-d/m.*v; %Netwon's law 

%---------------------
%Initial conditions
%---------------------
t0=0; %Initial time (s)
tf=5; %Final time (s)

x0=0; %Initial position [m]
v0=200; %Initial velocity [m/s]

deltaT=[0.0001]; %Step size (s)

%Numerical Calculation

plottingStyle={'g-'};

figure(1)

subplot(2,2,1)

hold on

for i=1:numel(deltaT)
    [tVal, ~, xVal]=RK4(vPrime,deltaT(i),t0,tf,x0,v0); %Numerical solution using 4th-order Runge-Kutta method
    
    %Plotting
    
    plot(tVal,xVal,plottingStyle{i}, 'Linewidth',4)
    
end

title('Duffing Oscillator. Computed with RK4');
xlabel('Time, t[s]');
ylabel('Position, x[m]');
legend(num2str(deltaT(1)),'Location','Best')

hold off;
subplot(2,2,2)
[tVal, vVal, xVal]=RK4(vPrime,min(deltaT),t0,tf,x0,v0);
plot(xVal,vVal,'Linewidth',2)
title('Phase Space. Computed with RK4');
xlabel('Position, x[m]');
ylabel('Velocity, v[m/s]');

%Solving with ode45

[T,Y] = ode45(@DuffingOsc,[t0 tf],[x0 v0]);

subplot(2,2,3)
plot(T,Y(:,1),'Linewidth',2)
title('Duffing Oscillator. Computed with ode45');
xlabel('Time, t[s]');
ylabel('Position, x[m]');

subplot(2,2,4)
plot(Y(:,1),Y(:,2),'Linewidth',2)
title('Phase Space. Computed with ode45');
xlabel('Position, x[m]');
ylabel('Velocity, v[m/s]');