%Version 1.0
%Author: Nikita Bezginov
%Last Modified: 2014-10-19
%--------------------------
%Description:
%Gives best-line fit y(x)=A*x+B using least-squares method, where chi-squared is
%minimized, i.e., the following matrix is solved
%dE2/dC X = Y,  
%--------------------------
%Inputs:
%xData - data for x axis
%yData - data for y axis
%sigmaYData - standard deviation for yData
%--------------------------
%Outputs:
%A - slope of the best-line fit
%B - offset of the best-line fit
%chiSq - chi-squared of the best-line fit
function [A,B,chiSq]=LeastSquaresMethod(xData,yData,sigmaYData)

dE2dCFunc=@(xData,yData,sigmaYData)[sum((xData.^2)./(sigmaYData.^2)) sum(xData./sigmaYData.^2);sum(xData./sigmaYData.^2) sum(1./sigmaYData.^2)]; %Matrix for dE2/dC
yFunc=@(xData,yData,sigmaYData)[sum((xData.*yData)./sigmaYData.^2);sum(yData./sigmaYData.^2)]; %Matrix Y
dE2dC=dE2dCFunc(xData,yData,sigmaYData);
y=yFunc(xData,yData,sigmaYData);
x=dE2dC\y; %Solving for elements of matrix X
A=x(1);
B=x(2);
yFit=@(A,B,x)A*x+B;
chiSqFunc=@(xData,yData,sigmaYData,yFit)sum((yFit-yData).^2./sigmaYData.^2); %Chi-Squared
chiSq=chiSqFunc(xData,yData,sigmaYData,yFit(A,B,xData));