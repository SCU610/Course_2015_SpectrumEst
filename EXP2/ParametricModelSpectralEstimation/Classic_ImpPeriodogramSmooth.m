function [PowSpectrum,NorFreq] = Classic_ImpPeriodogramSmooth( SignalIn,SignalLength,WindowSize,WindowType,UnitType )
%FileName: Classic_ImpPeriodogramSmooth.m
%Description: ��ƽ�����Ľ�������ͼ��
if size(SignalIn,2)>1   %�����ź���������1����
    error(message('Error! Invaild Input Signal Demension @ Function:"Classic_ImpPeriodogramSmooth.m"'));
end
InputSignal=SignalIn(1:SignalLength,1);
[InitialPowSpectrum,NorFreq]=Classic_Periodogram(InputSignal,SignalLength,0);
SignalAutoCorr=ifft(InitialPowSpectrum);
WindowCoeffX=Assist_WindowSelect(WindowType,WindowSize);
WindowCoeff=abs(ifft(WindowCoeffX,size(InitialPowSpectrum,1))).*(size(InitialPowSpectrum,1)/WindowSize);
WinSignalAutoCorr=SignalAutoCorr.*WindowCoeff;
PowSpectrum=abs(fft(WinSignalAutoCorr,size(InitialPowSpectrum,1)));
if strcmp(UnitType,'dB')||strcmp(UnitType,'d')||strcmp(UnitType,'db')
    PowSpectrum=10*log10(PowSpectrum);
end
end

