(* ::Package:: *)

linFunc=@(x)2*x.^1+2; % linear function
 
polymFunc=@(x)2*x.^2+4*x+2; % second-order polynomial function
 
expFunc=@(x)15*exp(-0.35*x); % exponential function
 
xData=0.1:0.1:10; % x data range and step-size
stdData=rand(1,length(xData)); % randomly assigned standard deviation to each y(x)
 
noiseData=2*rand(1,length(xData)); % random white noise
linData=linFunc(xData)+noiseData; % simulated data for linear fit
 
noiseData=20*rand(1,length(xData));
polymData=polymFunc(xData)+noiseData; % simulated data for second-order polynomial fit
 
noiseData=rand(1,length(xData)); 
expData=expFunc(xData)+noiseData; % simulated data for exponential decay fit
 
% Fit functions 
lsf=@(A,B,x)A*x+B; % linear fit function
polLsf=@(A,B,C,x)A*x.^2+B*x+C; % second-order polynomial fit function
expLsf=@(A,lambda,x)A*exp(lambda*x); % exponential fit function
 
[C,D,chiSqLin]=LeastSquaresMethod(xData,linData,stdData); % parameters for linear fit
pLin = polyfit(xData,linData,1); % MatLab function for parameters
 
[x,chiSqPol]=SecondOrderPolymFit(xData,polymData,stdData); % parameters for second-order polynomial fit
pSecond = polyfit(xData,polymData,2); % MatLab function for parameters
 
[E,F,chiSqExp]=LeastSquaresMethod(xData,log(expData),log(stdData)); % parameters for exponential fit
pLinExp = polyfit(xData,log(expData),1); % MatLab function for parameters
% Plotting the results
figure(1)
 
subplot(2,2,1)
hold on
plot(xData,linData,'bo')
plot(xData,lsf(C,D,xData),'r-')
plot(xData,lsf(pLin(1),pLin(2),xData),'g-.');
hold off
 
title('Linear Least-squares fit to noisy data');
xlabel('x');
ylabel('y');
legend('Noisy data',['Linear fit: y=',num2str(C),'*x + ',num2str(D),'. Chi-Squared: ',num2str(chiSqLin)],['MatLab Linear fit: y=',num2str(pLin(1)),'*x + ',num2str(pLin(2))],'Location','Best')
 
subplot(2,2,2)
hold on
plot(xData,polymData,'bo')
plot(xData,polLsf(x(1),x(2),x(3),xData),'m-')
plot(xData,polLsf(pSecond(1),pSecond(1),pSecond(3),xData),'g-.');
hold off
 
title('Second-order Polynomial fit to noisy data');
xlabel('x');
ylabel('y');
legend('Noisy data',['Polynomial fit: y=',num2str(x(1)),'*x^2 + ',num2str(x(2)),'*x+',num2str(x(3)),'. Chi-Squared: ',num2str(chiSqPol)],['MatLab Polynomial fit: y=',num2str(pSecond(1)),'*x^2 + ',num2str(pSecond(2)),'*x+',num2str(pSecond(3))],'Location','Best')
 
subplot(2,2,3)
hold on
plot(xData,expData,'bo')
plot(xData,expLsf(exp(F),E,xData),'m-')
plot(xData,expLsf(exp(pLinExp(2)),pLinExp(1),xData),'g.-')
hold off
 
title('Linearized exponential function fit to noisy data');
xlabel('x');
ylabel('y');
legend('Noisy data',['Exponential fit: y=',num2str(exp(F)),'*x*Exp (',num2str(E),'*x). Chi-Squared: ',num2str(chiSqExp)],['MatLab Exponential fit: y=',num2str(exp(pLinExp(2))),'*x*Exp (',num2str(pLinExp(1)),'*x)'],'Location','Best')


