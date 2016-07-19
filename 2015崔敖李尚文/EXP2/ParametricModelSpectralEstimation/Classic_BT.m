function [PowSpectrum,NorFreq] = Classic_BT(SignalIn,SignalLength,UnitType)
%FileName: Classic_BT.m
%Description: 使用经典BT法计算输入信号的功率谱
%   函数输入: 输入信号，开窗大小
%   函数输出: 计算好的功率谱和归一化频率
if size(SignalIn,2)>1   %输入信号列数大于1报错
    error(message('Error! Invaild Input Signal Demension @ Function:"Classic_BT.m"'));
end
InputSignal=SignalIn(1:SignalLength,1);   %输入信号加窗
SignalAutoCorr=xcorr(InputSignal,'biased');     %计算加窗信号的自相关函数
PowSpectrum=abs(fft(SignalAutoCorr,2^nextpow2(size(SignalAutoCorr,1))));%2^nextpow2(size(SignalAutoCorr,1)));     %利用FFT计算自相关函数的DFT，FFT长度为自相关函数长度的下一个2的整数次幂
NorFreq=0:1/(2^nextpow2(size(SignalAutoCorr,1))):(1-1/(2^nextpow2(size(SignalAutoCorr,1))));    %计算归一化频率
NorFreq=NorFreq';
if strcmp(UnitType,'dB')||strcmp(UnitType,'d')||strcmp(UnitType,'db')
    PowSpectrum=10*log10(PowSpectrum);
end
end

