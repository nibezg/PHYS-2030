%Version 1.0
%Author: Nikita Bezginov
%Last Modified: 2014-10-19
%--------------------------
%Description:
%Gives best-line fit y(x)=A*x^2+B*x+C using least-squares method, where chi-squared is
%minimized, i.e., the following matrix is solved
%dE2/dC X = Y,  
%--------------------------
%Inputs:
%xData - data for x axis
%yData - data for y axis
%sigmaYData - standard deviation for yData
%--------------------------
%Outputs:
%x - solutions of the least-squares method
%chiSq - chi-squared of the best-line fit
function [x,chiSq]=SecondOrderPolymFit(xData,yData,sigmaYData)

dE2dCFunc=@(xData,yData,sigmaYData)[sum((xData.^4)./(sigmaYData.^2)) sum((xData.^3)./(sigmaYData.^2)) sum((xData.^2)./(sigmaYData.^2));sum((xData.^3)./(sigmaYData.^2)) sum((xData.^2)./(sigmaYData.^2)) sum(xData./sigmaYData.^2);sum((xData.^2)./(sigmaYData.^2)) sum(xData./sigmaYData.^2) sum(1./sigmaYData.^2)]; %Matrix for dE2/dC

yFunc=@(xData,yData,sigmaYData)[sum((xData.^2.*yData)./sigmaYData.^2);sum((xData.*yData)./sigmaYData.^2);sum(yData./sigmaYData.^2)]; %Matrix Y

dE2dC=dE2dCFunc(xData,yData,sigmaYData);
y=yFunc(xData,yData,sigmaYData);
x=dE2dC\y; %Solving for elements of matrix X

yFit=@(A,B,C,x)A*x.^2+B*x+C; %Constructing the fit function

chiSqFunc=@(xData,yData,sigmaYData,yFit)sum((yFit-yData).^2./sigmaYData.^2); %Chi-Squared
chiSq=chiSqFunc(xData,yData,sigmaYData,yFit(x(1),x(2),x(3),xData));