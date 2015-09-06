function [PowSpectrum,NorFreq] = Classic_Periodogram(SignalIn,SignalLength,UnitType)
%FileName: Classic_Periodogram.m
%Description: 使用经典周期图法计算输入信号的功率谱
%   函数输入: 输入信号，开窗大小
%   函数输出: 计算好的功率谱和归一化频率
if size(SignalIn,2)>1   %输入信号列数大于1报错
    error(message('Error! Invaild Input Signal Demension @ Function:"Classic_Periodogram.m"'));
end
InputSignal=SignalIn(1:SignalLength,1);   %输入信号加窗
SignalDFT=fft(InputSignal,2^nextpow2(SignalLength));%/(2^nextpow2(WindowSize)); %用FFT计算信号的DFT，FFT长度为开窗大小值的下一个2的整数次幂值
PowSpectrum=abs(SignalDFT).^2/(SignalLength);                                     %计算功率谱
NorFreq=0:1/(2^nextpow2(SignalLength)):(1-1/(2^nextpow2(SignalLength)));        %计算归一化频率
NorFreq=NorFreq';
if strcmp(UnitType,'dB')||strcmp(UnitType,'d')||strcmp(UnitType,'db')
    PowSpectrum=10*log10(PowSpectrum);
end
end

