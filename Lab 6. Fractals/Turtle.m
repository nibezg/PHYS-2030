%Version 1.0
%Author: Nikita Bezginov
%Last Modified: 2014-10-24
%--------------------------
%Description:
%Gives the coordinates for the given set of instructions, which include the
%following commands:
%F, B or A - go forward by lengthF
%T - scale distance of movement forward by some factor
%+ - CW rotation by some angle angleRot 
%- - CCW rotation by some angle angleRot
%[ - store current angle and position (Multiple ones can be stored)
%] - restore the latest saved angle and position store and remove it from the stack of stored angles and positions. 
%Rotation angles are given w.r.t. the x-axis.
%--------------------------
%Inputs:
%sCMD - set of commands given as a string consisting of F, +, - characters.
%r0 - initial position, given as [x0 y0]
%lengthF - distance of movement forward [arb units]
%angleRot - unit of measurement of rotation [deg]
%theta - in what direction to move initially [deg]
%--------------------------
%Output:
%r - vector of computed positions [x0,y0,x1,y1,...,etc] 
%Plots a graph of displacements.

function [r]=Turtle(sCMD, r0, lengthF, angleRot, theta, distScale)

r=r0;

%Conversion of angles in deg into rads
angleRot=angleRot/180*pi;
theta=theta/180*pi;

rowNumber=1; %Initial number of rows in vector of positions
%For each element of set of commands do the following

savedCounter=0;
lineCounter=0;
hold on
for i=1:length(sCMD)
    
    %Movement forward
    if (sCMD(i)== 'F')||(sCMD(i)=='B')||(sCMD(i)=='A')
        rowNumber=rowNumber+1;
        lineCounter=lineCounter+1;
        r(rowNumber,1)=lengthF*cos(theta)+r(rowNumber-1,1); 
        r(rowNumber,2)=lengthF*sin(theta)+r(rowNumber-1,2);
      line([r(rowNumber-1,1) r(rowNumber,1)],[r(rowNumber-1,2) r(rowNumber,2)]);
    %CW rotation
    elseif sCMD(i)=='+'
        theta=theta-angleRot;
        
    %CCW rotation    
    elseif sCMD(i)=='-'
        theta=theta+angleRot;
 
    %Scaling of distance    
    elseif sCMD(i)=='T'
        lengthF=lengthF/distScale;
    
    %Storing of current angle and distance
    elseif sCMD(i)=='['
        savedCounter=savedCounter+1;
        rSave(savedCounter,1,1)=r(rowNumber,1);
        rSave(savedCounter,1,2)=r(rowNumber,2);
        thetaSave(savedCounter,1) = theta;
        
    %Restoring latest saved angle and distance
    elseif sCMD(i)==']'
        rowNumber=rowNumber+1;
        r(rowNumber,1)=rSave(savedCounter,1,1);
        r(rowNumber,2)=rSave(savedCounter,1,2);
        theta=thetaSave(savedCounter,1);
        savedCounter=savedCounter-1;
    end
end