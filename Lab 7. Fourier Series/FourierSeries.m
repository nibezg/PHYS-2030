%Version 1.0
%Author: Nikita Bezginov
%Last Modified: 2014-11-02
%--------------------------
%Description:
%Computes the Fourier components of a given signal function and then uses these
%components to reconstruct the signal function
%--------------------------
%Inputs:
%func - input signal function, func(t) (assumed to be in units of Volts as a
%function of time in seconds)
%t0 - initial time
%T - signal period
%nMax - %Maximum order of the Fourier series to compute
%Tshow - %Over how many periods to show both the inputand the reconstructed signals. Must be >=1.
%--------------------------
%Output:
%timeRList - %Vector of time for Tshow periods of the input signal, [s]
%timeList - %Vector of times for one period of the input signal, [s]
%funcRList - %List of values for the reconstructed signal, [V]
%freqList - %Array of the Fourier frequencies, [Hz]
%coeffFourierList - list of the Fourier coefficients, [V]
%samplingRate - sampling rate of the input signal, [Hz]. This parameter
%here just represents number of time points to calculate
function [timeRList,timeList,funcRList,freqList,coeffFourierList]=FourierSeries(func, t0, T, nMax, Tshow, samplingRate)

nPoints=samplingRate*T;
timeList=linspace(t0,t0+T,nPoints); %Vector of times for one period of the input signal, [s]
timeRList=linspace(t0,t0+Tshow*T,Tshow*nPoints); %Vector of time for Tshow periods of the input signal, [s]
coeffFourierList=zeros(nMax+1,2); %Array to store the Fourier coefficients, [V]
funcRList=zeros(1,length(timeList)); %Array to store the list of values for the reconstructed signal, [V] 

freqList=linspace(0,nMax/T,nMax+1); %Array of the corresponding Fourier frequencies, [Hz]

%Computing the Fourier components
for n=1:nMax+1
     coeffFourierList(n,1)=2/T*integral(@(t)func(t).*sin(2*pi*(n-1)./T.*t),t0,t0+T);
     coeffFourierList(n,2)=2/T*integral(@(t)func(t).*cos(2*pi*(n-1)./T.*t),t0,t0+T);
end

%Reconstructing the signal from the Fourier components
for i=1:length(timeRList)
    funcRList(i)=coeffFourierList(1,2)/2;
    for n=2:length(coeffFourierList)
    funcRList(i)=funcRList(i)+coeffFourierList(n,1)*sin(2*pi*(n-1)/T*timeRList(i))+coeffFourierList(n,2)*cos(2*pi*(n-1)/T*timeRList(i));
    end
end