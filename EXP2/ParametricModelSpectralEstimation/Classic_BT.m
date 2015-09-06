function [PowSpectrum,NorFreq] = Classic_BT(SignalIn,SignalLength,UnitType)
%FileName: Classic_BT.m
%Description: ʹ�þ���BT�����������źŵĹ�����
%   ��������: �����źţ�������С
%   �������: ����õĹ����׺͹�һ��Ƶ��
if size(SignalIn,2)>1   %�����ź���������1����
    error(message('Error! Invaild Input Signal Demension @ Function:"Classic_BT.m"'));
end
InputSignal=SignalIn(1:SignalLength,1);   %�����źżӴ�
SignalAutoCorr=xcorr(InputSignal,'biased');     %����Ӵ��źŵ�����غ���
PowSpectrum=abs(fft(SignalAutoCorr,2^nextpow2(size(SignalAutoCorr,1))));%2^nextpow2(size(SignalAutoCorr,1)));     %����FFT��������غ�����DFT��FFT����Ϊ����غ������ȵ���һ��2����������
NorFreq=0:1/(2^nextpow2(size(SignalAutoCorr,1))):(1-1/(2^nextpow2(size(SignalAutoCorr,1))));    %�����һ��Ƶ��
NorFreq=NorFreq';
if strcmp(UnitType,'dB')||strcmp(UnitType,'d')||strcmp(UnitType,'db')
    PowSpectrum=10*log10(PowSpectrum);
end
end

