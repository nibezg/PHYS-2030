%Version 1.0
%Author: Nikita Bezginov
%Last Modified: 2014-10-03
%--------------------------
%Description:
%Fourth order Runge-Kutta method for calculating one-body 1D problems
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

function [tVal, vVal, xVal]=RK4(vPrime,deltaT,t0,tf,x0,v0)

NTotal=(tf-t0)/deltaT; %Total number of time steps

vVal=(1:NTotal); %Initialize array for storing velocities
xVal=(1:NTotal); %Initialize array for storing positions

vVal(1)=v0; %First element is the velocity at time t0
xVal(1)=x0; %First element is the position at time t0

tVal=linspace(t0,tf,NTotal); %Equally spaced time array

xPrime=@(t,x,v)v; %Define dx/dt=v(t,x,v)

%Fourth order Runge-Kutta method implementation

for j=2:NTotal
    
    f1x=xPrime(tVal(j-1),xVal(j-1),vVal(j-1));
    f1v=vPrime(tVal(j-1),xVal(j-1),vVal(j-1));
    
    f2x=xPrime(tVal(j-1)+deltaT/2,xVal(j-1)+deltaT/2*f1x,vVal(j-1)+deltaT/2*f1v);
    f2v=vPrime(tVal(j-1)+deltaT/2,xVal(j-1)+deltaT/2*f1x,vVal(j-1)+deltaT/2*f1v);
    
    f3x=xPrime(tVal(j-1)+deltaT/2,xVal(j-1)+deltaT/2*f2x,vVal(j-1)+deltaT/2*f2v);
    f3v=vPrime(tVal(j-1)+deltaT/2,xVal(j-1)+deltaT/2*f2x,vVal(j-1)+deltaT/2*f2v);
    
    f4x=xPrime(tVal(j-1)+deltaT,xVal(j-1)+deltaT*f3x,vVal(j-1)+deltaT*f3v);
    f4v=vPrime(tVal(j-1)+deltaT,xVal(j-1)+deltaT*f3x,vVal(j-1)+deltaT*f3v);
    
    xVal(j)=xVal(j-1)+deltaT/6*(f1x+2*f2x+2*f3x+f4x);
    vVal(j)=vVal(j-1)+deltaT/6*(f1v+2*f2v+2*f3v+f4v);
    
end