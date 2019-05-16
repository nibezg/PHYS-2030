clear all;
%=========================
%Input function
A=2; %Signal amplitude, (V)
func=@(t)A*(sin(t)./t).^2; %Input signal, [V], as a function of time, t[s]

%Time parameters
t0=-10; %Starting time (s)
T=20; %Period of the signal (s)
Tshow=2; %Over how many periods to show both the input and the reconstructed signals. Must be >=1.
samplingRate=5;
nMax=10; %Maximum order of the Fourier series to compute
%=========================
%Calculating the Fourier series
[timeRList,timeList,funcRList,freqList,coeffFourierList]=FourierSeries(func, t0, T, nMax, Tshow,samplingRate);

%Plotting the results

figure(1)

%Input signal plotting
subplot(2,2,1);

%Plotting the input signal over some number of periods
funcList=func(timeList);
timeSList=timeRList;
for i=1:length(timeList)
    for j=1:Tshow
    timeSList(i+length(timeList)*(j-1))=timeList(i);
    end
end

plot(timeRList,func(timeSList));
xlabel('Time, [s]');
ylabel('Signal, [V]');
title('Signal as a function of time');

%Plotting the Fourier components

subplot(2,2,2);
hold on

%Plotting the Fourier components as points
plot(freqList,coeffFourierList(:,1),'b.');
plot(freqList,coeffFourierList(:,2),'r.');

%Drawing lines to represent the magnitude of the Fourier components
for i=1:length(coeffFourierList)
    line([freqList(i),freqList(i)],[0,coeffFourierList(i,1)],'Color','b','Linewidth',2);
    line([freqList(i),freqList(i)],[0,coeffFourierList(i,2)],'Color','r','Linewidth',2);
end
hold off

legend('a_n coefficients','b_n coefficients','Location','Best')
xlabel('Frequency, f(Hz)');
ylabel('Fourier series component amplitude, [V]');
title('Fourier components of the signal');

%Plotting the reconstructed signal

subplot(2,2,3);
plot(timeRList,funcRList);
xlabel('Time, [s]');
ylabel('Reconstructed signal, [V]');
title(['Reconstructed signal from Fourier components for nMax = ' num2str(nMax)]);
