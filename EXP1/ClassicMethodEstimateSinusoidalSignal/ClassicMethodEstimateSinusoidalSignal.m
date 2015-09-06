%FIleName: ClassicMethodEstimateSinusoidalSignal.m
%
%���þ����׹��Ƽ���Ľ������������ݳ��������ź�
%�Ĺ����ף�ͨ����������������

%�ź�1������˹��������Ⱦ�����������ź�
%f1=0.21        SNR1=10dB
%f2=0.23        SNR2=15dB
%xk=a1*sin(2*pi*f1*k+p1)+a2*sin(2*pi*f2*k+p2)+wk
%p1,p2Ϊ[0,2*pi]���ȷֲ����������wkΪ��˹������
clear;
%% Experiment Parameters Settings
SampleNum=20000;        %�趨�źŲ�������
SineSigFreq1=0.21;      %�趨�����ź�1������Ƶ��
SineSigSNR1=10;         %�趨�����ź�1�������dB
SineSigFreq2=0.23;      %�趨�����ź�2������Ƶ��
SineSigSNR2=15;         %�趨�����ź�2�������dB
NoiseNorPow=0;          %�趨������һ������dB
%% Initiation
SineSigAmp1=sqrt(10^((SineSigSNR1+NoiseNorPow)/10)/0.5);    %�����趨�õ�����ȼ��������ź�1�ķ���
SineSigAmp2=sqrt(10^((SineSigSNR2+NoiseNorPow)/10)/0.5);    %�����趨�õ�����ȼ��������ź�2�ķ���
PhaseShift1=2*pi*rand;
PhaseShift2=2*pi*rand;
NoiseSig=wgn(SampleNum,1,NoiseNorPow);                      %�������������������ʲ�����������
Index=1;
while (Index<=SampleNum)                                    %���������źŷ��ȣ�����Ƶ�ʲ��������ź�
    InputPureSignal(Index,:)=SineSigAmp1*sin(2*pi*SineSigFreq1*(Index-1)+PhaseShift1) ...
                                    +SineSigAmp2*sin(2*pi*SineSigFreq2*(Index-1)+PhaseShift2);
    Index=Index+1;
end
InputSignal=InputPureSignal+NoiseSig;           %������������ʵ���ź�
PowReal=mse(InputSignal);                       %ʵ���źŹ���

[P_IPDA_HANN_OL_64_PSD,P_IPDA_HANN_OL_64_FREQ,Num64]=ImpPeriodogramAver(InputSignal,64,16,8,'hann','db');
[P_IPDA_HANN_OL_256_PSD,P_IPDA_HANN_OL_256_FREQ,Num256]=ImpPeriodogramAver(InputSignal,256,32,16,'hann','db');
[P_IPDA_HANN_OL_512_PSD,P_IPDA_HANN_OL_512_FREQ,Num512]=ImpPeriodogramAver(InputSignal,512,64,32,'hann','db');
[P_IPDA_HANN_OL_2048_PSD,P_IPDA_HANN_OL_2048_FREQ,Num2048]=ImpPeriodogramAver(InputSignal,2048,256,128,'hann','db');

Index=1;
Ang=0;
while Ang<=1
    if fix(Ang*100)==SineSigFreq1*100||fix(Ang*100)==(1-SineSigFreq1)*100
        PSDStd(Index,1)=SineSigSNR1+NoiseNorPow;
    elseif fix(Ang*100)==SineSigFreq2*100||fix(Ang*100)==(1-SineSigFreq2)*100
        PSDStd(Index,1)=SineSigSNR2+NoiseNorPow;
    else
        PSDStd(Index,1)=NoiseNorPow;
    end
    WStd(Index,1)=Ang;
    Ang=Ang+0.01;
    Index=Index+1;
end