clear all;

%Time parameters
t0=0; %Starting time (s)
T=5; %Period of the signal (s)
Tshow=1; %Over how many periods to show both the input and the reconstructed signals. Must be >=1.
samplingRate=100; %Sampling rate, [Hz]
%Input function
f0=1;
ff=40;

A=1; %Signal amplitude, [V]
func=@(t)A*cos(2*pi*(f0+(ff-f0).*t/(2*T)).*t); %Input signal function, [V]
nMax=500; %Maximum order of the Fourier series to compute
%=========================
%Calculating the Fourier series
[timeRList,timeList,funcRList,freqList,coeffFourierList]=FourierSeries(func, t0, T, nMax, Tshow, samplingRate);

%Plotting the results

figure(1)

%Input signal plotting
subplot(2,2,1);

%Plotting the input signal over some number of periods
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

subplot(2,2,4);
%Plotting the spectrogram
windowFracLength=0.1; %Fraction of total number of points covered by one window
windowLength=round(windowFracLength*length(timeSList)); %window length [points]
windowOverlapFrac=0.8; %Fraction of points overlapping
windowOverlap=round(windowOverlapFrac*windowLength); %Number of overlapping points in a window, [points]
spectrogram(funcRList,blackman(windowLength),windowOverlap,windowLength,samplingRate,'yaxis')

colorbar;
title 'Spectrogram of the input signal'


signalList = chirp(timeSList,f0,T,ff,'li'); %Input signal, [V]

figure(2)
subplot(2,1,1)
plot(timeSList,signalList)
subplot(2,1,2)

windowFracLength=0.1; %Fraction of total number of points covered by one window
windowLength=round(windowFracLength*length(timeSList)); %window length [points]
windowOverlapFrac=0.8; %Fraction of points overlapping
windowOverlap=round(windowOverlapFrac*windowLength); %Number of overlapping points in a window, [points]
spectrogram(signalList,blackman(windowLength),windowOverlap,windowLength,samplingRate,'yaxis')

colorbar;
title 'Linear chirp'
