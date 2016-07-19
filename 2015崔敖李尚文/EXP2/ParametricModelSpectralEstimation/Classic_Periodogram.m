function [PowSpectrum,NorFreq] = Classic_Periodogram(SignalIn,SignalLength,UnitType)
%FileName: Classic_Periodogram.m
%Description: ʹ�þ�������ͼ�����������źŵĹ�����
%   ��������: �����źţ�������С
%   �������: ����õĹ����׺͹�һ��Ƶ��
if size(SignalIn,2)>1   %�����ź���������1����
    error(message('Error! Invaild Input Signal Demension @ Function:"Classic_Periodogram.m"'));
end
InputSignal=SignalIn(1:SignalLength,1);   %�����źżӴ�
SignalDFT=fft(InputSignal,2^nextpow2(SignalLength));%/(2^nextpow2(WindowSize)); %��FFT�����źŵ�DFT��FFT����Ϊ������Сֵ����һ��2����������ֵ
PowSpectrum=abs(SignalDFT).^2/(SignalLength);                                     %���㹦����
NorFreq=0:1/(2^nextpow2(SignalLength)):(1-1/(2^nextpow2(SignalLength)));        %�����һ��Ƶ��
NorFreq=NorFreq';
if strcmp(UnitType,'dB')||strcmp(UnitType,'d')||strcmp(UnitType,'db')
    PowSpectrum=10*log10(PowSpectrum);
end
end

