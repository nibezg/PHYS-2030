%Version 1.0
%Author: Nikita Bezginov
%Last Modified: 2014-10-06
%--------------------------
%Description:
%Second order Runge-Kutta method for calculating one-body 1D problems
%involving Newton's Second law.
%--------------------------
%Inputs:
%vPrime - expression for acceleration from Newton's Second Law, dv(t,x,v)/dt
%deltaT - time step size
%t0 - initial time
%tf - final time
%x0 - initial position
%v0 - initial velocity
%--------------------------
%Outputs:
%tVal - array of times for which the position and velocity were numerically
%computed
%vVal - array of computed velocities
%xVal - array of computed positions

function [tVal, vVal, xVal]=RK2(vPrime,deltaT,t0,tf,x0,v0)

NTotal=(tf-t0)/deltaT; %Total number of time steps

vVal=(1:NTotal); %Initialize array for storing velocities
xVal=(1:NTotal); %Initialize array for storing positions

vVal(1)=v0; %First element is the velocity at time t0
xVal(1)=x0; %First element is the position at time t0

tVal=linspace(t0,tf,NTotal); %Equally spaced time array

xPrime=@(t,x,v)v; %Define dx/dt=v(t,x,v)

%Second-order Runge-Kutta method implementation

for j=2:NTotal
    
    f1x=xPrime(tVal(j-1),xVal(j-1),vVal(j-1));
    f1v=vPrime(tVal(j-1),xVal(j-1),vVal(j-1));
    
    f2x=xPrime(tVal(j-1)+deltaT/2,xVal(j-1)+deltaT/2*f1x,vVal(j-1)+deltaT/2*f1v);
    f2v=vPrime(tVal(j-1)+deltaT/2,xVal(j-1)+deltaT/2*f1x,vVal(j-1)+deltaT/2*f1v);
    
    xVal(j)=xVal(j-1)+deltaT*f2x;
    vVal(j)=vVal(j-1)+deltaT*f2v;
    
end